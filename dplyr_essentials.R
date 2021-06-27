#installing dplyr
install.packages('dplyr')
library('dplyr')

#Adding inbuilt data set
BilboardT100 <- read.csv("C://Users//charu//Desktop//R//Top 100 songs - kaggle.csv")

#Fetching top 10 rows
head(BilboardT100,10)

BilboardT100 %>% head(10)

10 %>% head(BilboardT100,.)


## COLUMNS: select(),mutate()
## ROW:filter(),distinct(),arrange()
# GROUP: group_by(),summarise(), count()

################################## COlUMNS #################################################################################
################# SELECT ---> Helps you choose within dataset ##############################################################
BilboardT100 %>% 
  select(date, rank,song,artist,'weeks.on.board')

BilboardT100 %>% 
  select(date:artist,weeks_popular='weeks.on.board')

BilboardT100 %>% 
  select(-peak.rank,-last.week)

#select columns whose name contains a character string
select(BilboardT100,contains('s'))

#select columns whose name ends with a character string
select(BilboardT100,ends_with('k'))

#select column whose name starts with a character string
select(BilboardT100,starts_with('R'))

#select every column
select(BilboardT100,everything())

#select columns whose name matches a regular expression
select(BilboardT100,matches(".ra"))

#select columns named rank1,rank2,rank3,rank4,rank5 -- in this dataset we can rename ranks as rank1, rank2 and rank3
select(BilboardT100,num_range("rank",1:3))

#select columns whose names are in a group of name
#select(BilboardT100,one_of(C("rank","week")))



################################## MUTATE ################################################################################

#Mutate-> computes or append one or new columns

BilboardT100 %>% 
  select (date:artist, week_popular = 'weeks.on.board') %>% 
  mutate(is_collab = grepl('Featuring',artist)) %>% 
  select(artist,is_collab,everything()) #for ordering


################################ ROW ######################################################################################

###################Filter --> extract rows that meet logical criteria #####################################################

BilboardT100 %>% 
  select (date: artist, week_popular = 'weeks.on.board') %>% 
  filter(week_popular>=20, artist == 'Drake' | artist == 'Taylor Swift')

###################Distinct --> Removes duplicate #########################################################################

BilboardT100 %>% 
  select (date: artist, week_popular = 'weeks.on.board') %>% 
  filter(week_popular>=20, artist == 'Drake' ) %>% 
  distinct(song)

BilboardT100 %>% 
  select (date: artist, week_popular = 'weeks.on.board') %>% 
  filter(week_popular>=20, artist == 'Drake' ) %>% 
  distinct(song) %>% 
  .$ # this will give charcter vector of song names
  
  
  
################################ GROUP BY ###################################################################################  

###### group_by() ---> group data into rows with the same value #############################################################
###### summarize() ---> summarize data into single row of values ############################################################

BilboardT100 %>% 
  select (date: artist, week_popular = 'weeks.on.board') %>% 
  filter(week_popular>=20, artist == 'Drake' ) %>% 
  group_by(song) %>% 
  summarize(total_weeks_popular = max(week_popular)) %>% 
  arrange(desc(total_weeks_popular),song) %>% 
  head(10)

###### count() ---> count number of rows with each unique value of variable ##################################################

BilboardT100 %>% 
  select (date:artist, weeks_popular ='weeks.on.board') %>% 
  count(artist) %>% 
  arrange(desc(n))

   

