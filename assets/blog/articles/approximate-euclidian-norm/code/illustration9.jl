# This file was generated, do not modify it. # hide
#hideall
let
	f = Figure()
	ax = Axis(
		f[1,1],
		xlabel=L"a",
		ylabel=L"e(a)"
	)
	a = √2-1
	θa = 0:0.01:atan(a)
	A = 0:0.01:1
	lines!(ax, A, [sum((h(a).*cos.(θa).-1).^2 .* 0.01) for a in A])
  save(joinpath(@OUTPUT, "illustration9.svg"), f)
end