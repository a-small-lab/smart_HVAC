df = read.csv("C:\\Users\\canea\\Downloads\\AllOlssonLinkLabMeters.csv")

library(stringr)

strings = c("SAT",	"MAT",	"SFNSTS",	"SFNC",	"VFD",	"RFNSTS",	"RFNC",	"SAF",	"SAFS",	"ZNT")

any(as.vector(str_detect(df[16,1], strings)))
  
for(i in 1:nrow(df)){
  df[i,2] = any(as.vector(str_detect(df[i,1], strings)))
}

write.csv(df, "C:\\Users\\canea\\Downloads\\AllOlssonLinkLabMetersTags.csv")
