# This file was generated, do not modify it. # hide
#hideall
lines(
  x, gaussian.(x),
  label=L"$f(x)$", axis=(xlabel=L"x",),
  color=Makie.wong_colors()[1],
)
x_ech = minx:0.5:maxx
y = gaussian.(x_ech)
nans = repeat([NaN], length(x_ech))
z = repeat([0], length(y))
x_display = collect(Iterators.flatten(zip(x_ech,x_ech,nans)))
y_display = collect(Iterators.flatten(zip(z,y,nans)))
lines!(x_display, y_display, color=Makie.wong_colors()[2], linewidth=4)
scatter!(x_ech, y, label=L"g(x)", color=Makie.wong_colors()[2])

xlims!(showx[1], showx[2])
axislegend()
save(joinpath(@OUTPUT, "signal_ech.svg"), current_figure())