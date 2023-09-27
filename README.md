# MakeWebJSON

[![Build Status](https://github.com/StirlingSmith/MakeWebJSON.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/StirlingSmith/MakeWebJSON.jl/actions/workflows/CI.yml?query=branch%3Amain)

## Project Structure
This is a package for creating a daily report .json file and storing it in a database for the iom-web package to use for generating a front end.

A data dictionary of the .json structure can be found in `XXXXXXX.json`.

The `create_web_JSON` function generates a series of nested dictionaries that mimic the structure in `XXXXXXX.json`, which is then parsed to a .json format.

Each nested dictionary is created by a function with the name `create_[object_name]_dict`, where the object name is the name of the object that the dictionary will be associated with in the .json file.

## Installation
To use this package, the package `WritePostgres.jl` must first be installed.
```julia
using Pkg

Pkg.add("https://github.com/Baffelan/WritePostgres")
```
After this, the package can be installed with.
```julia
Pkg.add("https://github.com/Baffelan/MakeWebJSON")
```

## Work Flow

## Example script
to do
```julia
using JSON
using MakeWebJSON
using Dates




open("user_web_example.json", "w") do f
    write(f, JSON.json(j))
end



```
Note that the only function exported by MakeWebJSON is create_web_JSON.

# Config
This package uses environment variables to access remote postgreSQL servers.

The required environment variables are:
```
IOMFRNTDB="Forward_Facing_DataBase_Name"
IOMFRNTUSER="User1"
IOMFRNTPASSWORD="User1_password"
IOMFRNTHOST="Forward_Facing_Host_Address"
IOMFRNTPORT="Forward_Facing_Port"

IOMBCKDB="Back_Facing_DataBase_Name"
IOMBCKUSER="User2"
IOMBCKPASSWORD="User2_password"
IOMBCKHOST="Back_Facing_Host_Address"
IOMBCKPORT="Back_Facing_Port"

NEWSAPIKEY="API_KEY"
```
