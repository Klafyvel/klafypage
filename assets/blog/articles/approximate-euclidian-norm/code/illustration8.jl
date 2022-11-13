# This file was generated, do not modify it. # hide
#hideall
let
	f = Figure()
	ax = Axis(
		f[1,1],
		xlabel=L"\theta\;(\text{rad})",
		ylabel=L"(h(a)\cos\theta-1)^2"
	)
	a = √2-1
	θa = 0:0.01:atan(a)
	for (i,a) in enumerate([0, 0.25, 0.5, 0.75, 1])
		lines!(ax, θa, (h(a).*cos.(θa).-1).^2, label=L"a=%$(a)", color=Cycled(i))
	end
	axislegend(ax)
  save(joinpath(@OUTPUT, "illustration8.svg"), f)
end