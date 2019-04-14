using CSV
@testset "jparser" begin
    # Write your own tests here.
    path = "/Users/apple/Desktop/examplejsondata.json"
    output = parser(path)

    @test output == "Output.csv"

    df = CSV.read(output)
    @test df[3,:GazeDirectionLY] == 0.4455
    @test df[10,:AccelerometerX] == -1.138
    @test df[22,:GyroscopeX] == -10.71
    @test df[40,:PipelineVer] == 1502174499
    @test df[41,:SignalDir] == "out"

end
