# snapshot tests

    Code
      set_roi(mask = matrix(rep(TRUE, 16), ncol = 4), col_min = 42, row_min = 67)
    Output
      [RLumImage.ROI]
      	 shape: rectangle
      	 bounding box: 4 x 4 px at (42, 67)
      	 number of curves: 0
      	 mineral class: Unclassified
      	 additional info elements: 1

---

    Code
      set_roi(roi, add.curve = data.frame(x = 1:10, y = (12:3)^1.5), add.info = c(
        other = "info"), source.image = sandworm.file, class = "arbitrary")
    Output
      Load image file sandworm_rf_median.tif into system memory.
      [RLumImage.ROI]
      	 shape: rectangle
      	 bounding box: 5 x 5 px at (42, 67)
      	 number of curves: 2
      	 mineral class: arbitrary
      	 additional info elements: 6

