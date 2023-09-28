

function previous_sentiments(word_df, date)
    sorted_word_df = sort(word_df, :date, rev=true)
    return sorted_word_df[sorted_word_df.date.<=date, :sentiment]
end


function create_surprise_dict(word_df, date)    
    day_changes = word_df[word_df.date.==date, :word_changes]
    change_dict = OrderedDict([k=>v for (k,v) in pairs(JSON.parse(day_changes[1])) if ((!in(k,stopwords(Languages.English()))) && length(k)>1) ])
    OrderedDict([i for i in sort(change_dict,byvalue=true,rev=true)][1:20]...)
end


function create_news_word_cloud_dict(word_df, date)    
    day_cloud = word_df[word_df.date.==date, :word_cloud]
    
    cloud_dict = OrderedDict([k=>v for (k,v) in pairs(JSON.parse(day_cloud[1])) if ((!in(k,stopwords(Languages.English()))) && length(k)>1) ])

    OrderedDict([i for i in sort(cloud_dict,byvalue=true,rev=true)][1:50]...)
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

function create_news_dict(word_df, date)
    news_dict = OrderedDict()
    
    news_dict["news_sentiment_average"] = []

    news_dict["news_articles"] = create_news_article_array(word_df, date)
    return news_dict

end

function create_word_dict(df, word, date)
    println("Collecting information for keyword: ", word)

    word_df = df[df.keyword.==word, :]

    word_dict = OrderedDict()
    word_dict["keyword_name"]=word
    word_dict["sentiment"] = previous_sentiments(word_df, date)
    word_dict["anomalous"] = word_df[word_df.date.==date,:anomalous_day][1]
    word_dict["surprise_words"] = create_surprise_dict(word_df, date)
    word_dict["news_word_cloud"] = create_news_word_cloud_dict(word_df, date)
    word_dict["news"] = create_news_dict(word_df, date)

    return word_dict
end




function create_keywords_dict(df, date)
    keyword_dict = OrderedDict()

    words = unique(df.keyword)
    println(words)
    for word in words
        keyword_dict[word]=create_word_dict(df, word, date)
    end
    return keyword_dict
end

function create_data_dict(df, date)
    return OrderedDict("keywords"=>create_keywords_dict(df,Date(date)))
end
