# MakeWebJSON

[![Build Status](https://github.com/StirlingSmith/MakeWebJSON.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/StirlingSmith/MakeWebJSON.jl/actions/workflows/CI.yml?query=branch%3Amain)

## Example script
```julia
using JSON
using MakeWebJSON
user = JSON.parsefile("user.json")


df = query_postgres("processedarticles")

j =  create_web_JSON(user, df, "2023-01-01")

open("user_web_example.json", "w") do f
    write(f, JSON.json(j))
end

```
Note that the only functions exported by MakeWebJSON are query_postgres, and create_web_JSON