
# ENV["JULIA_PKGRESOLVE_ACCURACY"] = "10"

@static if is_unix()
    ENV["R_HOME"] = "/usr/lib/R"
end

module PkgQ

const _DEFAULT_ACCURACY = 1
const _MAXIMUM_ACCURACY = 100

add(pkgname, accuracy = _DEFAULT_ACCURACY) = begin
    run(accuracy) do _
        Pkg.add(pkgname)
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
