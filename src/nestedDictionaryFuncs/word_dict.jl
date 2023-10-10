function word_dict(df, word, date)
    println("Collecting information for keyword: ", word)

    word_df = df[df.keyword.==word, :]

    word_dict = OrderedDict()
    word_dict["keyword_name"]=word
    word_dict["sentiment"] = previous_sentiments(word_df, date)
    word_dict["anomalous"] = word_df[word_df.date.==date,:anomalous_day][1]
    word_dict["surprise_words"] = surprise_dict(word_df, date)
    word_dict["news_word_cloud"] = news_word_cloud_dict(word_df, date)
    word_dict["news"] = news_dict(word_df, date)

    return word_dict
end


function previous_sentiments(word_df, date)
    sorted_word_df = sort(word_df, :date, rev=true)
    return sorted_word_df[sorted_word_df.date.<=date, :sentiment]
end
