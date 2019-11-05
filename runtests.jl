using Test

include("rail_fence_cipher.jl")

# Tests adapted from `problem-specifications//canonical-data.json` @ v1.1.0

println("\n"^2, "-"^60, "\n"^3)

@testset "encode with two rails" begin
    @test encode("XOXOXOXOXOXOXOXOXO", 2) == "XXXXXXXXXOOOOOOOOO"
end
println()

@testset "encode with three rails" begin
    @test encode("WEAREDISCOVEREDFLEEATONCE", 3) == "WECRLTEERDSOEEFEAOCAIVDEN"
end
println()

@testset "encode with ending in the middle" begin
    @test encode("EXERCISES", 4) == "ESXIEECSR"
end
println()

@testset "decode with three rails" begin
    @test decode("TEITELHDVLSNHDTISEIIEA", 3) == "THEDEVILISINTHEDETAILS"
end
println()

@testset "decode with five rails" begin
    @test decode("EIEXMSMESAORIWSCE", 5) == "EXERCISMISAWESOME"
end
println()

@testset "decode with six rails" begin
    encoded = "133714114238148966225439541018335470986172518171757571896261"
    decoded = "112358132134558914423337761098715972584418167651094617711286"
    @test decode(encoded, 6) == decoded
end
println()
