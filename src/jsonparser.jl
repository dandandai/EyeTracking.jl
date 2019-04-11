function parsefile()
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
    pLine["pv"] = 0.0
    pLine["l"] = 0
    pLine["dir"] = 0
    pLine["sig"] = 0
    pLine["ts"] = 0
    pLine["s"] = 0

    dataframe = DataFrame(ts=pLine["ts"],s=pLine["s"],sig=pLine["sig"],dir=pLine["dir"],vts=pLine["vts"],pts=pLine["pts"],
            pv=pLine["pv"],gy=pLine["gy"],ac=pLine["ac"],gp3=pLine["gp3"],gp=pLine["gp"],l=pLine["l"],gd=pLine["gd"],pd=pLine["pd"],pc=pLine["pc"],eye=pLine["eye"])

    # global dataf = DataFrame(Dict(pLine))
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
      if (!(haskey(parseline,"pv")))
        parseline["pv"] = 0.0
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
      dataframe = vcat(dataframe, df1)
    end
    CSV.write("Output.csv", dataframe)
  end
end


# parsefile()
