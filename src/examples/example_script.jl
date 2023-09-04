using JSON
using MakeWebJSON
user = JSON.parsefile("./src/createWebJSON/user.json")


df = query_postgres("processedarticles")

j =  createWebJSON(user, df)

open("user_web_example.json", "w") do f
    write(f, JSON.json(j))
end

