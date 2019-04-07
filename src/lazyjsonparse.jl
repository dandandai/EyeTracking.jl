using LazyJSON

using DataFrames


##################################################################
# x= open("examplejsondata.json", "r")
# y= read(x)
# typeof(y)
# aa = LazyJSON.parse(y)
#
# function createdataframe(input::Dict)
#   parsedinput = Dict()
#   for x in keys(input)
#     parsedinput[Symbol(x)] = [input[x]]
#   end
#   return DataFrame(parsedinput)
# end
#
# createdataframe(aa)
##################################################################

# println(typeof(a))
# a["pc"]
# typeof(a["pc"])
#
# convert(Vector{float(Int)}, a["pc"])
#
# ddd = DataFrame(pc = float(Int)[])
#
# for v in zip(a["pc"])
#            push!(ddd, v)
# end
#
# ddd
# print(ddd)

##################################################################
######try conver json to dataframe
#
# j = LazyJSON.value("""{"x": [1,2,3,4,5], "y": [2,4,6,8,10]}""")
#
# print(j)
#
# ######这步的目的是什么？？？
# # LazyJSON.Object
#
# j["x"]
#
# print(typeof(j["x"]))
#
# ######这步的目的是什么？？？
# # LazyJSON.Array
#
# convert(Vector{Int}, j["x"])
#
# d = DataFrame(x = Int[], y = Int[])
#
# for v in zip(j["x"], j["y"])
#            push!(d, v)
# end
#
# print(d)
##################################################################


##################################################################


df = DataFrame

open("examplejsondata.json") do file
   line = 1
   num = 1
   while !eof(file)
     fileLine = readline(file)              # read JSON line
     pLine = LazyJSON.parse(fileLine)       # Parse JSON line
     df1 = DataFrame(Dict(pLine))            # Convert parsed JSON line (Dict type)
     println(num)
     println(pLine)
     println(df1)
     println()
     # df2 = join(df, df1, on = :eye)
     # df2 = join(df, df1, kind = :cross, makeunique = true)
     global df = [df; df1]          #combine dataframe (incomplete -- repeat with all keys)
     println(df)
     line += 1
     num += 1
   end
end



##################################################################



##################################################################
