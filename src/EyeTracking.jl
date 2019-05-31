module EyeTracking
using JSON
using DataFrames
using CSV
using Dates
using Query
using VideoIO
using ColorTypes, ImageCore
using CImGui
using CSyntax
using CSyntax.CFor
using CSyntax.CStatic
using CImGui.CSyntax
using CImGui.CSyntax.CStatic
using CImGui.GLFWBackend
using CImGui.OpenGLBackend
using CImGui.GLFWBackend.GLFW
using CImGui.OpenGLBackend.ModernGL
using CImGui: ImVec2, ImVec4, IM_COL32, ImS32, ImU32, ImS64, ImU64

include("jparser.jl")
include("newGui.jl")
include("newnewVideo.jl")
# include("filedialog.jl")

export
parser,
launch,
launch_video
end # module
