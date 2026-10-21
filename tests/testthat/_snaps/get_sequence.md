# snapshot tests

    Code
      get_sequence(obj)
    Output
        files recordType wavelength interval maxMeasuredT
      1     1         RF        880        5           70
      2     1        OSL        365        5           80

---

    Code
      get_sequence(obj, print.friendly = TRUE)
    Output
        Files Type Emission Interval [sec] Maximum measured temperature [℃]
      1 1     RF   880 nm   5              70                              
      2 1     OSL  365 nm   5              80                              
      Measurement sequence of position 27.
        Files Type Emission Interval [sec] Maximum measured temperature [℃]
      1     1   RF   880 nm              5                               70
      2     1  OSL   365 nm              5                               80

