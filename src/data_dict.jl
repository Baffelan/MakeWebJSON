function create_data_dict(df, date)
    return OrderedDict("keywords"=>keywords_dict(df,Date(date)))
end
