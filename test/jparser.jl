using CSV
@testset "jparser" begin
    # Write your own tests here.
    path = "/Users/apple/Desktop/examplejsondata.json"
    output = parser(path)

    @test output == "Output.csv"

    df = CSV.read(output)

    #Test whether the data at the same timestamp has been merged into one row
    @test df[2,:Timestamp] == 191520960
    #Test whether the array data has been converted to separate columns
    @test df[10,:AccelerometerX] == -1.138
    @test df[22,:GyroscopeX] == -4.486
    #Test whether the GazeDirection data is distinguished from the left and right eyes
    @test df[3,:GazeDirectionLY] == 0.4455
    @test df[39,:GazeDirectionRZ] == 0.8849
    #Test whether the PipelineVer as a int type can be displayed in csv
    @test df[40,:PipelineVer] == 1502174499
    #Test whether the SignalDir as a string type can be displayed in csv
    @test df[41,:SignalDir] == "out"

end
