# This file was generated, do not modify it. # hide
#hideall
let
	f = Figure()
	ax = Axis(f[1,1], 
		xlabel="x", ylabel="y",
		limits=(-2,2,-2,2),
		aspect=1,
		xgridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		ygridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		xticks=([0], ["0"]),
		yticks=([0], ["0"]),
		xlabelvisible=false,
		ylabelvisible=false,
		xticksvisible=false,
		yticksvisible=false,
		xticklabelsvisible=false,
		yticklabelsvisible=false,
	)
	hidespines!(ax)
	lines!(ax, x, y, label=L"\sqrt{x^2+y^2}=1")
	lines!(ax, [-√2, 0, √2, 0, -√2], [0, √2, 0, -√2, 0], label=L"\frac{1}{\sqrt{2}}(|x|+|y|)=1")
	lines!(ax, [-1, -1, 1, 1, -1], [-1, 1, 1, -1, -1], label=L"\max(|x|,|y|)=1")
	axislegend(ax)
  save(joinpath(@OUTPUT, "illustration3.svg"), f)
end