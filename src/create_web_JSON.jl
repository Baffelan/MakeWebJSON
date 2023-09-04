using JSON
using OrderedCollections
using DataFrames

include("creating_nested_dicts.jl")


function create_web_JSON(user::Dict, df::DataFrame, date::String)
    j = OrderedDict()

    j["customer_id"]=user["ID"] 

    j["customer_name"]=user["name"]

    j["customer_information"]=user["information"]

    j["data"] = create_data_dict(df, user, date)

    return j
end
