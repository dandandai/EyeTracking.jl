using LazyJSON
using DataFrames

# j = String(read("examplejsondata.json"))
#
# function f(json)
#     v = LazyJSON.parse(json)
#     # v["shapes"]["scope"]["enum"][1]
#     println(v)
# end
#
# ll = length(j)
#
# f(j)

x= open("livedata1.json", "r")
y= read(x)
a = LazyJSON.parse(y)

function rrr()
    Base.display(a)

    return
end

rrr()

println(typeof(a))
a["pc"]
typeof(a["pc"])

convert(Vector{float(Int)}, a["pc"])

ddd = DataFrame(pc = float(Int)[])

for v in zip(a["pc"])
           push!(ddd, v)
end

ddd
print(ddd)

##################################################################
######try conver json to dataframe

j = LazyJSON.value("""{"x": [1,2,3,4,5], "y": [2,4,6,8,10]}""")

print(j)

######这步的目的是什么？？？
# LazyJSON.Object

j["x"]

print(typeof(j["x"]))

######这步的目的是什么？？？
# LazyJSON.Array

convert(Vector{Int}, j["x"])

d = DataFrame(x = Int[], y = Int[])

for v in zip(j["x"], j["y"])
           push!(d, v)
end

print(d)
##################################################################

##################################################################
# open("examplejsondata.json") do file
#     for ln in eachline(file)
#         Base.display(LazyJSON.parse("$(length(ln)), $(ln)"))
#     end
# end

i = Dict{}
typeof(i)

open("examplejsondata.json") do f
   line = 1
   while !eof(f)
     x = readline(f)
     t = LazyJSON.parse(x)
     # println(t)
     global i = t

     line += 1
   end
end

print(typeof(i))
