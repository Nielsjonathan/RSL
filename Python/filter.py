#I start with importing the Pandas library and saving it as pd
import pandas as pd

#I read to csv into the dataframe called data
data = pd.read_csv('userReviews all three parts.csv',sep=';')

#I create the names for the columns
column_names = ['movieName', 'Metascore_w', 'Author', 'AuthorHref', 'Summary','origin_rating']

#I create a dataframe to store the results from my for loops
author_db = pd.DataFrame(columns = column_names)
recomendations = pd.DataFrame(columns = column_names)

#In this for loop I go through the entire dataset and look for all the reviews of the movie Memento
#I store the metascore in the column current rating and attach the data to the author dataframe
for i, r in data.iterrows():
    if data.movieName.iloc[i] == "memento":
        current_rating = r["Metascore_w"]
        author_db = author_db.append(pd.DataFrame({'movieName': r['movieName'], 'Metascore_w': r['Metascore_w'] , 'Author': r['Author'], 'AuthorHref': r['AuthorHref'], 'Summary': r['Summary'], 'origin_rating': current_rating}, index=[0]), ignore_index=True)

#I look in the author dataframe for the names of the authors and the rating that they gave to the movie Memento
for index, r in author_db.iterrows():
    author = r["Author"]
    current_rating = r["origin_rating"]
    
#I use the authors and the rating they gave to Memento and look in the big dataset to find the movies they also rated but with a higher score than Memento
#I attach the data that I found to the recommandations dataframe
    for i, r in data.iterrows():
        if data.Author.iloc[i] == author:
            if r["Metascore_w"] > current_rating:
                recomendations = recomendations.append(pd.DataFrame({'movieName': r['movieName'], 'Metascore_w': r['Metascore_w'] , 'Author': r['Author'], 'AuthorHref': r['AuthorHref'], 'Summary': r['Summary'], 'origin_rating': current_rating}, index=[0]), ignore_index=True)

#I print the results to a csv. These are the recomendations that I found based on Memento
recomendations.to_csv("recomendations_memento.csv", sep=';')