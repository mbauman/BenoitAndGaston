using BenoitAndGaston: descend, julia
using PNGFiles: save

function (@main)(args::Vector{String})::Cint
    save(get(args, 2, "a.png"), julia(range(-1, 1, 800), range(-1, 1, 600), descend(rand(Complex{Float64}))))
    return 0
end
