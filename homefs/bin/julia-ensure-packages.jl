#!/usr/bin/env julia

isinitialized = isdir(Pkg.dir())
isinitialized || begin
    Pkg.init()
    rebuild_sysimg()
end

@static if is_unix()
    cd(Pkg.dir())
    homedir=ENV["HOME"]
    islink("REQUIRE") || begin
        rm("REQUIRE")
        symlink("$homedir/repository/github.com/Samayel/bootstrap.sh/homefs/.julia/v0.5/REQUIRE", "REQUIRE")
        isinitialized = false
    end
end

PkgQ.update()

withenv("PYTHON" => "") do
    PkgQ.build("PyCall")
end

isinitialized || begin
    PkgQ.checkout("Nemo")
    PkgQ.build("Nemo")

    PkgQ.checkout("Hecke")
    PkgQ.build("Hecke")

    PkgQ.checkout("Symata")
    PkgQ.build("Symata")
end

isdir(joinpath(Pkg.dir(), "PrimeSieve")) || begin
    PkgQ.clone("git@github.com:Samayel/PrimeSieve.jl.git")
    PkgQ.build("PrimeSieve")
end

isdir(joinpath(Pkg.dir(), "Brainstorm")) || begin
    PkgQ.clone("git@github.com:Samayel/Brainstorm.jl.git")
    PkgQ.build("Brainstorm")
end

isdir(joinpath(Pkg.dir(), "ProjectEuler")) || begin
    PkgQ.clone("git@github.com:Samayel/ProjectEuler.jl.git")
    PkgQ.build("ProjectEuler")
end

isdir(joinpath(Pkg.dir(), "AlgebraicNumbers")) || begin
    PkgQ.clone("https://github.com/anj1/AlgebraicNumbers.jl.git")
    PkgQ.build("AlgebraicNumbers")
end

isdir(joinpath(Pkg.dir(), "APL")) || begin
    PkgQ.clone("https://github.com/shashi/APL.jl.git")
    PkgQ.build("APL")
end

isdir(joinpath(Pkg.dir(), "ArbDecimals")) || begin
    PkgQ.clone("https://github.com/JuliaArbTypes/ArbDecimals.jl.git")
    PkgQ.build("ArbDecimals")
end

# isdir(joinpath(Pkg.dir(), "RemoteFiles")) || begin
#     PkgQ.clone("https://github.com/helgee/RemoteFiles.jl.git")
#     PkgQ.build("RemoteFiles")
# end
#
# isdir(joinpath(Pkg.dir(), "EarthOrientation")) || begin
#     PkgQ.clone("https://github.com/helgee/EarthOrientation.jl.git")
#     PkgQ.build("EarthOrientation")
# end
#
# isdir(joinpath(Pkg.dir(), "AstronomicalTime")) || begin
#     PkgQ.clone("https://github.com/JuliaAstrodynamics/AstronomicalTime.jl.git")
#     PkgQ.build("AstronomicalTime")
# end
#
# isdir(joinpath(Pkg.dir(), "AstroDynBase")) || begin
#     PkgQ.clone("https://github.com/JuliaAstrodynamics/AstroDynBase.jl.git")
#     PkgQ.build("AstroDynBase")
# end
#
# isdir(joinpath(Pkg.dir(), "AstroDynModels")) || begin
#     PkgQ.clone("https://github.com/JuliaAstrodynamics/AstroDynModels.jl.git")
#     PkgQ.build("AstroDynModels")
# end
#
# isdir(joinpath(Pkg.dir(), "AstroDynIO")) || begin
#     PkgQ.clone("https://github.com/JuliaAstrodynamics/AstroDynIO.jl.git")
#     PkgQ.build("AstroDynIO")
# end
#
# isdir(joinpath(Pkg.dir(), "AstroDynPlots")) || begin
#     PkgQ.clone("https://github.com/JuliaAstrodynamics/AstroDynPlots.jl.git")
#     PkgQ.build("AstroDynPlots")
# end
#
# isdir(joinpath(Pkg.dir(), "Astrodynamics")) || begin
#     PkgQ.clone("https://github.com/JuliaAstrodynamics/Astrodynamics.jl.git")
#     PkgQ.build("Astrodynamics")
# end

isdir(joinpath(Pkg.dir(), "Dagger")) || begin
    PkgQ.clone("https://github.com/JuliaParallel/Dagger.jl.git")
    PkgQ.build("Dagger")
end

isdir(joinpath(Pkg.dir(), "OhMyREPL")) || begin
    PkgQ.clone("https://github.com/KristofferC/OhMyREPL.jl.git")
    PkgQ.build("OhMyREPL")
end

isdir(joinpath(Pkg.dir(), "RiemannComplexNumbers")) || begin
    PkgQ.clone("https://github.com/scheinerman/RiemannComplexNumbers.jl.git")
    PkgQ.build("RiemannComplexNumbers")
end

isdir(joinpath(Pkg.dir(), "StatefulFunctions")) || begin
    PkgQ.clone("https://github.com/BenLauwens/StatefulFunctions.jl.git")
    PkgQ.build("StatefulFunctions")
end

# isdir(joinpath(Pkg.dir(), "unumjl")) || begin
#     PkgQ.clone("https://github.com/REX-computing/unumjl.git", "Unums")
#     PkgQ.build("unumjl")
# end

isdir(joinpath(Pkg.dir(), "XDiff")) || begin
    PkgQ.clone("https://github.com/dfdx/XDiff.jl.git")
    PkgQ.build("XDiff")
end
