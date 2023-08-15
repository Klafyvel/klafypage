# This file was generated, do not modify it. # hide
#hideall
lines(
  x, gaussian.(x),
  label=L"$f(x)$", axis=(xlabel=L"x",),
  color=Makie.wong_colors()[1],
)
xlims!(showν[1], showν[2])
x_ech = (minx*0.05):0.5:(maxx*0.05)
y = gaussian.(x_ech)
nans = repeat([NaN], length(x_ech))
z = repeat([0], length(y))
x_display = collect(Iterators.flatten(zip(x_ech,x_ech,nans)))
y_display = collect(Iterators.flatten(zip(z,y,nans)))
lines!(x_display, y_display, color=Makie.wong_colors()[2], linewidth=4)
scatter!(x_ech, y, label=L"h(x)", color=Makie.wong_colors()[2])
lines!([minx*0.05, maxx*0.05, NaN, maxx*0.05, minx*0.05], [1, 1, NaN, 1, 1] ./
2, color=:black, linewidth=4)
text!(L"2x_0", position=Point2(0, 1/2-0.2),
align=(:center,:bottom), fontsize=24)

axislegend()
save(joinpath(@OUTPUT, "signal_ech_fen.svg"), current_figure())