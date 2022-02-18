# This file was generated, do not modify it. # hide
#hideall
gaussian(x, a=1) = exp(-(a*x)^2)
ft_of_gaussian(ν,a=1) = √(π/a)*exp(-(π*ν)^2/a)

minx=-50
maxx=50
stepx=0.01
minν=-5
maxν=5
stepν=0.01
showx=(-5,5)
showν=(-5,5)
x = minx:stepx:maxx
ν = minν:stepν:maxν

theme = Theme(
         fontsize=24,
         resolution=(800,300),
         Axis=(
           xgridvisible=false,
           ygridvisible=false,
           yticksvisible=false,
           yticklabelsvisible=false,
         ),
         Lines=(
           linewidth=8,
         ),
         Scatter=(
           markerstrokewidth=0, markersize=12,
           color=Makie.wong_colors()[2],
           )
       )
set_theme!(theme)

lines(
  x, gaussian.(x),
  label=L"$f(x)$", axis=(xlabel=L"x",),
  color=Makie.wong_colors()[1],
)
xlims!(showx[1], showx[2])
axislegend()
resize_to_layout!(current_figure())
save(joinpath(@OUTPUT, "signal.svg"), current_figure())