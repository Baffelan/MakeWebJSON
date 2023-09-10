using JSON
using MakeWebJSON
using Dates

j =  create_web_JSON("001", date=Date("2023-08-23"))


open("user_web_socialmedia.json", "w") do f
    write(f, JSON.json(j))
end

