# This file was generated, do not modify it. # hide
#hideall
lines(
	ν, abs.(tf_sig), 
  label=L"$\hat{f}(\nu)$", color=Makie.wong_colors()[1],
  axis=(xlabel=L"\nu", ylabel="Modulus"),
)
xlims!(showν[1], showν[2])
	
step_x_ech = stepx * 150
tf_ech = sampled_ft(ν, 1/step_x_ech)
lines!(ν, tf_ech, color=Makie.wong_colors()[2], label=L"\hat{g}(\nu)",
linestyle=:dot)
lines!([0, 1/step_x_ech, NaN, 1/step_x_ech, 0], [√(π), √(π), NaN, √(π), √(π)] .*
0.8, linewidth=4, color=:black)
text!(L"\nu_{\mathrm{ech}}", position=Point2(1/step_x_ech/2, √(π)*0.8-0.2),
align=(:center,:bottom), textsize=24)
axislegend()
save(joinpath(@OUTPUT, "tf_signal_ech_aliasing.svg"), current_figure())