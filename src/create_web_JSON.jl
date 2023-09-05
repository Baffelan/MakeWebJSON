using JSON
using OrderedCollections
using DataFrames
using Dates

include("creating_nested_dicts.jl")
include("ReadWritePostgres.jl")

function create_web_JSON(userID::String; date::Date=today())

    user_df = query_postgres("users", condition=string("WHERE ID='",userID,"'"), sorted=false)
    
    user = Dict(pairs(user_df[1,:]))

    df = query_postgres("processedarticles")

    j = OrderedDict()

    j["customer_id"]=user[:id] 

    j["customer_name"]=user[:name]

    j["customer_information"]=user[:information]

    j["data"] = create_data_dict(df, user, date)

    return j
end


