data<-read.csv("3000000+.csv")
data$X<-NULL

train.tokens.matrix <- as.matrix(data)
str(train.tokens.matrix)
term.frequency <- function(row) {
  row / sum(row)
}

# Our function for calculating inverse document frequency (IDF)
inverse.doc.freq <- function(col) {
  corpus.size <- length(col)
  doc.count <- length(which(col > 0))
  
  log10(corpus.size / doc.count)
}

# Our function for calculating TF-IDF.
tf.idf <- function(x, idf) {
  x * idf
}

# First step, normalize all documents via TF.
train.tokens.df <- apply(train.tokens.matrix, 1, term.frequency)

# Second step, calculate the IDF vector that we will use - both
# for training data and for test data!
train.tokens.idf <- apply(train.tokens.matrix, 2, inverse.doc.freq)

# Lastly, calculate TF-IDF for our training corpus.
train.tokens.tfidf <-  apply(train.tokens.df, 2, tf.idf, idf = train.tokens.idf)

# Transpose the matrix
train.tokens.tfidf <- t(train.tokens.tfidf)

#
library(irlba)
# Perform SVD. Specifically, reduce dimensionality down to 300 columns
# for our latent semantic analysis (LSA).
train.irlba <- irlba(train.tokens.tfidf, nv = 2000)

# As with TF-IDF, we will need to project new data (e.g., the test data)
# into the SVD semantic space. The following code illustrates how to do
# this using a row of the training data that has already been transformed
# by TF-IDF, per the mathematics illustrated in the slides.
#
#
#sigma.inverse <- 1 / train.irlba$d
#u.transpose <- t(train.irlba$u)
#document <- train.tokens.tfidf[1,]
#document.hat <- sigma.inverse * u.transpose %*% document

# Look at the first 10 components of projected document and the corresponding
# row in our document semantic space (i.e., the V matrix)
#document.hat
#train.irlba$v

#
# Create new feature data frame using our document semantic space of 300
# features (i.e., the V matrix from our SVD).
#
train.svd <- data.frame(Label = train$stars, train.irlba$v)

library(irlba)
library(e1071)
library(rpart)
library(caret)
# Define training control
set.seed(123) 
train.control <- trainControl(method = "cv", number = 10)
# Train the model
model.1<- train(yelp.stars ~., data = train.svd, method = "lm",trControl = train.control)
model.2<- train(yelp.stars ~., data = train.svd, method = "rpart", trControl = train.control)

print(model.1)
print(model.2)

prediction1 <- predict(model.1, yelp.test, OOB=TRUE, type = "response")
prediction2 <- predict(model.2, yelp.test, OOB=TRUE, type = "response")

submit1 <- data.frame(Id = yelp_out$Id, Expected = prediction1)
submit2 <- data.frame(Id = yelp_out$Id, Expected = prediction2)
write.csv(submit1, file = "predictCV1.csv",row.names = FALSE)
write.csv(submit2 , file = "predictCV2.csv",row.names = FALSE)

