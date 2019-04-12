function parser()

  open("examplejsondata.json") do file
    df1 = DataFrame(Timestamp=0,Status=0,SignalDir="",Signal=0,VideoTS=0,PresentationTS=0,PipelineVer=0,GyroscopeX=0.0,GyroscopeY=0.0,
    GyroscopeZ=0.0,AccelerometerX=0.0,AccelerometerY=0.0,AccelerometerZ=0.0,GazePos3DX=0.0,GazePos3DY=0.0,GazePos3DZ=0.0,GazePosX=0.0,
    GazePosY=0.0,Latency=0,GazeDirectionLX=0.0,GazeDirectionLY=0.0,GazeDirectionLZ=0.0,GazeDirectionRX=0.0,GazeDirectionRY=0.0,GazeDirectionRZ=0.0,
    PupilDiaL=0.0,PupilDiaR=0.0,PupilCenterLX=0.0,PupilCenterLY=0.0,PupilCenterLZ=0.0,PupilCenterRX=0.0,PupilCenterRY=0.0,PupilCenterRZ=0.0)

    df2 = DataFrame(Timestamp=0,Status=0,SignalDir="",Signal=0,VideoTS=0,PresentationTS=0,PipelineVer=0,GyroscopeX=0.0,GyroscopeY=0.0,
    GyroscopeZ=0.0,AccelerometerX=0.0,AccelerometerY=0.0,AccelerometerZ=0.0,GazePos3DX=0.0,GazePos3DY=0.0,GazePos3DZ=0.0,GazePosX=0.0,
    GazePosY=0.0,Latency=0,GazeDirectionLX=0.0,GazeDirectionLY=0.0,GazeDirectionLZ=0.0,GazeDirectionRX=0.0,GazeDirectionRY=0.0,GazeDirectionRZ=0.0,
    PupilDiaL=0.0,PupilDiaR=0.0,PupilCenterLX=0.0,PupilCenterLY=0.0,PupilCenterLZ=0.0,PupilCenterRX=0.0,PupilCenterRY=0.0,PupilCenterRZ=0.0)

    lines = readlines(file)

    for row in lines
      parseline = JSON.parse(row)

      df1[end,:Timestamp] = parseline["ts"]
      df1[end,:Status] = parseline["s"]

      if (haskey(parseline,"pc"))
              if parseline["eye"] == "left"
                      df1[end,:PupilCenterLX] = parseline["pc"][1]
                      df1[end,:PupilCenterLY] = parseline["pc"][2]
                      df1[end,:PupilCenterLZ] = parseline["pc"][3]
              end
              if parseline["eye"]=="right"
                      df1[end,:PupilCenterRX] = parseline["pc"][1]
                      df1[end,:PupilCenterRY] = parseline["pc"][2]
                      df1[end,:PupilCenterRZ] = parseline["pc"][3]
              end
      end

      if (haskey(parseline,"pd"))
              if parseline["eye"] == "left"
                      df1[end,:PupilDiaL] = parseline["pd"]
              end
              if parseline["eye"] == "right"
                      df1[end,:PupilDiaR] = parseline["pd"]
              end
      end

      if (haskey(parseline,"gd"))
              if parseline["eye"] == "left"
                  df1[end,:GazeDirectionLX] = parseline["gd"][1]
                  df1[end,:GazeDirectionLY] = parseline["gd"][2]
                  df1[end,:GazeDirectionLZ] = parseline["gd"][3]
              end
              if parseline["eye"]=="right"
                  df1[end,:GazeDirectionRX] = parseline["gd"][1]
                  df1[end,:GazeDirectionRY] = parseline["gd"][2]
                  df1[end,:GazeDirectionRZ] = parseline["gd"][3]
              end
      end

      if (haskey(parseline,"gp"))
              df1[end,:GazePosX] = parseline["gp"][1]
              df1[end,:GazePosY] = parseline["gp"][2]
      end

      if (haskey(parseline,"l"))
              df1[end,:Latency] = parseline["l"]
      end

      if (haskey(parseline,"gp3"))
              df1[end,:GazePos3DX] = parseline["gp3"][1]
              df1[end,:GazePos3DY] = parseline["gp3"][2]
              df1[end,:GazePos3DZ] = parseline["gp3"][3]
              df1 = vcat(df1,df2)
      end

      if (haskey(parseline,"ac"))
              df1[end,:AccelerometerX] = parseline["ac"][1]
              df1[end,:AccelerometerY] = parseline["ac"][2]
              df1[end,:AccelerometerZ] = parseline["ac"][3]
              df1 = vcat(df1,df2)
      end

      if (haskey(parseline,"gy"))
              df1[end,:GyroscopeX] = parseline["gy"][1]
              df1[end,:GyroscopeY] = parseline["gy"][2]
              df1[end,:GyroscopeZ] = parseline["gy"][3]
              df1 = vcat(df1,df2)
      end

      if (haskey(parseline,"pts"))
              df1[end,:PresentationTS] = parseline["pts"]
      end

      if (haskey(parseline,"pv"))
              df1[end,:PipelineVer] = parseline["pv"]
      end

      if (haskey(parseline,"vts"))
              df1[end,:VideoTS] = parseline["vts"]
              df1 = vcat(df1,df2)
      end

      if (haskey(parseline,"dir"))
              df1[end,:SignalDir] = parseline["dir"]
      end

      if (haskey(parseline,"sig"))
              df1[end,:Signal] = parseline["sig"]
              df1 = vcat(df1,df2)
      end

    end

    CSV.write("exampleOutput22.csv", df1)
  end
end
