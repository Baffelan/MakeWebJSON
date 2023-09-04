using JSON
using MakeWebJSON
user = JSON.parsefile("user.json")


df = query_postgres("processedarticles")

j =  create_web_JSON(user, df, "2023-01-01")

open("user_web_example.json", "w") do f
    write(f, JSON.json(j))
end

