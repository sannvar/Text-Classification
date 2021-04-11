# Text-Classification
Project aims to train logistic regression classifiers to predict whether a Reddit post is related to mental health. 

## Description
The project trains 3 different regression models - Regular logistic regression, Ridge regression and Lasso regression on the provided dataset and compares the performance of all models by means of accuracy and confusion matrix. 
The lasso model resulted in the greatest acuracy (99.6%), followed by the ridge model (95.5%) and the regular logistic model (95.1%).  

## Dataset
The dataset uses TF-IDF features (term frequencies normalized by term’s overall document frequency) extracted from 6312 Reddit posts. Each row represents a post and each column (except the last column) corresponds to a word. The last column, IsMentalHealthRelated, indicates whether that post is about mental health problems - IsMentalHealthRelated=1 denotes a post that is related to mental health while IsMentalHealthRelated=0 denotes that it is not. 

*This project is based on the assignments for MSCI 446: Data Mining (to be renamed to Introduction to Machine Learning) offered by the University of Waterloo. The dataset was obtained as part of the course work.*