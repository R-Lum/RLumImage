# snapshot tests

    Code
      find_grains(sandworm.file, threshold = 100, plot = FALSE)
    Output
      Load image file sandworm_rf_median.tif into system memory.
      Created circular ROI mask with edge length 13 containing 113 pixels.
      Apply FFT band-pass 6 - 24 px 
      Use an intensity threshold of 100 px/cts.
      14 grains found in 39 iterations.
      $ROI_1
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (385, 307)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_2
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (229, 286)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_3
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (377, 213)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_4
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (321, 302)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_5
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (356, 279)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_6
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (209, 274)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_7
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (315, 212)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_8
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (291, 321)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_9
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (303, 267)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_10
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (231, 129)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_11
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (238, 204)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_12
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (280, 150)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_13
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (165, 196)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_14
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (331, 263)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      

---

    Code
      find_grains(sandworm.file, grain.density = 0.01, plot = FALSE)
    Output
      Load image file sandworm_rf_median.tif into system memory.
      Created circular ROI mask with edge length 13 containing 113 pixels.
      Apply FFT band-pass 6 - 24 px 
      Calculate threshold for  1 % grain density: 99.17  px/cts.
      15 grains found in 40 iterations.
      $ROI_1
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (385, 307)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_2
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (229, 286)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_3
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (377, 213)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_4
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (321, 302)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_5
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (356, 279)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_6
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (209, 274)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_7
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (315, 212)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_8
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (291, 321)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_9
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (303, 267)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_10
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (231, 129)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_11
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (238, 204)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_12
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (280, 150)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_13
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (165, 196)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_14
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (157, 256)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      
      $ROI_15
      [RLumImage.ROI]
      	 shape: circle
      	 bounding box: 13 x 13 px at (331, 263)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 6
      

