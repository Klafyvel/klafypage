# This file was generated, do not modify it. # hide
#hideall
let
	f = Figure()
	ax = Axis(
		f[1,1],
		xlabel=L"\theta\;(\text{rad})",
		ylabel="Norm"
	)
	hlines!(ax, 1, label=L"\sqrt{x^2+y^2}=1")
	for (i,a) in enumerate([0, 0.25, 0.5, 0.75, 1])
		if a∈[0, 1]
			linestyle=:solid
		else
			linestyle=:dot
		end
		lines!(ax, θ, g.(x, y, a), color=Cycled(1+i), label=L"g(x,y,a=%$(a))", linestyle=linestyle)
	end
	axislegend(ax)
  save(joinpath(@OUTPUT, "illustration6.svg"), f)
end