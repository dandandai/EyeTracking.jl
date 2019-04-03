@testset "Parser" begin
    # Write your own tests here.
    path = "path/to/test.json"
    df = parse_file(path)
    @test df.name == "Hello"
    @test df.id = "10"

end
