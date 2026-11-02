# snapshot tests

    Code
      find_grains(sandworm.file, threshold = 200, plot = FALSE)
    Output
      Load image file sandworm_rf_median.tif into system memory.
      Created circular ROI mask with edge length 13 containing 113 pixels.
      Apply FFT band-pass 6 - 24 px 
      Use an intensity threshold of 200 px/cts.
      8 grains found in 11 iterations.
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
      

---

    Code
      find_grains(sandworm.file, grain.density = 0.005, plot = FALSE)
    Output
      Load image file sandworm_rf_median.tif into system memory.
      Created circular ROI mask with edge length 13 containing 113 pixels.
      Apply FFT band-pass 6 - 24 px 
      Calculate threshold for  0.5 % grain density: 181.1  px/cts.
      8 grains found in 13 iterations.
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
      

