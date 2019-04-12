# function parse_file(path::String)
#     Base.display("Hello world! !")
#     df = parse(path)
#     return df
# end

using JSON
using DataFrames
using CSV

function foo()

        open("examplejsondata.json")do f

                a = DataFrame(ts=0,s=0,dir="",sig=0,vts=0,pts=0,pv=0,gy_x=0.0,gy_y=0.0,
                gy_z=0.0,ac_x=0.0,ac_y=0.0,ac_z=0.0,gp3_x=0.0,gp3_y=0.0,gp3_z=0.0,gp_x=0.0,
                gp_y=0.0,l=0,gd_l_x=0.0,gd_l_y=0.0,gd_l_z=0.0,gd_r_x=0.0,gd_r_y=0.0,gd_r_z=0.0,
                pd_l=0.0,pd_r=0.0,pc_l_x=0.0,pc_l_y=0.0,pc_l_z=0.0,pc_r_x=0.0,pc_r_y=0.0,pc_r_z=0.0)

                b = DataFrame(ts=0,s=0,dir="",sig=0,vts=0,pts=0,pv=0,gy_x=0.0,gy_y=0.0,
                gy_z=0.0,ac_x=0.0,ac_y=0.0,ac_z=0.0,gp3_x=0.0,gp3_y=0.0,gp3_z=0.0,gp_x=0.0,
                gp_y=0.0,l=0,gd_l_x=0.0,gd_l_y=0.0,gd_l_z=0.0,gd_r_x=0.0,gd_r_y=0.0,gd_r_z=0.0,
                pd_l=0.0,pd_r=0.0,pc_l_x=0.0,pc_l_y=0.0,pc_l_z=0.0,pc_r_x=0.0,pc_r_y=0.0,pc_r_z=0.0)

                m = readlines(f)
                for p in m

                n = JSON.parse(p)

                a[end,:ts] = n["ts"]
                a[end,:s] = n["s"]

                if (haskey(n,"pc"))
                if n["eye"]=="left"
                a[end,:pc_l_x]  = n["pc"][1]
                a[end,:pc_l_y]  = n["pc"][2]
                a[end,:pc_l_z]  = n["pc"][3]
                end
                if n["eye"]=="right"
                a[end,:pc_r_x]  = n["pc"][1]
                a[end,:pc_r_y]  = n["pc"][2]
                a[end,:pc_r_z]  = n["pc"][3]
                end
                end

                if (haskey(n,"pd"))
                        if n["eye"]=="left"
                        a[end,:pd_l]  = n["pd"]
                end
                if n["eye"]=="right"
                a[end,:pd_r]  = n["pd"]
                end
                end

                if (haskey(n,"gd"))
                if n["eye"]=="left"
                a[end,:gd_l_x]  = n["gd"][1]
                a[end,:gd_l_y]  = n["gd"][2]
                a[end,:gd_l_z]  = n["gd"][3]
                end
                if n["eye"]=="right"
                a[end,:gd_r_x]  = n["gd"][1]
                a[end,:gd_r_y]  = n["gd"][2]
                a[end,:gd_r_z]  = n["gd"][3]
                end
                end

                if (haskey(n,"gp"))
                a[end,:gp_x]  = n["gp"][1]
                a[end,:gp_y]  = n["gp"][2]
                end
                if (haskey(n,"l"))
                a[end,:l]  = n["l"]
                end

                if (haskey(n,"gp3"))
                a[end,:gp3_x]  = n["gp3"][1]
                a[end,:gp3_y]  = n["gp3"][2]
                a[end,:gp3_z]  = n["gp3"][3]
                a = vcat(a,b)
                end

                if (haskey(n,"ac"))
                a[end,:ac_x]  = n["ac"][1]
                a[end,:ac_y]  = n["ac"][2]
                a[end,:ac_z]  = n["ac"][3]
                a = vcat(a,b)
                end

                if (haskey(n,"gy"))
                a[end,:gy_x]  = n["gy"][1]
                a[end,:gy_y]  = n["gy"][2]
                a[end,:gy_z]  = n["gy"][3]
                a = vcat(a,b)
                end

                if (haskey(n,"pts"))
                a[end,:pts]  = n["pts"]
                end

                if (haskey(n,"pv"))
                a[end,:pv]  = n["pv"]
                end

                if (haskey(n,"vts"))
                a[end,:vts]  = n["vts"]
                a = vcat(a,b)
                end

                if (haskey(n,"dir"))
                a[end,:dir]  = n["dir"]
                end

                if (haskey(n,"sig"))
                a[end,:sig]  = n["sig"]
                a = vcat(a,b)
                end
                # a = a[setdiff!(1:end,), :]
        end
        #println(a)
        # row = nrow(a)
        # println(row)
        # a = a[setdiff!(1:end, row-1), :]
        CSV.write("test73.csv",a)
        end

end
