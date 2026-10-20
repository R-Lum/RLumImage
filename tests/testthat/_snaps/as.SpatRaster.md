# snapshot tests

    Code
      as.SpatRaster(sandworm.file)
    Output
      Load image file sandworm_rf_median.tif into system memory.
      class       : SpatRaster
      size        : 512, 512, 1  (nrow, ncol, nlyr)
      resolution  : 1, 1  (x, y)
      extent      : 0, 512, 0, 512  (xmin, xmax, ymin, ymax)
      coord. ref. : 
      source      : sandworm_rf_median.tif
      name        :      median
      min value   :   -0.833333
      max value   : 1633.083374

---

    Code
      as.SpatRaster(1:13)
    Output
      Convert numeric vector into single-layer square-shaped terra::spatRaster image.
      class       : SpatRaster
      size        : 3, 3, 1  (nrow, ncol, nlyr)
      resolution  : 1, 1  (x, y)
      extent      : 0, 3, 0, 3  (xmin, xmax, ymin, ymax)
      coord. ref. : 
      source(s)   : memory
      name        : lyr.1
      min value   :     1
      max value   :     9

---

    Code
      as.SpatRaster(matrix(1:4, nrow = 2))
    Output
      Convert array into terra::spatRaster image.
      class       : SpatRaster
      size        : 2, 2, 1  (nrow, ncol, nlyr)
      resolution  : 1, 1  (x, y)
      extent      : 0, 2, 0, 2  (xmin, xmax, ymin, ymax)
      coord. ref. : 
      source(s)   : memory
      name        : lyr.1
      min value   :     1
      max value   :     4

