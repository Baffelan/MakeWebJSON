using JSON
using OrderedCollections
using DataFrames
using Dates
import WritePostgres.user_from_id, WritePostgres.query_postgres, WritePostgres.get_connection  

include("creating_nested_dicts.jl")

function create_web_JSON(userID::String, df; date::Date=today())    
    user = user_from_id(userID)

    # df = query_postgres("processedarticles")

    j = OrderedDict()

    j["customer_id"]=userID

    #j["customer_name"]=user[:name]

    #j["customer_information"]=user[:information]

    j["data"] = create_data_dict(df, user, date)

    return j
end

# j = create_web_JSON("001", date=Date("2023-01-01"))


# j["data"]["keywords"]["metaverse"]



