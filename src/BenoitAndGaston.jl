module BenoitAndGaston

using Colors: colormap
using PNGFiles: save

function escape(x, c=x; depth=100)
    for i in 1:depth
        if abs2(x) > 4
            return i
        end
        x = x^2 + c
    end
    return depth+1
end

function mandel(xs, ys; depth=100, cmap=colormap("rdbu", depth+1))
    cmap[escape.(xs' .+ ys.*im; depth)]
end

function julia(xs, ys, c; depth=100, cmap=colormap("rdbu", depth+1))
    cmap[escape.(xs' .+ ys.*im, c; depth)]
end

function descend(c)
    step = 0.1
    while step > 0.000001
        isinside = escape(c) == 100+1
        c = c * (1 + (isinside ? 1 : -1) * step)
        if isinside != (escape(c) == 100+1)
            step /= 10
        end
    end
    return c
end

export descend, julia, mandel

end