module EyeTracking
using JSON
using DataFrames
using CSV
using Dates
using VideoIO
using ColorTypes, ImageCore
using CImGui
using CImGui
using CImGui.CSyntax
using CImGui.CSyntax.CStatic
using CImGui.GLFWBackend
using CImGui.OpenGLBackend
using CImGui.GLFWBackend.GLFW
using CImGui.OpenGLBackend.ModernGL
using CImGui: ImVec2, ImVec4, IM_COL32, ImS32, ImU32, ImS64, ImU64

include("jparser.jl")
include("newGui.jl")
include("video.jl")
include("newVideo.jl")
# include("filedialog.jl")
# include("newNewGui.jl")

export
parser,
launch,
launch_video
end # module
