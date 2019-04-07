# using JSON
# import JSON
#
# # readdir()
#
# ####  open JSON file ####
# x = open("examplejsondata.json", "r")
# ####  read JSON lines ####
# y = readlines(x)
# # typeof(y)
# print(y)
# JSON.parse(y)
#
# ll = length(y)
#
# # for n in [1,ll]
# #     r = JSON.parse(y)
# # end
#
# # z = JSON.parse(y)
# #
# # s1 = readlines("examplejsondata.json.json")
#
# open("examplejsondata.json", "r")
# JSON.parsefile("/Users/apple/Desktop/Master of Computing & Innovation Project/EyeTracking/examplejsondata.json")
#
# ##################################################################
#
# # 能打印一行 json, parse一行
# open("examplejsondata.json") do stream
#     for line in eachline(stream)
#         println(line)
#         f = JSON.parse(line)
#         println(f)
#         return f
#     end
# end
# ##################################################################
#
#
# ##################################################################
#
# ###打开并打印 json文件的 function
# # function readFunc(stream)
# #     for line in eachline(stream)
# #         println(line)
# #     end
# # end
# #
# # readj = open(readFunc,"examplejsondata.json")
# # display(readj)
# #
# # z = JSON.parse(readj)
#
#
# ##################################################################
#
# ##################################################################
# portfolio =  """[
# {
#   "id":1,
#   "company":"Telstra",
#   "symbol":"ASX:TLS",
#   "price":5.27
# },
# {
#   "id":2,
#   "company":"BHP",
#   "symbol":"ASX:BHP",
#   "price":37.77
# },
# {
#   "id":3,
#   "company":"Commonwealth Bank of Australia",
#   "symbol":"ASX:CBA",
#   "price":77.58
# }
# ]"""
#
# jsonArray = JSON.parse(portfolio)
#
# ##################################################################
#
# ##################################################################
#
# c = JSON.parsefile("/Users/apple/Desktop/Master of Computing & Innovation Project/EyeTracking/examplejsondata.json")
# c["ts"]
# JSON.print(c)
#
