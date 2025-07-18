### A Pluto.jl notebook ###
# v0.19.43

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 7d50011c-091f-4b66-98e9-5acd2c7c2cc0
begin
	import Pkg
	Pkg.offline(true)
	Pkg.add("Colors")
	Pkg.add("Images")
	Pkg.add("PlutoUI")
end

# ╔═╡ b0ca5f19-9835-4f16-9dc5-67c314323832
using Colors: colormap, RGB

# ╔═╡ b95c2b2c-8150-4f5d-a698-2205711d9117
using Images: Images

# ╔═╡ 3fb0ea20-aeb0-4caf-8dde-d65207c249c2
using PlutoUI: Slider

# ╔═╡ 4266fb4e-41f3-11ef-3c93-497e3409aff2
function escape(x, c=x; max_iter=100)
	for i in 1:max_iter
		x = x^2 + c
		if abs2(x) > 4
			return i
		end
	end
	return max_iter+1
end

# ╔═╡ 7142340f-b1af-4a24-aea1-4211da6806b7
xs = range(-2, 1, 600)

# ╔═╡ 5a8ffaf2-4b81-4af6-86a0-412806d90d35
ys = range(-1, 1, 400)

# ╔═╡ 94ad8c3e-93cc-409d-979c-ab1c7fe5e778
mandel(xs, ys; max_iter=100, cmap=colormap("rdbu", max_iter+1)) = cmap[escape.(xs' .+ ys.*im; max_iter)]

# ╔═╡ 9a21b20f-369f-4d7a-9aab-0ba082e257a5
img = mandel(xs, ys)

# ╔═╡ 281ff43e-69da-428d-b696-4d6e2b1a56d2
function annotate!(set, x, xs, y, ys; color=RGB(.2, 1, .2), size=3)
	j = searchsortedfirst(xs, x)
	i = searchsortedfirst(ys, y)
	center = set[i .+ (-1:1), j .+ (-1:1)]
	set[i .+ (-size:size), j .+ (-size:size)] .= color
	set[i .+ (-1:1), j .+ (-1:1)] .= center
	return set
end

# ╔═╡ b14be730-dfbd-467d-bb35-669ca6ae159d
annotate(set, args...) = annotate!(copy(set), args...)

# ╔═╡ dd169180-0448-4e5e-9ddb-ae116242da38
md"""
x = $(@bind x Slider(-2:.01:1, show_value=true, default=0))  \
y = $(@bind y Slider(-1:.01:1, show_value=true, default=0))
"""

# ╔═╡ 2e9f3676-243b-4ef1-b7c5-4b1f25035928
annotate(img, x, xs, y, ys)

# ╔═╡ f90e64a2-3125-43c3-b218-adcab0088969
zxs = x .+ range(-1, 1, 600)./10

# ╔═╡ e0fb7cb5-3e63-4bf3-a650-3d0de8b0ee44
zys = y .+ range(-1, 1, 600)./10

# ╔═╡ dafff1b5-07f9-49bb-8aa0-b413e1145717
annotate(mandel(zxs, zys), x, zxs, y, zys)

# ╔═╡ 4c8a468e-7925-407e-bff5-51a7d9f0baf3
julia(xs, ys, c; max_iter=100, cmap=colormap("rdbu", max_iter+1)) = cmap[escape.(xs' .+ ys.*im, c; max_iter)]

# ╔═╡ 10c11b8e-8a77-4bf8-8d57-87ae344c5ae1
julia(xs, ys, x + y*im)

# ╔═╡ fc40785b-9d39-4825-b610-f6ebc02eee0f
c = 15+12im

# ╔═╡ abfec845-9679-46f5-8bf7-5e588bbd2b7a
c ./ (2 + 3im)

# ╔═╡ 086f450f-5840-4d52-b4ac-81224e830014
reim(c)

# ╔═╡ Cell order:
# ╠═7d50011c-091f-4b66-98e9-5acd2c7c2cc0
# ╠═4266fb4e-41f3-11ef-3c93-497e3409aff2
# ╠═7142340f-b1af-4a24-aea1-4211da6806b7
# ╠═5a8ffaf2-4b81-4af6-86a0-412806d90d35
# ╠═b0ca5f19-9835-4f16-9dc5-67c314323832
# ╠═b95c2b2c-8150-4f5d-a698-2205711d9117
# ╠═94ad8c3e-93cc-409d-979c-ab1c7fe5e778
# ╠═9a21b20f-369f-4d7a-9aab-0ba082e257a5
# ╠═3fb0ea20-aeb0-4caf-8dde-d65207c249c2
# ╠═281ff43e-69da-428d-b696-4d6e2b1a56d2
# ╠═b14be730-dfbd-467d-bb35-669ca6ae159d
# ╠═2e9f3676-243b-4ef1-b7c5-4b1f25035928
# ╠═f90e64a2-3125-43c3-b218-adcab0088969
# ╠═e0fb7cb5-3e63-4bf3-a650-3d0de8b0ee44
# ╠═dd169180-0448-4e5e-9ddb-ae116242da38
# ╠═dafff1b5-07f9-49bb-8aa0-b413e1145717
# ╠═4c8a468e-7925-407e-bff5-51a7d9f0baf3
# ╠═10c11b8e-8a77-4bf8-8d57-87ae344c5ae1
# ╠═fc40785b-9d39-4825-b610-f6ebc02eee0f
# ╠═abfec845-9679-46f5-8bf7-5e588bbd2b7a
# ╠═086f450f-5840-4d52-b4ac-81224e830014
