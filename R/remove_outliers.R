#' Remove local signal peaks (outlier) caused by cosmic rays or bremsstrahlung from images
#' 
#' @description
#' The algorithm calculates a map of local signal noise estimates. Signal deviations 
#' of single pixels which exceed 'n.sigma' times the estimated local noise, get 
#' replaced by a local median value. The algorithm is inspired by the L.A. Cosmic algorithm 
#' described in *van Dokkum (2001)* yet more simple (no Laplacian transformation) but
#' also less robust against misinterpreting very bright local signal for outliers.
#' Algorithm (applied to each layer of the input stack independently):
#'   1. Reference image: median filter (win x win) of the current image.
#'   2. Residual = image - reference.
#'   3. Noise sigma, determined once per layer (first iteration) and reused:
#'        - sigma_global = NA: local sigma = 1.4826 * MAD of the residual in an
#'          11 x 11 window (follows signal-dependent photon noise), bounded below
#'          by half the layer-wide MAD sigma. A rough layer-wide noise estimate is
#'          printed to the console (not used).
#'        - sigma_global given: constant sigma, MAD filter is skipped (faster,
#'          reproducible across datasets, but does not follow the signal level
#'          and may flag bright, real sources as outliers).
#'   4. Pixels with residual > nsigma * sigma are flagged as outliers.
#'      Flagged pixels are replaced by the median reference value.
#'   5. Steps 1-4 are repeated up to three times, so that outliers next to other outliers
#'      are also found.
#'      
#' *Note*: For low resolution images, the algorithm might take bright local luminescence
#' signals for outliers and removes them. In such cases, reduce 'window.mad' and
#' enlarge 'n.sigma'.
#' 
#'
#' @param obj 
#' @param n.sigma 
#' @param sigma.global 
#' @param window.smooth 
#' @param window.mad 
#' 
#' @param plot.process
#' Whether to plot images which display intermediate steps in the outlier correction
#' process (`FALSE` by default). It is ignored if `plot = FALSE`.
#' 
#' @param plot.result
#' Whether to plot the filtered image (or first image in a stack) with [plot_image] (`FALSE` by default).
#'
#' @param verbose
#' Whether progress messages should be printed to the terminal.
#' 
#' @references 
#' van Dokkum, P. G. (2001): Cosmic-Ray Rejection by Laplacian Edge Detection. 
#' Publications of the Astronomical Society of the Pacific, 113, 1420–1427. 
#' DOI: 10.1086/323894.
#'
#' @return
#' An image stack.
#'
#' @examples
#' # TODO
#'
#' @export
remove_outliers <- function(
    obj,
    n.sigma = 10, # clipping threshold in units of local noise standard deviation (sigma)
    sigma.global = NA, # known noise in counts/pixel; NA = estimate locally (MAD filter)
    window.smooth = 5, # median filter window size (odd); should exceed CR track width
    window.mad = 11, # Median Absolute Deviation (MAD) windows size for estimating local noise sigma
    pixel.bleeding = FALSE,
    plot.process = FALSE,
    plot.result = FALSE,
    verbose = TRUE
){
 
  ## Changelog
  ## 2026-11-05, DM, Claude Sonnet 5.5: Original version
  ## 2026-11-27, DM: Migrated to RLumImage; added plots and small code improvements
  ## 
  ## ToDo
  ## - Improve performance! Potential approaches:
  ##    o implement parallel computing (easiest approach)
  ##    o replace costly terra::focal() calls
  ##    o Reuse sigma map and/or median map for next image but test 
  ##      old maps for validity (maybe via a sign-test?)
  ## - 
  
  # Internal parameters
  n_iter <- 3   # iterations (also finds CRs next to other CRs)

  imgs <- as.SpatRaster(obj, verbose = verbose)
  
  if (verbose) cat("Remove outliers...")

  # For statistics only
  average_sigma <- c()
  n_all <- 0
  
  # For plotting
  plot_sigma_map <- NULL
  plot_img_raw <- NULL
  plot_img_corrected <- NULL
  
  # Process each layer independently
  for (i in 1:terra::nlyr(imgs)) {  # -----------------------------
    
    img <- imgs[[i]] # current work image
    n_outliers <- 0 
    
    # Repeat search for outliers to detect outliers nearby outliers. 
    # However, the most computing heavy operation (sigma map calculation) is
    # done only once per image
    for (j in 1:3) {
      
      # Smooth image by a running median in a w x w window
      med <- terra::focal(img,
                          w = window.smooth, 
                          fun = "median",
                          na.rm = TRUE, expand = TRUE)
      
      # Calc residual image
      resid <- img - med
      
      # The map of Local noise level is determined once per layer and then reused
      # as this the most computing heavy step and it should no change that 
      # much if only a few pixels are removed
      if (j == 1) {
        if (is.na(sigma.global)) {
          
          # Local robust noise estimate: 1.4826 * MAD ~ sigma for Gaussian noise.
          # Local, because photon noise grows with the signal; a single global
          # sigma would flag bright grains as outliers.
          absres    <- abs(resid)
          sigma_map <- 1.4826 * terra::focal(absres, 
                                             w = window.mad, 
                                             fun = "median",
                                             na.rm = TRUE, 
                                             expand = TRUE)
          
          # Use the average noise as lower boundary to prevent misinterpreting
          # too low 'n.sigma' values as sufficient just because some flat border
          # areas were successfully cleaned
          sigma_med <- median(terra::values(absres), na.rm = TRUE)
          sigma_map <- max(sigma_map, sigma_med)
          
          # Remember sigma statistics and first map for later plotting
          average_sigma <- c(average_sigma, sigma_med)
          if (plot.process && i == 1) plot_sigma_map <- sigma_map
          
        } else {
          
          # known noise: skip the expensive MAD filter
          sigma_map <- sigma.global           
        }
      }
      
      # Now use the noise map to detect the outliers
      new_outliers <- resid > n.sigma * sigma_map
      n_new  <- terra::global(new_outliers, "sum", na.rm = TRUE)[[1]]
      if (n_new == 0) break
      
      n_outliers <- n_outliers + n_new
      
      # Grow the detection (outlier edges "bleed") and replace flagged pixels.
      # Pixels corrected in earlier iterations are kept
      if (pixel.bleeding) {
        new_outliers <- 0 < terra::focal(new_outliers, 
                                         w = 3, # 3x3 window
                                         fun = "max", 
                                         na.rm = TRUE,
                                         expand = TRUE)
      }
    }
    
    n_all <- n_all + n_outliers
    
    # Replace marked outlier pixels by local median
    imgs[[i]] <- terra::ifel(new_outliers, med, img)
    
    # Keep some work images for plotting later
    if (plot.process && i == 1) plot_img_raw <- img
    if ((plot.process || plot.result) && i == 1) plot_img_corrected <- imgs[[i]]
    
    
    
  } # ------ end loop --------
  
    
  if (verbose) {
    cat("DONE\n")
    cat("Detected", n_all, "outlier pixels in", i, "images.\n")
    cat("Average noise level:", round(mean(average_sigma), 2), "+-", round(sd(average_sigma), 2), "cts/px.\n")
    
  }
  
  if (plot.process) {
    
    # Use same signal range for all images despite sigma map
    signal_range <- get_signal_range(plot_img_raw, 
                                     contains.outlier = TRUE,
                                     verbose = FALSE)
    # Raw image
    label <- ""
    if (terra::nlyr(imgs) > 1) label <- "First image"
    plot_image(plot_img_raw, 
               range = signal_range, 
               contains.outlier = TRUE,
               title = "Input image",
               label = label)
    
    
    
    plot_image(sigma_map, 
               contains.outlier = FALSE,
               title = "Local noise level map")

    # Difference map .. not that
    ##plot_image(new_outliers, range = c(0,1), title = "")
    }
  
  if (plot.result) {
    plot_image(plot_img_corrected, 
               contains.outlier = FALSE)
  }
   
  return(imgs) 

}