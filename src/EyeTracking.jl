module EyeTracking
using JSON
using DataFrames
using CSV
using CImGui
using CImGui
using CImGui.CSyntax
using CImGui.CSyntax.CStatic
using CImGui.GLFWBackend
using CImGui.OpenGLBackend
using CImGui.GLFWBackend.GLFW
using CImGui.OpenGLBackend.ModernGL
# using Printf

# include("parser.jl")
include("newGui.jl")
include("jsonparser.jl")

export
# launch
parsefile

end # module
