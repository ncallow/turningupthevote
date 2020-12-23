# Turning Up The Vote:
# Analyzing 2019 Liberal Party Support at Full Voter Turnout

# Author: Nick Callow (nick.callow@mail.utoronto.ca)

# Canadian Election Study - Cleaning Code

install.packages("devtools")
devtools::install_github("hodgettsp/cesR")

library(tidyverse)
library(cesR)

get_ces("ces2019_web")
ces2019_web <- labelled::to_factor(ces2019_web) # Ho
head(ces2019_web)

ces2019 <- ces2019_web %>% 
  select(cps19_age, cps19_gender, cps19_education, pes19_votechoice2019)

ces2019 <- ces2019 %>% 
  drop_na(pes19_votechoice2019)

write.csv(ces2019, "ces2019.csv")


