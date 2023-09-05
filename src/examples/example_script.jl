using JSON
using MakeWebJSON
using Dates

j =  create_web_JSON("001", date=Date("2023-01-01"))

open("user_web_example.json", "w") do f
    write(f, JSON.json(j))
end

