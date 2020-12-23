# Turning Up The Vote:
# Analyzing 2019 Liberal Party Support at Full Voter Turnout

# Author: Nick Callow (nick.callow@mail.utoronto.ca)



##### Variable Recoding - Education

## Below High School

ces2019$cps19_education[ces2019$cps19_education=="Some secondary/ high school"] <- "Below High School"
ces2019$cps19_education[ces2019$cps19_education=="Completed elementary school"] <- "Below High School"
ces2019$cps19_education[ces2019$cps19_education=="Some elementary school"] <- "Below High School"

gss2017$education[gss2017$education=="Less than high school diploma or its equivalent"] <- "Below High School"

# High School

ces2019$cps19_education[ces2019$cps19_education=="Completed secondary/ high school"] <- "High School"

gss2017$education[gss2017$education=="High school diploma or a high school equivalency certificate"] <- "High School"

# Below Bachelor's

ces2019$cps19_education[ces2019$cps19_education=="Some technical, community college, CEGEP, College Classique"] <- "Below Bachelors"
ces2019$cps19_education[ces2019$cps19_education=="Completed technical, community college, CEGEP, College Classique"] <- "Below Bachelors"
ces2019$cps19_education[ces2019$cps19_education=="Some university"] <- "Below Bachelors"

gss2017$education[gss2017$education=="Trade certificate or diploma"] <- "Below Bachelors"
gss2017$education[gss2017$education=="College, CEGEP or other non-university certificate or di..."] <- "Below Bachelors"
gss2017$education[gss2017$education=="University certificate or diploma below the bachelor's level"] <- "Below Bachelors"

# Bachelor's

ces2019$cps19_education[ces2019$cps19_education=="Bachelor's degree"] <- "Bachelors"

gss2017$education[gss2017$education=="Bachelor's degree (e.g. B.A., B.Sc., LL.B.)"] <- "Bachelors"

# Graduate Degree

ces2019$cps19_education[ces2019$cps19_education=="Master's degree"] <- "Graduate Degree"
ces2019$cps19_education[ces2019$cps19_education=="Professional degree or doctorate"] <- "Graduate Degree"

gss2017$education[gss2017$education=="University certificate, diploma or degree above the bach..."] <- "Graduate Degree"

# Removed From CES Data Set

ces2019 <- ces2019 %>% filter(cps19_education != "No schooling")
ces2019 <- ces2019 %>% filter(cps19_education != "Don't know/ Prefer not to answer")
ces2019 <- ces2019 %>% filter(pes19_votechoice2019 != "Don't know / Prefer not to answer")

# Removed From GSS Data Set

gss2017 <- gss2017 %>% filter(!is.na(education))
gss2017 <- gss2017 %>% filter(age >= 18)


#### Variable Recoding - Sex/Gender

ces2019$cps19_gender[ces2019$cps19_gender=="A man"] <- "Male"
ces2019$cps19_gender[ces2019$cps19_gender=="A woman"] <- "Female"
ces2019$cps19_gender[ces2019$cps19_gender=="Other (e.g. Trans, non-binary, two-spirit, gender-queer)"] <- "Female"

#### Creating Binary Response Variables in CES

ces2019 <- ces2019 %>%
  mutate(vote_liberal = ifelse(pes19_votechoice2019 == "Liberal Party", 1, 0))

ces2019 <- ces2019 %>%
  mutate(vote_conservative = ifelse(pes19_votechoice2019 == "Conservative Party", 1, 0))

ces2019 <- ces2019 %>%
  mutate(vote_bloc = ifelse(pes19_votechoice2019 == "Bloc QuÃ©bÃ©cois", 1, 0))

ces2019 <- ces2019 %>% 
  mutate(vote_ndp = ifelse(pes19_votechoice2019 == "NDP", 1, 0))

ces2019 <- ces2019 %>% 
  mutate(vote_green = ifelse(pes19_votechoice2019 == "Green Party", 1, 0))

ces2019 <- ces2019 %>% 
  mutate(vote_ppc = ifelse(pes19_votechoice2019 == "People's Party", 1, 0))

ces2019 <- ces2019 %>% 
  mutate(vote_other = ifelse(pes19_votechoice2019 == "Another party (specify)", 1, 0))

ces2019 <- ces2019 %>% 
  mutate(vote_spoil = ifelse(pes19_votechoice2019 == "I spoiled my vote", 1, 0))


#### Renaming CES Variables

names(ces2019)[names(ces2019) == "cps19_age"] <- "age"
names(ces2019)[names(ces2019) == "cps19_gender"] <- "sex"
names(ces2019)[names(ces2019) == "cps19_education"] <- "education"

#### Variable Recoding - Age

ces2019$age_cat <- cut(ces2019$age, c(18,30,50,65,Inf), right=FALSE)
gss2017$age_cat <- cut(gss2017$age, c(18,30,50,65,Inf), right=FALSE)

#### Creating Counts in GSS

gss2017 <- gss2017 %>% 
  count(age_cat, sex, education) %>% 
  group_by(age_cat, sex, education)


#### Writing New CSV Files

write.csv(ces2019, "ces2019_recoded.csv")
write.csv(gss2017, "gss2017_recoded.csv")


