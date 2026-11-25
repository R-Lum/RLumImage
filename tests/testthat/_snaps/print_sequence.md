# snapshot tests

    Code
      print_sequence(obj)
    Output
        files recordType wavelength interval maxMeasuredT
      1     1         RF        880        5           70
      2     1        OSL        365        5           80

---

    Code
      print_sequence(obj, print.friendly = TRUE)
    Output
        Files Type Emission Interval [sec] Maximum measured temperature [℃]
      1 1     RF   880 nm   5              70                              
      2 1     OSL  365 nm   5              80                              
      Measurement sequence of position 27.
        Files Type Emission Interval [sec] Maximum measured temperature [℃]
      1     1   RF   880 nm              5                               70
      2     1  OSL   365 nm              5                               80

---

    Code
      print_sequence(c(obj, obj), print.friendly = TRUE)
    Output
        Files Type Emission Interval [sec] Maximum measured temperature [℃]
      1 1     RF   880 nm   5              70                              
      2 1     OSL  365 nm   5              80                              
      Measurement sequence of position 27. It is assumed that the sequences for the other 1 positions are identical.
        Files Type Emission Interval [sec] Maximum measured temperature [℃]
      1     1   RF   880 nm              5                               70
      2     1  OSL   365 nm              5                               80

