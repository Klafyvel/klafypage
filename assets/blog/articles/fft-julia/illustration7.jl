# This file was generated, do not modify it. # hide
#hideall
lines(
	ν, abs.(tf_sig), 
  label=L"$\hat{f}(\nu)$", color=Makie.wong_colors()[1],
  axis=(xlabel=L"\nu", ylabel="Modulus"),
)
xlims!(showν[1], showν[2])
deuxx₀ = (maxx*0.05) - (minx*0.05)
step_x_ech = stepx * 40

ν_ech = minν:(1/deuxx₀):maxν
ν_ech = ν_ech[0 .<= ν_ech .< 1/step_x_ech]
tf_ech = sampled_ft(ν_ech, 1/step_x_ech)

nans = repeat([NaN], length(tf_ech))
z = repeat([0], length(tf_ech))
x_display = collect(Iterators.flatten(zip(ν_ech,ν_ech,nans)))
y_display = collect(Iterators.flatten(zip(z,tf_ech,nans)))

lines!(x_display, y_display, color=Makie.wong_colors()[2], linewidth=4)
scatter!(ν_ech, tf_ech, label=L"\hat{l}(\nu)", color=Makie.wong_colors()[2])

axislegend()
save(joinpath(@OUTPUT, "signal_ech_fen_ech_fen.svg"), current_figure())