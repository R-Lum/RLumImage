# RLumImage

RLum network package for luminescence image processing.

## ToDo's

Features needed before release:

- Collect small example data sets (TIF/XSYG) of a OSL, TL and RF measurement, add to repository and refer ALL code examples and module tests to them

- Get a Risö Reader EMCCD data set and implement its import

- Enhance internal data structure to hand over meta data and processing history

- Set-up a working Quarto script which uses all (important) functions

## Current development status

(2026-09-26)

| Function | Description |
|------------------------------------|------------------------------------|
| `import_lexsyg_images` | Reads a *Freiberg Instruments lexsyg* measurement file (\*.xsyg) using `Luminescence::read_XSYG2R`. Relates the meta data of the recorded steps to those image files in the same folder whose time stamps match the records. |
| `align_images` | Automatically estimates the horizontal shift, vertical shift, and rotation angle that best aligns a 'moving' single-layer image onto a 'fixed' one, using image correlation and `optim()`. |
| `apply_fft_filter` | Applies a Fast Fourier Transform (FFT) filter to one or multiple grey-scale image layers, acting as a short-pass, long-pass, or band-pass filter on spatial frequencies. Filter edges are smoothed with a cosine taper. Can be used, e.g., to remove signal cross-talk between grains. |
| `apply_image_alignment` | Applies the shift/rotation parameters estimated by `align_images` to a full image stack. |
| `apply_median_grouping` | Combines every *N* images of a stack into a median image. This removes X-ray speckles in RF images and reduces the amount of data. |
| `apply_rois` | Extracts mean values within circular regions of interest (ROIs) across an image stack and optionally plots the resulting time series. |
| `as.SpatRaster` | Converts file paths, arrays, matrices to a `terra::spatRaster` object. Is just a simple wrapper for `terra::rast()` but ensures image validity inside RLumImage environment. |
| `convert_rois2RLum` | Converts a ROI list (as returned by `apply_rois()` / `set_roi()`) into a named list of `Luminescence::RLum.Analysis` objects. Every curve in `rois$curves` is converted into an `RLum.Data.Curve` object stored in the `@records` slot; the ROI's mineral `class` is kept in the analysis `info`. |
| `find_grains` | Automatically detects single grains (local signal maxima) in an image. It FFT-filters the image via `apply_fft_filter()` to smooth grain-like structures, then iteratively finds the pixel of maximum signal, defines a circular ROI around it, and removes it before searching for the next maximum. Grains are kept only if their mean signal within the ROI exceeds the estimated local background by a given `threshold` (or a threshold derived from a target `grain.density`). Returns ROIs in the format of `set_roi()` / `apply_rois()`. |
| `get_image_scale` | Returns recommended lower and upper signal value boundary for plotting one or multiple images of a stack. Helper function for plotting functions. |
| `get_sections` | Returns and plots single columns or rows (lines) of an image stack. |
| `get_sequence` | Extracts the sequence table of an imported imaging measurement. Measurement duration is calculated from the actual time difference between first and last images rather than the theoretical sequence duration, which can reveal issues with acquisition or image-sequence assignment. |
| `plot_image` | Plots one or multiple images. Is just a wrapper for `terra::plot` but adds some extra fluff like optional colouring depending on the acquisition wavelength, and can overlay circular ROIs (with class colours and optional ID numbers). |
| `plot_image_difference` | Computes and plots the pixel-wise difference between two images (objA - objB) using `plot_image`. |
| `rescale_image` | Zooms in or out or moves an image's centre while maintaining its dimensions. Works also with image stacks. |
| `rotate_image` | Rotates an image while maintaining its dimensions. Works also with image stacks. |
| `select_grains` | Opens a shiny app that lets the user place circular ROIs on a reference image (combined as the pixel-wise mean of the stack), assign a mineral class to each, and optionally detect grains automatically via `find_grains()`. Returns per-grain ROI objects in the format of `set_roi()` / `apply_rois()`. |
| `set_roi` | Creates a new region-of-interest (ROI) object (pixel `mask`, position, `shape`, mineral `class`, optional `info`/`overlay`/`curves`) or edits an existing one. Underlies the ROI objects used by `apply_rois()`, `find_grains()` and `select_grains()`. |
| `shift_image` | Shifts an image's position while maintaining its dimensions. Works also with image stacks. |
| `wavelength_to_rgb` | Converts a wavelength into an RGB value. Helper function for plotting functions. |
| `write_rf_table` | Saves single-grain IR-RF measurements as a `*.rf` file (Mittelstrass & Kreutzer 2021) with `<Statistics>`, `<Natural>` and `<Bleached>` blocks. Draws on natural and bleached dose curves stored in a list of ROIs (as returned by `apply_rois()`) and can be filtered by mineral class. Open the file with `Luminescence::read_RF2R()`. |

## Funding

The work on `'RLumImage'` is supported through the DFG project “ARENICOLA:
Advanced RadiofluorescENce Imaging and grain Classification in Luminescence
Applications” [No 528704761](https://gepris.dfg.de/project/553815036?lang=en)
led by Dr Sebastian Kreutzer (PI at the LIAG Institute for Applied Geophysics,
Hannover, Germany) and Dr Margret Fuchs (PI at the Helmholtz Institute Freiberg
for Resource Technology (HIF), Freiberg, Germany).
