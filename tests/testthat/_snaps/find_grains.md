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
      $ROI_1$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_1$col_min
      [1] 385
      
      $ROI_1$row_min
      [1] 307
      
      $ROI_1$shape
      [1] "circle"
      
      $ROI_1$class
      [1] "Unclassified"
      
      $ROI_1$info
      $ROI_1$info$source_function
      [1] "find_grains"
      
      $ROI_1$info$source_obj
      [1] "sandworm.file"
      
      $ROI_1$info$source_ncols
      [1] 512
      
      $ROI_1$info$source_nrows
      [1] 512
      
      $ROI_1$info$average
      [1] 855.1412
      
      $ROI_1$info$fft_max
      [1] 900.8482
      
      
      $ROI_1$overlay
      $ROI_1$overlay$x
      [1] 390.5
      
      $ROI_1$overlay$y
      [1] 199.5
      
      $ROI_1$overlay$r
      [1] 6
      
      
      $ROI_1$curves
      list()
      
      
      $ROI_2
      $ROI_2$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_2$col_min
      [1] 229
      
      $ROI_2$row_min
      [1] 286
      
      $ROI_2$shape
      [1] "circle"
      
      $ROI_2$class
      [1] "Unclassified"
      
      $ROI_2$info
      $ROI_2$info$source_function
      [1] "find_grains"
      
      $ROI_2$info$source_obj
      [1] "sandworm.file"
      
      $ROI_2$info$source_ncols
      [1] 512
      
      $ROI_2$info$source_nrows
      [1] 512
      
      $ROI_2$info$average
      [1] 384.0162
      
      $ROI_2$info$fft_max
      [1] 415.8744
      
      
      $ROI_2$overlay
      $ROI_2$overlay$x
      [1] 234.5
      
      $ROI_2$overlay$y
      [1] 220.5
      
      $ROI_2$overlay$r
      [1] 6
      
      
      $ROI_2$curves
      list()
      
      
      $ROI_3
      $ROI_3$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_3$col_min
      [1] 377
      
      $ROI_3$row_min
      [1] 213
      
      $ROI_3$shape
      [1] "circle"
      
      $ROI_3$class
      [1] "Unclassified"
      
      $ROI_3$info
      $ROI_3$info$source_function
      [1] "find_grains"
      
      $ROI_3$info$source_obj
      [1] "sandworm.file"
      
      $ROI_3$info$source_ncols
      [1] 512
      
      $ROI_3$info$source_nrows
      [1] 512
      
      $ROI_3$info$average
      [1] 347.997
      
      $ROI_3$info$fft_max
      [1] 381.498
      
      
      $ROI_3$overlay
      $ROI_3$overlay$x
      [1] 382.5
      
      $ROI_3$overlay$y
      [1] 293.5
      
      $ROI_3$overlay$r
      [1] 6
      
      
      $ROI_3$curves
      list()
      
      
      $ROI_4
      $ROI_4$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_4$col_min
      [1] 321
      
      $ROI_4$row_min
      [1] 302
      
      $ROI_4$shape
      [1] "circle"
      
      $ROI_4$class
      [1] "Unclassified"
      
      $ROI_4$info
      $ROI_4$info$source_function
      [1] "find_grains"
      
      $ROI_4$info$source_obj
      [1] "sandworm.file"
      
      $ROI_4$info$source_ncols
      [1] 512
      
      $ROI_4$info$source_nrows
      [1] 512
      
      $ROI_4$info$average
      [1] 335.7301
      
      $ROI_4$info$fft_max
      [1] 257.7178
      
      
      $ROI_4$overlay
      $ROI_4$overlay$x
      [1] 326.5
      
      $ROI_4$overlay$y
      [1] 204.5
      
      $ROI_4$overlay$r
      [1] 6
      
      
      $ROI_4$curves
      list()
      
      
      $ROI_5
      $ROI_5$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_5$col_min
      [1] 356
      
      $ROI_5$row_min
      [1] 279
      
      $ROI_5$shape
      [1] "circle"
      
      $ROI_5$class
      [1] "Unclassified"
      
      $ROI_5$info
      $ROI_5$info$source_function
      [1] "find_grains"
      
      $ROI_5$info$source_obj
      [1] "sandworm.file"
      
      $ROI_5$info$source_ncols
      [1] 512
      
      $ROI_5$info$source_nrows
      [1] 512
      
      $ROI_5$info$average
      [1] 329.7378
      
      $ROI_5$info$fft_max
      [1] 243.1392
      
      
      $ROI_5$overlay
      $ROI_5$overlay$x
      [1] 361.5
      
      $ROI_5$overlay$y
      [1] 227.5
      
      $ROI_5$overlay$r
      [1] 6
      
      
      $ROI_5$curves
      list()
      
      
      $ROI_6
      $ROI_6$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_6$col_min
      [1] 209
      
      $ROI_6$row_min
      [1] 274
      
      $ROI_6$shape
      [1] "circle"
      
      $ROI_6$class
      [1] "Unclassified"
      
      $ROI_6$info
      $ROI_6$info$source_function
      [1] "find_grains"
      
      $ROI_6$info$source_obj
      [1] "sandworm.file"
      
      $ROI_6$info$source_ncols
      [1] 512
      
      $ROI_6$info$source_nrows
      [1] 512
      
      $ROI_6$info$average
      [1] 304.5487
      
      $ROI_6$info$fft_max
      [1] 426.6962
      
      
      $ROI_6$overlay
      $ROI_6$overlay$x
      [1] 214.5
      
      $ROI_6$overlay$y
      [1] 232.5
      
      $ROI_6$overlay$r
      [1] 6
      
      
      $ROI_6$curves
      list()
      
      
      $ROI_7
      $ROI_7$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_7$col_min
      [1] 315
      
      $ROI_7$row_min
      [1] 212
      
      $ROI_7$shape
      [1] "circle"
      
      $ROI_7$class
      [1] "Unclassified"
      
      $ROI_7$info
      $ROI_7$info$source_function
      [1] "find_grains"
      
      $ROI_7$info$source_obj
      [1] "sandworm.file"
      
      $ROI_7$info$source_ncols
      [1] 512
      
      $ROI_7$info$source_nrows
      [1] 512
      
      $ROI_7$info$average
      [1] 294.7563
      
      $ROI_7$info$fft_max
      [1] 270.8193
      
      
      $ROI_7$overlay
      $ROI_7$overlay$x
      [1] 320.5
      
      $ROI_7$overlay$y
      [1] 294.5
      
      $ROI_7$overlay$r
      [1] 6
      
      
      $ROI_7$curves
      list()
      
      
      $ROI_8
      $ROI_8$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_8$col_min
      [1] 291
      
      $ROI_8$row_min
      [1] 321
      
      $ROI_8$shape
      [1] "circle"
      
      $ROI_8$class
      [1] "Unclassified"
      
      $ROI_8$info
      $ROI_8$info$source_function
      [1] "find_grains"
      
      $ROI_8$info$source_obj
      [1] "sandworm.file"
      
      $ROI_8$info$source_ncols
      [1] 512
      
      $ROI_8$info$source_nrows
      [1] 512
      
      $ROI_8$info$average
      [1] 270.3695
      
      $ROI_8$info$fft_max
      [1] 253.1478
      
      
      $ROI_8$overlay
      $ROI_8$overlay$x
      [1] 296.5
      
      $ROI_8$overlay$y
      [1] 185.5
      
      $ROI_8$overlay$r
      [1] 6
      
      
      $ROI_8$curves
      list()
      
      
      $ROI_9
      $ROI_9$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_9$col_min
      [1] 303
      
      $ROI_9$row_min
      [1] 267
      
      $ROI_9$shape
      [1] "circle"
      
      $ROI_9$class
      [1] "Unclassified"
      
      $ROI_9$info
      $ROI_9$info$source_function
      [1] "find_grains"
      
      $ROI_9$info$source_obj
      [1] "sandworm.file"
      
      $ROI_9$info$source_ncols
      [1] 512
      
      $ROI_9$info$source_nrows
      [1] 512
      
      $ROI_9$info$average
      [1] 205.6984
      
      $ROI_9$info$fft_max
      [1] 179.6296
      
      
      $ROI_9$overlay
      $ROI_9$overlay$x
      [1] 308.5
      
      $ROI_9$overlay$y
      [1] 239.5
      
      $ROI_9$overlay$r
      [1] 6
      
      
      $ROI_9$curves
      list()
      
      
      $ROI_10
      $ROI_10$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_10$col_min
      [1] 231
      
      $ROI_10$row_min
      [1] 129
      
      $ROI_10$shape
      [1] "circle"
      
      $ROI_10$class
      [1] "Unclassified"
      
      $ROI_10$info
      $ROI_10$info$source_function
      [1] "find_grains"
      
      $ROI_10$info$source_obj
      [1] "sandworm.file"
      
      $ROI_10$info$source_ncols
      [1] 512
      
      $ROI_10$info$source_nrows
      [1] 512
      
      $ROI_10$info$average
      [1] 160.4624
      
      $ROI_10$info$fft_max
      [1] 170.1141
      
      
      $ROI_10$overlay
      $ROI_10$overlay$x
      [1] 236.5
      
      $ROI_10$overlay$y
      [1] 377.5
      
      $ROI_10$overlay$r
      [1] 6
      
      
      $ROI_10$curves
      list()
      
      
      $ROI_11
      $ROI_11$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_11$col_min
      [1] 238
      
      $ROI_11$row_min
      [1] 204
      
      $ROI_11$shape
      [1] "circle"
      
      $ROI_11$class
      [1] "Unclassified"
      
      $ROI_11$info
      $ROI_11$info$source_function
      [1] "find_grains"
      
      $ROI_11$info$source_obj
      [1] "sandworm.file"
      
      $ROI_11$info$source_ncols
      [1] 512
      
      $ROI_11$info$source_nrows
      [1] 512
      
      $ROI_11$info$average
      [1] 156.0177
      
      $ROI_11$info$fft_max
      [1] 206.1395
      
      
      $ROI_11$overlay
      $ROI_11$overlay$x
      [1] 243.5
      
      $ROI_11$overlay$y
      [1] 302.5
      
      $ROI_11$overlay$r
      [1] 6
      
      
      $ROI_11$curves
      list()
      
      
      $ROI_12
      $ROI_12$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_12$col_min
      [1] 280
      
      $ROI_12$row_min
      [1] 150
      
      $ROI_12$shape
      [1] "circle"
      
      $ROI_12$class
      [1] "Unclassified"
      
      $ROI_12$info
      $ROI_12$info$source_function
      [1] "find_grains"
      
      $ROI_12$info$source_obj
      [1] "sandworm.file"
      
      $ROI_12$info$source_ncols
      [1] 512
      
      $ROI_12$info$source_nrows
      [1] 512
      
      $ROI_12$info$average
      [1] 132.9038
      
      $ROI_12$info$fft_max
      [1] 179.7526
      
      
      $ROI_12$overlay
      $ROI_12$overlay$x
      [1] 285.5
      
      $ROI_12$overlay$y
      [1] 356.5
      
      $ROI_12$overlay$r
      [1] 6
      
      
      $ROI_12$curves
      list()
      
      
      $ROI_13
      $ROI_13$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_13$col_min
      [1] 165
      
      $ROI_13$row_min
      [1] 196
      
      $ROI_13$shape
      [1] "circle"
      
      $ROI_13$class
      [1] "Unclassified"
      
      $ROI_13$info
      $ROI_13$info$source_function
      [1] "find_grains"
      
      $ROI_13$info$source_obj
      [1] "sandworm.file"
      
      $ROI_13$info$source_ncols
      [1] 512
      
      $ROI_13$info$source_nrows
      [1] 512
      
      $ROI_13$info$average
      [1] 122.7552
      
      $ROI_13$info$fft_max
      [1] 140.5681
      
      
      $ROI_13$overlay
      $ROI_13$overlay$x
      [1] 170.5
      
      $ROI_13$overlay$y
      [1] 310.5
      
      $ROI_13$overlay$r
      [1] 6
      
      
      $ROI_13$curves
      list()
      
      
      $ROI_14
      $ROI_14$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_14$col_min
      [1] 331
      
      $ROI_14$row_min
      [1] 263
      
      $ROI_14$shape
      [1] "circle"
      
      $ROI_14$class
      [1] "Unclassified"
      
      $ROI_14$info
      $ROI_14$info$source_function
      [1] "find_grains"
      
      $ROI_14$info$source_obj
      [1] "sandworm.file"
      
      $ROI_14$info$source_ncols
      [1] 512
      
      $ROI_14$info$source_nrows
      [1] 512
      
      $ROI_14$info$average
      [1] 103.6206
      
      $ROI_14$info$fft_max
      [1] 202.6525
      
      
      $ROI_14$overlay
      $ROI_14$overlay$x
      [1] 336.5
      
      $ROI_14$overlay$y
      [1] 243.5
      
      $ROI_14$overlay$r
      [1] 6
      
      
      $ROI_14$curves
      list()
      
      

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
      $ROI_1$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_1$col_min
      [1] 385
      
      $ROI_1$row_min
      [1] 307
      
      $ROI_1$shape
      [1] "circle"
      
      $ROI_1$class
      [1] "Unclassified"
      
      $ROI_1$info
      $ROI_1$info$source_function
      [1] "find_grains"
      
      $ROI_1$info$source_obj
      [1] "sandworm.file"
      
      $ROI_1$info$source_ncols
      [1] 512
      
      $ROI_1$info$source_nrows
      [1] 512
      
      $ROI_1$info$average
      [1] 855.1412
      
      $ROI_1$info$fft_max
      [1] 900.8482
      
      
      $ROI_1$overlay
      $ROI_1$overlay$x
      [1] 390.5
      
      $ROI_1$overlay$y
      [1] 199.5
      
      $ROI_1$overlay$r
      [1] 6
      
      
      $ROI_1$curves
      list()
      
      
      $ROI_2
      $ROI_2$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_2$col_min
      [1] 229
      
      $ROI_2$row_min
      [1] 286
      
      $ROI_2$shape
      [1] "circle"
      
      $ROI_2$class
      [1] "Unclassified"
      
      $ROI_2$info
      $ROI_2$info$source_function
      [1] "find_grains"
      
      $ROI_2$info$source_obj
      [1] "sandworm.file"
      
      $ROI_2$info$source_ncols
      [1] 512
      
      $ROI_2$info$source_nrows
      [1] 512
      
      $ROI_2$info$average
      [1] 384.0162
      
      $ROI_2$info$fft_max
      [1] 415.8744
      
      
      $ROI_2$overlay
      $ROI_2$overlay$x
      [1] 234.5
      
      $ROI_2$overlay$y
      [1] 220.5
      
      $ROI_2$overlay$r
      [1] 6
      
      
      $ROI_2$curves
      list()
      
      
      $ROI_3
      $ROI_3$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_3$col_min
      [1] 377
      
      $ROI_3$row_min
      [1] 213
      
      $ROI_3$shape
      [1] "circle"
      
      $ROI_3$class
      [1] "Unclassified"
      
      $ROI_3$info
      $ROI_3$info$source_function
      [1] "find_grains"
      
      $ROI_3$info$source_obj
      [1] "sandworm.file"
      
      $ROI_3$info$source_ncols
      [1] 512
      
      $ROI_3$info$source_nrows
      [1] 512
      
      $ROI_3$info$average
      [1] 347.997
      
      $ROI_3$info$fft_max
      [1] 381.498
      
      
      $ROI_3$overlay
      $ROI_3$overlay$x
      [1] 382.5
      
      $ROI_3$overlay$y
      [1] 293.5
      
      $ROI_3$overlay$r
      [1] 6
      
      
      $ROI_3$curves
      list()
      
      
      $ROI_4
      $ROI_4$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_4$col_min
      [1] 321
      
      $ROI_4$row_min
      [1] 302
      
      $ROI_4$shape
      [1] "circle"
      
      $ROI_4$class
      [1] "Unclassified"
      
      $ROI_4$info
      $ROI_4$info$source_function
      [1] "find_grains"
      
      $ROI_4$info$source_obj
      [1] "sandworm.file"
      
      $ROI_4$info$source_ncols
      [1] 512
      
      $ROI_4$info$source_nrows
      [1] 512
      
      $ROI_4$info$average
      [1] 335.7301
      
      $ROI_4$info$fft_max
      [1] 257.7178
      
      
      $ROI_4$overlay
      $ROI_4$overlay$x
      [1] 326.5
      
      $ROI_4$overlay$y
      [1] 204.5
      
      $ROI_4$overlay$r
      [1] 6
      
      
      $ROI_4$curves
      list()
      
      
      $ROI_5
      $ROI_5$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_5$col_min
      [1] 356
      
      $ROI_5$row_min
      [1] 279
      
      $ROI_5$shape
      [1] "circle"
      
      $ROI_5$class
      [1] "Unclassified"
      
      $ROI_5$info
      $ROI_5$info$source_function
      [1] "find_grains"
      
      $ROI_5$info$source_obj
      [1] "sandworm.file"
      
      $ROI_5$info$source_ncols
      [1] 512
      
      $ROI_5$info$source_nrows
      [1] 512
      
      $ROI_5$info$average
      [1] 329.7378
      
      $ROI_5$info$fft_max
      [1] 243.1392
      
      
      $ROI_5$overlay
      $ROI_5$overlay$x
      [1] 361.5
      
      $ROI_5$overlay$y
      [1] 227.5
      
      $ROI_5$overlay$r
      [1] 6
      
      
      $ROI_5$curves
      list()
      
      
      $ROI_6
      $ROI_6$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_6$col_min
      [1] 209
      
      $ROI_6$row_min
      [1] 274
      
      $ROI_6$shape
      [1] "circle"
      
      $ROI_6$class
      [1] "Unclassified"
      
      $ROI_6$info
      $ROI_6$info$source_function
      [1] "find_grains"
      
      $ROI_6$info$source_obj
      [1] "sandworm.file"
      
      $ROI_6$info$source_ncols
      [1] 512
      
      $ROI_6$info$source_nrows
      [1] 512
      
      $ROI_6$info$average
      [1] 304.5487
      
      $ROI_6$info$fft_max
      [1] 426.6962
      
      
      $ROI_6$overlay
      $ROI_6$overlay$x
      [1] 214.5
      
      $ROI_6$overlay$y
      [1] 232.5
      
      $ROI_6$overlay$r
      [1] 6
      
      
      $ROI_6$curves
      list()
      
      
      $ROI_7
      $ROI_7$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_7$col_min
      [1] 315
      
      $ROI_7$row_min
      [1] 212
      
      $ROI_7$shape
      [1] "circle"
      
      $ROI_7$class
      [1] "Unclassified"
      
      $ROI_7$info
      $ROI_7$info$source_function
      [1] "find_grains"
      
      $ROI_7$info$source_obj
      [1] "sandworm.file"
      
      $ROI_7$info$source_ncols
      [1] 512
      
      $ROI_7$info$source_nrows
      [1] 512
      
      $ROI_7$info$average
      [1] 294.7563
      
      $ROI_7$info$fft_max
      [1] 270.8193
      
      
      $ROI_7$overlay
      $ROI_7$overlay$x
      [1] 320.5
      
      $ROI_7$overlay$y
      [1] 294.5
      
      $ROI_7$overlay$r
      [1] 6
      
      
      $ROI_7$curves
      list()
      
      
      $ROI_8
      $ROI_8$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_8$col_min
      [1] 291
      
      $ROI_8$row_min
      [1] 321
      
      $ROI_8$shape
      [1] "circle"
      
      $ROI_8$class
      [1] "Unclassified"
      
      $ROI_8$info
      $ROI_8$info$source_function
      [1] "find_grains"
      
      $ROI_8$info$source_obj
      [1] "sandworm.file"
      
      $ROI_8$info$source_ncols
      [1] 512
      
      $ROI_8$info$source_nrows
      [1] 512
      
      $ROI_8$info$average
      [1] 270.3695
      
      $ROI_8$info$fft_max
      [1] 253.1478
      
      
      $ROI_8$overlay
      $ROI_8$overlay$x
      [1] 296.5
      
      $ROI_8$overlay$y
      [1] 185.5
      
      $ROI_8$overlay$r
      [1] 6
      
      
      $ROI_8$curves
      list()
      
      
      $ROI_9
      $ROI_9$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_9$col_min
      [1] 303
      
      $ROI_9$row_min
      [1] 267
      
      $ROI_9$shape
      [1] "circle"
      
      $ROI_9$class
      [1] "Unclassified"
      
      $ROI_9$info
      $ROI_9$info$source_function
      [1] "find_grains"
      
      $ROI_9$info$source_obj
      [1] "sandworm.file"
      
      $ROI_9$info$source_ncols
      [1] 512
      
      $ROI_9$info$source_nrows
      [1] 512
      
      $ROI_9$info$average
      [1] 205.6984
      
      $ROI_9$info$fft_max
      [1] 179.6296
      
      
      $ROI_9$overlay
      $ROI_9$overlay$x
      [1] 308.5
      
      $ROI_9$overlay$y
      [1] 239.5
      
      $ROI_9$overlay$r
      [1] 6
      
      
      $ROI_9$curves
      list()
      
      
      $ROI_10
      $ROI_10$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_10$col_min
      [1] 231
      
      $ROI_10$row_min
      [1] 129
      
      $ROI_10$shape
      [1] "circle"
      
      $ROI_10$class
      [1] "Unclassified"
      
      $ROI_10$info
      $ROI_10$info$source_function
      [1] "find_grains"
      
      $ROI_10$info$source_obj
      [1] "sandworm.file"
      
      $ROI_10$info$source_ncols
      [1] 512
      
      $ROI_10$info$source_nrows
      [1] 512
      
      $ROI_10$info$average
      [1] 160.4624
      
      $ROI_10$info$fft_max
      [1] 170.1141
      
      
      $ROI_10$overlay
      $ROI_10$overlay$x
      [1] 236.5
      
      $ROI_10$overlay$y
      [1] 377.5
      
      $ROI_10$overlay$r
      [1] 6
      
      
      $ROI_10$curves
      list()
      
      
      $ROI_11
      $ROI_11$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_11$col_min
      [1] 238
      
      $ROI_11$row_min
      [1] 204
      
      $ROI_11$shape
      [1] "circle"
      
      $ROI_11$class
      [1] "Unclassified"
      
      $ROI_11$info
      $ROI_11$info$source_function
      [1] "find_grains"
      
      $ROI_11$info$source_obj
      [1] "sandworm.file"
      
      $ROI_11$info$source_ncols
      [1] 512
      
      $ROI_11$info$source_nrows
      [1] 512
      
      $ROI_11$info$average
      [1] 156.0177
      
      $ROI_11$info$fft_max
      [1] 206.1395
      
      
      $ROI_11$overlay
      $ROI_11$overlay$x
      [1] 243.5
      
      $ROI_11$overlay$y
      [1] 302.5
      
      $ROI_11$overlay$r
      [1] 6
      
      
      $ROI_11$curves
      list()
      
      
      $ROI_12
      $ROI_12$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_12$col_min
      [1] 280
      
      $ROI_12$row_min
      [1] 150
      
      $ROI_12$shape
      [1] "circle"
      
      $ROI_12$class
      [1] "Unclassified"
      
      $ROI_12$info
      $ROI_12$info$source_function
      [1] "find_grains"
      
      $ROI_12$info$source_obj
      [1] "sandworm.file"
      
      $ROI_12$info$source_ncols
      [1] 512
      
      $ROI_12$info$source_nrows
      [1] 512
      
      $ROI_12$info$average
      [1] 132.9038
      
      $ROI_12$info$fft_max
      [1] 179.7526
      
      
      $ROI_12$overlay
      $ROI_12$overlay$x
      [1] 285.5
      
      $ROI_12$overlay$y
      [1] 356.5
      
      $ROI_12$overlay$r
      [1] 6
      
      
      $ROI_12$curves
      list()
      
      
      $ROI_13
      $ROI_13$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_13$col_min
      [1] 165
      
      $ROI_13$row_min
      [1] 196
      
      $ROI_13$shape
      [1] "circle"
      
      $ROI_13$class
      [1] "Unclassified"
      
      $ROI_13$info
      $ROI_13$info$source_function
      [1] "find_grains"
      
      $ROI_13$info$source_obj
      [1] "sandworm.file"
      
      $ROI_13$info$source_ncols
      [1] 512
      
      $ROI_13$info$source_nrows
      [1] 512
      
      $ROI_13$info$average
      [1] 122.7552
      
      $ROI_13$info$fft_max
      [1] 140.5681
      
      
      $ROI_13$overlay
      $ROI_13$overlay$x
      [1] 170.5
      
      $ROI_13$overlay$y
      [1] 310.5
      
      $ROI_13$overlay$r
      [1] 6
      
      
      $ROI_13$curves
      list()
      
      
      $ROI_14
      $ROI_14$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_14$col_min
      [1] 157
      
      $ROI_14$row_min
      [1] 256
      
      $ROI_14$shape
      [1] "circle"
      
      $ROI_14$class
      [1] "Unclassified"
      
      $ROI_14$info
      $ROI_14$info$source_function
      [1] "find_grains"
      
      $ROI_14$info$source_obj
      [1] "sandworm.file"
      
      $ROI_14$info$source_ncols
      [1] 512
      
      $ROI_14$info$source_nrows
      [1] 512
      
      $ROI_14$info$average
      [1] 118.5258
      
      $ROI_14$info$fft_max
      [1] 99.17196
      
      
      $ROI_14$overlay
      $ROI_14$overlay$x
      [1] 162.5
      
      $ROI_14$overlay$y
      [1] 250.5
      
      $ROI_14$overlay$r
      [1] 6
      
      
      $ROI_14$curves
      list()
      
      
      $ROI_15
      $ROI_15$mask
             [,1]  [,2]  [,3]  [,4]  [,5]  [,6] [,7]  [,8]  [,9] [,10] [,11] [,12]
       [1,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
       [2,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
       [3,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
       [4,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [5,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [6,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [7,]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [8,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
       [9,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [10,] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
      [11,] FALSE FALSE  TRUE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE  TRUE FALSE
      [12,] FALSE FALSE FALSE  TRUE  TRUE  TRUE TRUE  TRUE  TRUE  TRUE FALSE FALSE
      [13,] FALSE FALSE FALSE FALSE FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE
            [,13]
       [1,] FALSE
       [2,] FALSE
       [3,] FALSE
       [4,] FALSE
       [5,] FALSE
       [6,] FALSE
       [7,]  TRUE
       [8,] FALSE
       [9,] FALSE
      [10,] FALSE
      [11,] FALSE
      [12,] FALSE
      [13,] FALSE
      
      $ROI_15$col_min
      [1] 331
      
      $ROI_15$row_min
      [1] 263
      
      $ROI_15$shape
      [1] "circle"
      
      $ROI_15$class
      [1] "Unclassified"
      
      $ROI_15$info
      $ROI_15$info$source_function
      [1] "find_grains"
      
      $ROI_15$info$source_obj
      [1] "sandworm.file"
      
      $ROI_15$info$source_ncols
      [1] 512
      
      $ROI_15$info$source_nrows
      [1] 512
      
      $ROI_15$info$average
      [1] 103.6206
      
      $ROI_15$info$fft_max
      [1] 202.6525
      
      
      $ROI_15$overlay
      $ROI_15$overlay$x
      [1] 336.5
      
      $ROI_15$overlay$y
      [1] 243.5
      
      $ROI_15$overlay$r
      [1] 6
      
      
      $ROI_15$curves
      list()
      
      

