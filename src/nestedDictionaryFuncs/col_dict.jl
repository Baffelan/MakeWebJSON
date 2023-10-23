function col_dict(word_df, date, dfcol, num)    
    day = word_df[word_df.date.==date, dfcol]
    dict = OrderedDict([k=>v for (k,v) in pairs(JSON.parse(day[1])) if ((!in(k,stopwords(Languages.English()))) && length(k)>1) ])
    OrderedDict([i for i in sort(dict,byvalue=true,rev=true)][1:min(num, length(dict))]...)
end

function news_word_cloud_dict(word_df, date)   
    col_dict(word_df, date, :word_cloud, 50) 
end

function surprise_dict(word_df, date)   
    col_dict(word_df, date, :word_changes, 20)  
end
