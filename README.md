# Yelp Rating Prediction

## What is
This is a project from the course Statistics 333. The data used in the project is adapted from the kaggle [Yelp dataset](https://www.kaggle.com/yelp-dataset/yelp-dataset). The data in this project only consists of restaurants in Wisconsin area.

On Yelp, people make comment on some specific places and give star ratings of these places. A typical comment may look like this:

> Love this place! Reminds me of Quivey's stable but more upscale. This was my first time so I'm not sure how it has changed since the remodel. I absolutely love the decor and ambiance. The place is beautiful.   
We met the in-laws there for a Friday night fish fry. My husband had the smelt fry, I had the trout which was served with fresh spinach and a lemon caper sauce (yum!) and everyone else had the fried cod. The food was perfect!! And the Brandy Ol Fashioneds were delicious! 
I am excited to go back and try some other dishes.

The task of this project is to extract information from the text and to predict the star rating of the user.

## Usage
You need to have RStudio installed on your computer. Put [Yelp_test.csv](Yelp_test.csv), [Yelp_train.csv](Yelp_train.csv), [Yelp_validate.csv](Yelp_train.csv) and [Yelp_prediction_tfidf_final.Rmd](Yelp_prediction_tfidf_final.Rmd) in the same folder, and run the Rmd file. The output will be a csv file containing the star predictions of the validate and test file combined.

## Authors
The work is done by Linchen Deng, Kenny Jin and Runxin Gao.

## Summary
There is a nice summary describing the details and the outcomes of this project. You can access the summary in the [summary](summary/) folder.

