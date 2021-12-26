
@static if is_unix()
    ENV["R_HOME"] = "/usr/lib/R"
end


rebuild_sysimg() = begin
    @static if is_windows()
        Pkg.add("WinRPM")
        eval(Expr(:using,:WinRPM))
        WinRPM.install("gcc")
        WinRPM.install("winpthreads-devel", yes=true)
    end

    include(joinpath(JULIA_HOME, Base.DATAROOTDIR, "julia", "build_sysimg.jl"))
    build_sysimg(force=true)
end


module VirtualEnvQ

# https://stackoverflow.com/a/44918155
set_julia_dir(dir) = begin
    ENV["JULIA_PKGDIR"] = dir
    Pkg.init()
    Pkg.__init__()
    pop!(Base.LOAD_CACHE_PATH)
    nothing
end

reset_virtualenv() = begin
    haskey(ENV, "JULIA_PKGDIR") || return
    envdir = ENV["JULIA_PKGDIR"]

    rm(envdir, recursive=true)
    set_julia_dir(envdir)

    Pkg.add("IJulia")
    Pkg.build("IJulia")

    nothing
end

end

haskey(ENV, "JULIA_PKGDIR") && VirtualEnvQ.set_julia_dir(ENV["JULIA_PKGDIR"])


