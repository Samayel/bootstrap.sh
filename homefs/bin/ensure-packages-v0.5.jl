#!/usr/bin/env julia

isinitialized = isdir(Pkg.dir())

isinitialized || Pkg.init()
cd(Pkg.dir())

homedir=ENV["HOME"]
islink("REQUIRE") || begin
    rm("REQUIRE")
    symlink("$homedir/repository/github.com/Samayel/bootstrap.sh/homefs/.julia/v0.5/REQUIRE", "REQUIRE")
    isinitialized = false
end

@static if is_unix()
    isinitialized || begin
        include(joinpath(dirname(JULIA_HOME), "share", "julia", "build_sysimg.jl"))
        build_sysimg(force=true)
    end
end

Pkg.update()

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

isdir(joinpath(Pkg.dir(), "ArbDecimals")) || begin
    Pkg.clone("https://github.com/JuliaArbTypes/ArbDecimals.jl.git")
    Pkg.build("ArbDecimals")
end

isdir(joinpath(Pkg.dir(), "OhMyREPL")) || begin
    Pkg.clone("https://github.com/KristofferC/OhMyREPL.jl.git")
    Pkg.build("OhMyREPL")
end

isdir(joinpath(Pkg.dir(), "StateMachineIterator")) || begin
    Pkg.clone("https://github.com/BenLauwens/StateMachineIterator.jl.git")
    Pkg.build("StateMachineIterator")
end
