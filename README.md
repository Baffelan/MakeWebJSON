# MakeWebJSON

[![Build Status](https://github.com/StirlingSmith/MakeWebJSON.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/StirlingSmith/MakeWebJSON.jl/actions/workflows/CI.yml?query=branch%3Amain)

## Example script
```julia
using JSON
using MakeWebJSON
using Dates

j =  create_web_JSON("001", date=Date("2023-01-01")) # Note that default date is date=today()

open("user_web_example.json", "w") do f
    write(f, JSON.json(j))
end



```
Note that the only functions exported by MakeWebJSON are query_postgres, and create_web_JSON