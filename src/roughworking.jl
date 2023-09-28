processed_df = query_postgres("processedarticles", "back", condition="where date='2023-09-27' and user_id='999'")

create_web_JSON(999, 1, processed_df)
today()-Day(1)

paper = query_postgres("api.papers", "forward", condition="where userid='999'", sorted=false)[2,:]
JSON.parse(paper.papers)["data"]["keywords"]["facebook"]

open("test.json","w") do f
    print(f, paper.papers)
end