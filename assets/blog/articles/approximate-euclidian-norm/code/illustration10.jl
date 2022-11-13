# This file was generated, do not modify it. # hide
#hideall
let
	f = Figure()
	ax = Axis(
		f[1,1],
		xlabel=L"\theta\;(\text{rad})",
		ylabel="Norm"
	)
	hlines!(ax, 1+max_dev, color=:black, label="Higher bound")
	hlines!(ax, 1-max_dev, color=:black, label="Lower bound")
	hlines!(ax, 1, label=L"\sqrt{x^2+y^2}=1")
	lines!(ax, θ, g.(x, y, a), color=Cycled(2), label=L"g(x,y,a\approx%$(round(a, sigdigits=3)))")
	axislegend(ax)
  save(joinpath(@OUTPUT, "illustration10.svg"), f)
end