# snapshot tests

    Code
      rotate_image(matrix(1:9, ncol = 3), 90)
    Output
      Rotate image 90° clockwise. 
           [,1] [,2] [,3]
      [1,]    3    2    1
      [2,]    6    5    4
      [3,]    9    8    7

---

    Code
      rotate_image(array(1:27, dim = c(3, 3, 3)), -180)
    Output
      Rotate 3 images 180° counter-clockwise. 
      , , 1
      
           [,1] [,2] [,3]
      [1,]    9    6    3
      [2,]    8    5    2
      [3,]   NA    4   NA
      
      , , 2
      
           [,1] [,2] [,3]
      [1,]   18   15   12
      [2,]   17   14   11
      [3,]   NA   13   NA
      
      , , 3
      
           [,1] [,2] [,3]
      [1,]   27   24   21
      [2,]   26   23   20
      [3,]   NA   22   NA
      

