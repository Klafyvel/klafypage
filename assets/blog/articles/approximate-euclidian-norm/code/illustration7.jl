# This file was generated, do not modify it. # hide
#hideall
let
	f = Figure()
	ax = Axis(f[1,1], 
		xlabel="x", ylabel="y",
		limits=(0,2,-0.5,0.5),
		aspect=DataAspect(),
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
	θn = -π/5:0.001:π/5
	xn,yn = cos.(θn), sin.(θn);
	hidespines!(ax)
	lines!(ax, xn, yn, label=L"\sqrt{x^2+y^2}=1")
	lines!(ax, [1/√2, √2, 1/√2], [1/√2, 0, -1/√2], label=L"\frac{1}{\sqrt{2}}(|x|+|y|)=1", linestyle=:dot)
	lines!(ax, [1, 1], [-1/√2, 1/√2], label=L"\max(|x|,|y|)=1", linestyle=:dot)
	lines!(ax, [-1, -1, -(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1], [-(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1, -1, -(√2 - 1)], label=L"f(x,y)=1")
	a = 1/√(4-2√2)
	lines!(ax, [-1, -1, -(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1].*a, [-(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1, -1, -(√2 - 1)].*a, label=L"\sqrt{4 - 2\sqrt{2}}f(x,y)=1")
	a = √2-1
	ablines!(ax, 0, a, color=RGBAf(0.0,0.0,0.0, 0.5))
	θa = 0:0.01:atan(a)
	lines!(ax, 0.3cos.(θa), 0.3sin.(θa), color=RGBAf(0.0,0.0,0.0, 0.5))
	text!(ax, 0.3, 0.05;text=L"\theta_r=\arctan({\sqrt{2}-1})")
	axislegend(ax, nbanks=2)
  save(joinpath(@OUTPUT, "illustration7.svg"), f)
end