using JSON
using DataFrames
using CSV

##################################################################
dataf = DataFrame

open("examplejsondata.json") do file
  fileLine = readline(file)
  pLine = JSON.parse(fileLine)
  pLine["eye"] =""
  pLine["pd"] = 0.0
  pLine["gd"] = 0.0
  pLine["gp"] = 0.0
  pLine["gp3"] = 0.0
  pLine["gy"] = 0.0
  pLine["ac"] = 0.0
  pLine["pts"] = 0.0
  pLine["vts"] = 0.0
  pLine["pc"] = 0.0
  pLine["l"] = 0
  pLine["dir"] = 0
  pLine["sig"] = 0

  global dataf = DataFrame(Dict(pLine))
  lines = readlines(file)
  for row in lines
    parseline = JSON.parse(row)
    if (!(haskey(parseline,"pd")))
      parseline["pd"] = 0.0
    end
    if (!(haskey(parseline,"gd")))
      parseline["gd"] = 0.0
    end
    if (!(haskey(parseline,"gp")))
      parseline["gp"] = 0.0
    end
    if (!(haskey(parseline,"gp3")))
      parseline["gp3"] = 0.0
    end
    if (!(haskey(parseline,"gy")))
      parseline["gy"] = 0.0
    end
    if (!(haskey(parseline,"ac")))
      parseline["ac"] = 0.0
    end
    if (!(haskey(parseline,"pts")))
      parseline["pts"] = 0.0
    end
    if (!(haskey(parseline,"vts")))
      parseline["vts"] = 0.0
    end
    if (!(haskey(parseline,"eye")))
      parseline["eye"] = ""
    end
    if (!(haskey(parseline,"pc")))
      parseline["pc"] = 0.0
    end
    if (!(haskey(parseline,"l")))
      parseline["l"] = 0
    end
    if (!(haskey(parseline,"dir")))
      parseline["dir"] = 0
    end
    if (!(haskey(parseline,"sig")))
      parseline["sig"] = 0
    end

    df1 = DataFrame(Dict(parseline))
    global dataf = append!(dataf, df1)
  end
end

println(dataf)

CSV.write("Output.csv", dataf)
