function parsefile()
  open("examplejsondata.json") do file

    dataframe = DataFrame(ts=Int64[],s=Int64[],sig=Int64[],dir=String[],vts=Int64[],pts=Int64[],
        pv=Int64[],gy=Float64[],ac=Float64[],gp3=Float64[],gp=Float64[],l=String[],gd=Float64[],pd=Float64[],pc=Float64[],eye=String[])

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

    # CSV.write("exampleOutput.csv", dataframe)
    print(dataframe)
  end
end


parsefile()
