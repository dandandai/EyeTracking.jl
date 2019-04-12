# function parsefile()
#   open("examplejsondata.json") do file
#
#     dataframe = DataFrame(ts=Int64[],s=Int64[],sig=Int64[],dir=String[],vts=Int64[],pts=Int64[],
#         pv=Int64[],gy=Float64[],ac=Float64[],gp3=Float64[],gp=Float64[],l=String[],gd=Float64[],pd=Float64[],pc=Float64[],eye=String[])
#
#     lines = readlines(file)
#     for row in lines
#       parseline = JSON.parse(row)
#       if (!(haskey(parseline,"pd")))
#         parseline["pd"] = 0.0
#       end
#       if (!(haskey(parseline,"gd")))
#         parseline["gd"] = 0.0
#       end
#       if (!(haskey(parseline,"gp")))
#         parseline["gp"] = 0.0
#       end
#       if (!(haskey(parseline,"gp3")))
#         parseline["gp3"] = 0.0
#       end
#       if (!(haskey(parseline,"gy")))
#         parseline["gy"] = 0.0
#       end
#       if (!(haskey(parseline,"ac")))
#         parseline["ac"] = 0.0
#       end
#       if (!(haskey(parseline,"pts")))
#         parseline["pts"] = 0.0
#       end
#       if (!(haskey(parseline,"pv")))
#         parseline["pv"] = 0.0
#       end
#       if (!(haskey(parseline,"vts")))
#         parseline["vts"] = 0.0
#       end
#       if (!(haskey(parseline,"eye")))
#         parseline["eye"] = ""
#       end
#       if (!(haskey(parseline,"pc")))
#         parseline["pc"] = 0.0
#       end
#       if (!(haskey(parseline,"l")))
#         parseline["l"] = 0
#       end
#       if (!(haskey(parseline,"dir")))
#         parseline["dir"] = 0
#       end
#       if (!(haskey(parseline,"sig")))
#         parseline["sig"] = 0
#       end
#
#       df1 = DataFrame(Dict(parseline))
#       dataframe = vcat(dataframe, df1)
#     end
#
#     CSV.write("exampleOutput.csv", dataframe)
#     # print(dataframe)
#   end
# end
#
#
# parsefile()


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function parser()

  open("examplejsondata.json") do file
    df1 = DataFrame(t=0,s=0,dir="",sig=0,vts=0,pts=0,pv=0,gy_x=0.0,gy_y=0.0,
    gy_z=0.0,ac_x=0.0,ac_y=0.0,ac_z=0.0,gp3_x=0.0,gp3_y=0.0,gp3_z=0.0,gp_x=0.0,
    gp_y=0.0,l=0,gd_l_x=0.0,gd_l_y=0.0,gd_l_z=0.0,gd_r_x=0.0,gd_r_y=0.0,gd_r_z=0.0,
    pd_l=0.0,pd_r=0.0,pc_l_x=0.0,pc_l_y=0.0,pc_l_z=0.0,pc_r_x=0.0,pc_r_y=0.0,pc_r_z=0.0)

    df2 = DataFrame(ts=0,s=0,dir="",sig=0,vts=0,pts=0,pv=0,gy_x=0.0,gy_y=0.0,
    gy_z=0.0,ac_x=0.0,ac_y=0.0,ac_z=0.0,gp3_x=0.0,gp3_y=0.0,gp3_z=0.0,gp_x=0.0,
    gp_y=0.0,l=0,gd_l_x=0.0,gd_l_y=0.0,gd_l_z=0.0,gd_r_x=0.0,gd_r_y=0.0,gd_r_z=0.0,
    pd_l=0.0,pd_r=0.0,pc_l_x=0.0,pc_l_y=0.0,pc_l_z=0.0,pc_r_x=0.0,pc_r_y=0.0,pc_r_z=0.0)

    lines = readlines(file)

    for row in lines
      parseline = JSON.parse(row)

      df1[end,:ts] = parseline["ts"]
      df1[end,:s] = parseline["s"]

      if (haskey(parseline,"pc"))
              if parseline["eye"] == "left"
                      df1[end,:pc_l_x] = parseline["pc"][1]
                      df1[end,:pc_l_y] = parseline["pc"][2]
                      df1[end,:pc_l_z] = parseline["pc"][3]
              end
              if parseline["eye"]=="right"
                      df1[end,:pc_r_x] = parseline["pc"][1]
                      df1[end,:pc_r_y] = parseline["pc"][2]
                      df1[end,:pc_r_z] = parseline["pc"][3]
              end
      end

      if (haskey(parseline,"pd"))
              if parseline["eye"] == "left"
                      df1[end,:pd_l] = parseline["pd"]
              end
              if parseline["eye"] == "right"
                      df1[end,:pd_r] = parseline["pd"]
              end
      end

      if (haskey(parseline,"gd"))
              if parseline["eye"] == "left"
                  df1[end,:gd_l_x] = parseline["gd"][1]
                  df1[end,:gd_l_y] = parseline["gd"][2]
                  df1[end,:gd_l_z] = parseline["gd"][3]
              end
              if n["eye"]=="right"
                  df1[end,:gd_r_x] = parseline["gd"][1]
                  df1[end,:gd_r_y] = parseline["gd"][2]
                  df1[end,:gd_r_z] = parseline["gd"][3]
              end
      end

      if (haskey(parseline,"gp"))
              df1[end,:gp_x] = parseline["gp"][1]
              df1[end,:gp_y] = parseline["gp"][2]
      end

      if (haskey(parseline,"l"))
              df1[end,:l] = parseline["l"]
      end

      if (haskey(parseline,"gp3"))
              df1[end,:gp3_x] = parseline["gp3"][1]
              df1[end,:gp3_y] = parseline["gp3"][2]
              df1[end,:gp3_z] = parseline["gp3"][3]
              df1 = vcat(df1,df2)
      end

      if (haskey(parseline,"ac"))
              df1[end,:ac_x] = parseline["ac"][1]
              df1[end,:ac_y] = parseline["ac"][2]
              df1[end,:ac_z] = parseline["ac"][3]
              df1 = vcat(df1,df2)
      end

      if (haskey(n,"gy"))
              df1[end,:gy_x] = parseline["gy"][1]
              df1[end,:gy_y] = parseline["gy"][2]
              df1[end,:gy_z] = parseline["gy"][3]
              df1 = vcat(df1,df2)
      end

      if (haskey(n,"pts"))
              df1[end,:pts] = parseline["pts"]
      end

      if (haskey(n,"pv"))
              df1[end,:pv] = parseline["pv"]
      end

      if (haskey(n,"vts"))
              df1[end,:vts] = parseline["vts"]
              df1 = vcat(df1,df2)
      end

      if (haskey(n,"dir"))
              df1[end,:dir] = parseline["dir"]
      end

      if (haskey(n,"sig"))
              df1[end,:sig] = parseline["sig"]
              df1 = vcat(df1,df2)
      end

    end

    CSV.write("exampleOutput22.csv", df1)
  end
end
