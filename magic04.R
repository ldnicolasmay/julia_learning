magic04 <- readr::read_delim("magic04.data",
                             delim = ",", 
                             col_names = FALSE,
                             trim_ws = TRUE)

names(magic04) <- 
  c(
    "fLength"
    , "fWidth"
    , "fSize"
    , "fConc"
    , "fConc1"
    , "fAsym"
    , "fM3Long"
    , "fM3Trans"
    , "fAlpha"
    , "fDist"
    , "class"
  )

readr::write_csv(magic04, "magic04.csv", na = "")

