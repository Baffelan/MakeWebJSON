function news_dict(word_df, date)
    news_dict = OrderedDict()
    
    news_dict["news_sentiment_average"] = []

    news_dict["news_articles"] = create_news_article_array(word_df, date)
    return news_dict

end


function create_news_article_array(word_df, date)
    arts = word_df[word_df.date.==date, :articles][1]
    
    
    
    if length(arts)>1
        conn = LibPQ.Connection(get_back_connection())
        q = replace("SELECT * FROM raw WHERE uri IN $(arts)","{"=>"('")
        q = replace(q, ","=>"','")
        q = replace(q, "}"=>"')")
        result = execute(conn, q)
        arts = DataFrame(result)
        close(conn); 
    elseif length(arts[1])>0
        conn = LibPQ.Connection(get_back_connection())
        result = execute(conn, replace("SELECT * FROM raw WHERE uri IN ('$(arts[1])')","\""=>"'"))
        arts = DataFrame(result)
        close(conn);
    else
        arts = DataFrame()
    end
    
    return article_row_to_dict.([r for r in eachrow(arts[1:min(10,nrow(arts)),:]) if r.date==date])
end


function article_row_to_dict(row)
    d = OrderedDict()
    d["news_api_data"] = OrderedDict(zip(names(row),row))
    #println(d["news_api_data"]["date"])
    shares = OrderedDict(JSON.parse(d["news_api_data"]["shares"]))
    if length(keys(shares))>0
        d["news_shares_sum"] = sum(values(shares))
    else
        d["news_shares_sum"] = 0
    end
    return d
end