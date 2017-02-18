#!/usr/bin/env julia

isinitialized = isdir(Pkg.dir())

isinitialized || Pkg.init()
cd(Pkg.dir())

@static if is_unix()
    homedir=ENV["HOME"]
    islink("REQUIRE") || begin
        rm("REQUIRE")
        symlink("$homedir/repository/github.com/Samayel/bootstrap.sh/homefs/.julia/v0.5/REQUIRE", "REQUIRE")
        isinitialized = false
    end

    isinitialized || begin
        include(joinpath(dirname(JULIA_HOME), "share", "julia", "build_sysimg.jl"))
        build_sysimg(force=true)
    end
end

PkgQ.update()

withenv("PYTHON" => "") do
    Pkg.build("PyCall")
end

isinitialized || begin
    Pkg.checkout("Nemo")
    Pkg.build("Nemo")

    Pkg.checkout("Hecke")
    Pkg.build("Hecke")

    Pkg.checkout("Symata")
    Pkg.build("Symata")
end

isdir(joinpath(Pkg.dir(), "PrimeSieve")) || begin
    Pkg.clone("git@github.com:Samayel/PrimeSieve.jl.git")
    Pkg.build("PrimeSieve")
end

isdir(joinpath(Pkg.dir(), "Brainstorm")) || begin
    Pkg.clone("git@github.com:Samayel/Brainstorm.jl.git")
    Pkg.build("Brainstorm")
end

isdir(joinpath(Pkg.dir(), "ProjectEuler")) || begin
    Pkg.clone("git@github.com:Samayel/ProjectEuler.jl.git")
    Pkg.build("ProjectEuler")
end

isdir(joinpath(Pkg.dir(), "AlgebraicNumbers")) || begin
    Pkg.clone("https://github.com/anj1/AlgebraicNumbers.jl.git")
    Pkg.build("AlgebraicNumbers")
end

isdir(joinpath(Pkg.dir(), "ArbDecimals")) || begin
    Pkg.clone("https://github.com/JuliaArbTypes/ArbDecimals.jl.git")
    Pkg.build("ArbDecimals")
end

isdir(joinpath(Pkg.dir(), "Astrodynamics")) || begin
    Pkg.clone("https://github.com/JuliaAstrodynamics/Astrodynamics.jl.git")
    Pkg.build("Astrodynamics")
end

isdir(joinpath(Pkg.dir(), "OhMyREPL")) || begin
    Pkg.clone("https://github.com/KristofferC/OhMyREPL.jl.git")
    Pkg.build("OhMyREPL")
end

isdir(joinpath(Pkg.dir(), "RiemannComplexNumbers")) || begin
    Pkg.clone("https://github.com/scheinerman/RiemannComplexNumbers.jl.git")
    Pkg.build("RiemannComplexNumbers")
end

isdir(joinpath(Pkg.dir(), "StatefulFunctions")) || begin
    Pkg.clone("https://github.com/BenLauwens/StatefulFunctions.jl.git")
    Pkg.build("StatefulFunctions")
end

# isdir(joinpath(Pkg.dir(), "unumjl")) || begin
#     Pkg.clone("https://github.com/REX-computing/unumjl.git", "Unums")
#     Pkg.build("unumjl")
# end

isdir(joinpath(Pkg.dir(), "XDiff")) || begin
    Pkg.clone("https://github.com/dfdx/XDiff.jl.git")
    Pkg.build("XDiff")
end
