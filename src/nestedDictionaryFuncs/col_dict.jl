function col_dict(word_df, date, dfcol, num)    
    day = word_df[word_df.date.==date, dfcol, num]
    dict = OrderedDict([k=>v for (k,v) in pairs(JSON.parse(day[1])) if ((!in(k,stopwords(Languages.English()))) && length(k)>1) ])
    OrderedDict([i for i in sort(dict,byvalue=true,rev=true)][1:num]...)
end

function news_word_cloud_dict(word_df, date)   
    col_dict(word_df, date, :word_cloud, 50) 
end

function create_surprise_dict(word_df, date)   
    col_dict(word_df, date, :word_changes, 20)  
end
