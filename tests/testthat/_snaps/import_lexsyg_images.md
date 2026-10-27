# snapshot tests

    Code
      import_lexsyg_images(xsyg)
    Output
      Folder contains 1 TIFF files.
      
      #1 Use creation date of the TIFF files as time stamp and sort them ...DONE
         Images were recorded between 2026-05-08 20:40:28 and
      
      #2 Read XSYG file and get sequence data ...DONE
         Found 12 records in 1 aliquots, using a EMCCD as detector.
      
      #3 Assign image files to sequence steps according to their time stamp ...DONE
         Assigned 1 TIFF files to specific sequence steps. 
      
      #4 Build R list object ...DONE
         Created image sequence object which is 0 MB large.
      
        Files Type Emission Interval [sec] Maximum measured temperature [℃]
      1 1     OSL  410 nm   5              50                              
      Measurement sequence of position 27.
      $`27`
      $`27`[[1]]
      $`27`[[1]]$position
      [1] 27
      
      $`27`[[1]]$recordNumber
      [1] 33
      
      $`27`[[1]]$recordType
      [1] "OSL"
      
      $`27`[[1]]$detectionInterval
      [1] 5
      
      $`27`[[1]]$detectionWavelength
      [1] 410
      
      $`27`[[1]]$maxMeasuredT
      [1] 50
      
      $`27`[[1]]$imageFiles
                                                   file                time channel
      1 _data/2026-05-08_Combined_RF-OSL_02_short_9.tif 2026-05-08 20:40:28       1
        maxMeasuredT
      1           50
      
      
      

