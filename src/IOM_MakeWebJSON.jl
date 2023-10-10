module IOM_MakeWebJSON

    using JSON
    using OrderedCollections
    using DataFrames
    using Dates
    using LibPQ
    using TimeZones
    using IOM_WritePostgres
    using Languages

    include("create_web_JSON.jl")

    include("data_dict.jl")

    include("nestedDictionaryFuncs/col_dict.jl")
    include("nestedDictionaryFuncs/keywords_dict.jl")
    include("nestedDictionaryFuncs/news_dict.jl")
    include("nestedDictionaryFuncs/word_dict.jl")


    export create_web_JSON
end
