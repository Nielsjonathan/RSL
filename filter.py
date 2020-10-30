import pandas as pd

#data is a dataframe#
data = pd.read_csv('userReviews all three parts.csv',sep=';')

#print(data.head())#
#print(data[:3])#
#print(data.movieName.iloc[1])#

column_names = ['movieName','Metascore_w','Author','AuthorHref','Date','Summary','InteractionsYesCount','InteractionsTotalCount','InteractionsThumbUp','InteractionsThumbDown']
subset = pd.DataFrame(columns = column_names)

author_db = pd.DataFrame(columns = column_names)
recomendations_db = pd.DataFrame(columns = column_names)


for index, row in data.iterrows():
    if data.movieName.iloc[index] == 'beach-rats':
        #print(row["Author"])#
        #subset.append(row)#

        #print(row["Metascore_w"])#
        current_rating = row['Metascore_w']

        for i, r in data.iterrows():
            if data.Author.iloc[i] == row["Author"]:
                author_db = author_db.append(pd.DataFrame({'movieName': r['movieName'], 'Metascore_w': r['Metascore_w'], 'Author': r['Author'], 'AuthorHref': r['AuthorHref'], 'Summary': r['Summary']}, index=[0]), ignore_index=True)

        for i, r in author_db.iterrows():
            if r['Metascore_w'] > current_rating:
                recomendations_db = recomendations_db.append(pd.DataFrame({'movieName': r['movieName'], 'Metascore_w': r['Metascore_w'], 'Author': r['Author'], 'AuthorHref': r['AuthorHref'], 'Summary': r['Summary'], 'origin_rating': current_rating}, index=[0]), ignore_index=True)

recomendations_db.to_csv('recommendations.csv', sep=';')

