
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


module PkgQ

const _DEFAULT_ACCURACY = 1
const _MAXIMUM_ACCURACY = 100

add(pkgname, accuracy = _DEFAULT_ACCURACY) = begin
    run(accuracy) do _
        Pkg.add(pkgname)
    end
end

clone(pkgurl, accuracy = _DEFAULT_ACCURACY) = begin
    run(accuracy) do firstrun
        if firstrun
            Pkg.clone(pkgurl)
        else
            Pkg.resolve()
        end
    end
end

checkout(pkgname, accuracy = _DEFAULT_ACCURACY) = begin
    run(accuracy) do _
        Pkg.checkout(pkgname)
    end
end

build(pkgname, accuracy = _DEFAULT_ACCURACY) = begin
    run(accuracy) do _
        Pkg.build(pkgname)
    end
end

resolve(accuracy = _DEFAULT_ACCURACY) = begin
    run(accuracy) do _
        Pkg.resolve()
    end
end

update(accuracy = _DEFAULT_ACCURACY) = begin
    run(accuracy) do firstrun
        if firstrun
            Pkg.update()
        else
            Pkg.resolve()
        end
    end
end

run(func, accuracy) = begin
    acc = accuracy

    failed = true
    while failed && acc <= _MAXIMUM_ACCURACY
        println("JULIA_PKGRESOLVE_ACCURACY = $acc")

        try
            withenv("JULIA_PKGRESOLVE_ACCURACY" => "$acc") do
                func(acc == accuracy)
            end
            failed = false
        catch err
            contains(err, "JULIA_PKGRESOLVE_ACCURACY") || rethrow()
        end

        acc *= 2
    end
end

contains(err::Pkg.PkgError, msg) = Base.contains(err.msg, msg)
contains(err::CapturedException, msg) = contains(err.ex, msg)
contains(err::CompositeException, msg) = any(x -> contains(x, msg), err.exceptions)

end
