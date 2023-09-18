

function create_web_JSON(userID::Int, collectionID::Int, df; date::Date=today())    
    # user = user_from_id(userID)
    # df = query_postgres("processedarticles")

    j = OrderedDict()

    j["customer_id"]=userID

    # j["customer_name"]=user[:name]
    # j["customer_information"]=user[:information]

    j["data"] = create_data_dict(df, date)
    
    conn = LibPQ.Connection(get_forward_connection())
    execute(conn, "BEGIN;")
    
    LibPQ.load!(
        (
            userID=[userID], 
            collectionID=[collectionID],
            editionDate=[now(localzone())-Day(1)],
            papers=[JSON.json(j)]

        ),
        conn,
        "INSERT INTO api.papers (userID, collectionID, editionDate, papers) VALUES (\$1, \$2, \$3, \$4);"
    );

    execute(conn, "COMMIT;")
end


# df = query_postgres("processedarticles", "back", condition="where user_id='999' and date='2023-08-09'")

# df.anomalous_day
# query_postgres("api.papers", "forward", sorted=false)
# create_web_JSON(999, 1, df, date=Date("2023-08-09"))
# get_forward_connection()
# conn = LibPQ.Connection(WritePostgres.get_forward_connection())
# execute(conn, "BEGIN;")
# LibPQ.load!(
#     (
#         userID=[999], 
#         collectionID=[1],
#         editionDate=[now(localzone())],
#         papers=j 

#     ),
#     conn,
#     "INSERT INTO api.papers (userID, collectionID, editionDate, papers) VALUES (\$1, \$2, \$3, \$4);"
# );

# execute(conn, "COMMIT;")
# j = JSON.parsefile("user_web_socialmedia.json")


# j = create_web_JSON("001", date=Date("2023-01-01"))


# j["data"]["keywords"]["metaverse"]



