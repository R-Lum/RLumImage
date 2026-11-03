# snapshot tests

    Code
      set_RLum("RLum.Analysis.ROI")
    Output
      
       [RLum.Analysis.ROI-class]
      	 originator: eval()
      	 protocol: NA
      	 additional info elements:  0
      	 ROI: <none>
      	 number of records: 0
      	 >> This is an empty object, which cannot be used for further analysis! <<

---

    Code
      set_RLum("RLum.Analysis.ROI", records = set_RLum("RLum.Analysis"), roi = rois.sandworm[[
        1]])
    Output
      
       [RLum.Analysis.ROI-class]
      	 originator: eval()
      	 protocol: NA
      	 additional info elements:  0
      	 ROI: circle, 19 x 19 px at (382, 304)
      	 mineral class: Unclassified
      	 number of records: 0
      	 >> This is an empty object, which cannot be used for further analysis! <<

