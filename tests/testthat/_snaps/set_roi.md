# snapshot tests

    Code
      set_roi(mask = matrix(rep(TRUE, 16), ncol = 4), col_min = 42, row_min = 67)
    Output
      $mask
           [,1] [,2] [,3] [,4]
      [1,] TRUE TRUE TRUE TRUE
      [2,] TRUE TRUE TRUE TRUE
      [3,] TRUE TRUE TRUE TRUE
      [4,] TRUE TRUE TRUE TRUE
      
      $col_min
      [1] 42
      
      $row_min
      [1] 67
      
      $shape
      [1] "rectangle"
      
      $class
      [1] "Unclassified"
      
      $info
      $info$source_function
      [1] "set_roi"
      
      
      $overlay
      $overlay$dx
      [1] 4
      
      $overlay$dy
      [1] 4
      
      
      $curves
      list()
      

---

    Code
      set_roi(roi, add.curve = data.frame(x = 1:10, y = (12:3)^1.5), add.info = c(
        other = "info"), class = "arbitrary")
    Output
      $mask
           [,1] [,2] [,3] [,4] [,5]
      [1,] TRUE TRUE TRUE TRUE TRUE
      [2,] TRUE TRUE TRUE TRUE TRUE
      [3,] TRUE TRUE TRUE TRUE TRUE
      [4,] TRUE TRUE TRUE TRUE TRUE
      [5,] TRUE TRUE TRUE TRUE TRUE
      
      $col_min
      [1] 42
      
      $row_min
      [1] 67
      
      $shape
      [1] "rectangle"
      
      $class
      [1] "arbitrary"
      
      $info
      $info$hello
      [1] "world"
      
      $info$source_function
      [1] "set_roi"
      
      $info$other
      [1] "info"
      
      
      $overlay
      $overlay$dx
      [1] 5
      
      $overlay$dy
      [1] 5
      
      
      $curves
      $curves[[1]]
          x         y
      1   1 41.569219
      2   2 36.482873
      3   3 31.622777
      4   4 27.000000
      5   5 22.627417
      6   6 18.520259
      7   7 14.696938
      8   8 11.180340
      9   9  8.000000
      10 10  5.196152
      
      

