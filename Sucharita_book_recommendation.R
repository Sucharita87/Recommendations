library("recommenderlab")
library(caTools)
library(Matrix)
book_list<-read.csv("F://ExcelR//Assignment//Recommendation system//book.csv")
View(book_list)
class(book_list)
str(book_list)

colnames(book_list)
book_list1<-book_list[,-c(1)]
colnames(book_list1)

View(book_list1)# remove first column
book <- book_list1[order(User.ID), ] # sort the df based on user id

View(book)
table(book$Book.Title)
table(book$User.ID) 
table(book$Book.Rating > 5.0) # false = 1496, true = 8504
table(book$Book.Rating)
#1    2    3    4    5    6    7    8    9   10 
#43   63  146  237 1007  920 2076 2283 1493 1732

hist(book$Book.Rating)
book_matrix<-as(book, "realRatingMatrix")
class(book_matrix)
dim(book_matrix) # 2182, 9659
nrow(book_matrix)
ncol(book_matrix)

sim <- similarity(book_matrix[1:10, ], method = "cosine", which = "users")
image(as.matrix(sim), main = "User Similarity")
sim2 <- similarity(book_matrix[ ,1:10], method = "cosine", which = "items")
image(as.matrix(sim2), main = "Item Similarity")

?Recommender
model_1<-Recommender(book_matrix, method ="popular")
recommend_1<-predict(model_1, book_matrix[115:150], n= 3) # n denotes number of sugested book options
as(recommend_1, "list") # view, it suggest same book for all

# eg:
#$`1435`
#[1] "In the Beauty of the Lilies" "Black House"                 "White Oleander : A Novel"   
#[4] "The Magician's Tale"        

#$`1436`
#[1] "In the Beauty of the Lilies" "Black House"                 "White Oleander : A Novel"   
#[4] "The Magician's Tale"        

#$`1466`
#[1] "In the Beauty of the Lilies" "Black House"                 "White Oleander : A Novel"   
#[4] "The Magician's Tale"        

# build model for individual recommendations
model_2<- Recommender(book_matrix, method ="UBCF")
model_2
recommend_2<-predict(model_2, book_matrix[200:210,], n=1)
as(recommend_2, "list")

#eg:
  
#$`1435`
#[1] "Hannibal"                                                               
#[2] "Sudden Mischief (Spenser Mysteries (Hardcover))"                        
#[3] "The Thorn Birds (Modern Classics)"                                      
#[4] "Ufos, JFK and Elvis: Conspiracies You Don't Have to Be Crazy to Believe"

#$`1436`
#[1] "'48"                                                                  
#[2] "'O Au No Keia: Voices from Hawai'I's Mahu and Transgender Communities"
#[3] " Jason, Madison &amp"                                                 
#[4] " Other Stories;Merril;1985;McClelland &amp"     

#$`1466`
#[1] "A Confederacy of Dunces (Evergreen Book)"            
#[2]"American Son"                                       
#[3] "Fiddleback: A Novel"                                
#[4]"Fifth Business (Penguin Twentieth-Century Classics)"


