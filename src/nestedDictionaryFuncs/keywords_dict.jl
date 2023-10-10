function keywords_dict(df, date)
    keyword_dict = OrderedDict()

    words = unique(df.keyword)
    println(words)
    for word in words
        keyword_dict[word]=word_dict(df, word, date)
    end
    return keyword_dict
end