# snapshot tests

    Code
      get_signal_range(img_1lyr)
    Output
         20% 99.99% 
           2   1334 

---

    Code
      get_signal_range(img_2lyr, contains.outlier = TRUE, verbose = TRUE)
    Output
      Reasonable signal value limits for plotting are: 3 - 181 
      10% 99% 
        3 181 

