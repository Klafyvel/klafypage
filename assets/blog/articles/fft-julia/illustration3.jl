# This file was generated, do not modify it. # hide
#hideall
sampled_ft(ν,νech, a=1) = begin
	res = zeros(length(ν))
	mini_ν = minimum(ν)
	maxi_ν = maximum(ν)
	origins = [2*mini_ν:νech:-νech; 0:νech:2*maxi_ν]
	for ν₀ ∈ origins
		res .+= ft_of_gaussian.(ν .- ν₀, a)
	end
	res
end

tf_sig = ft_of_gaussian.(ν)

lines(
  ν, abs.(tf_sig),
  label=L"$\hat{f}(\nu)$", color=Makie.wong_colors()[1],
  axis=(xlabel=L"\nu", ylabel="Modulus"),
)
xlims!(showν[1], showν[2])
step_x_ech = stepx * 40
tf_ech = sampled_ft(ν, 1/step_x_ech)

lines!(ν, tf_ech, color=Makie.wong_colors()[2], label=L"\hat{g}(\nu)", linestyle=:dash)
lines!([0, 1/step_x_ech, NaN, 1/step_x_ech, 0], [√(π), √(π), NaN, √(π), √(π)] ./
2, color=:black, linewidth=4)
text!(L"\nu_{\mathrm{ech}}", position=Point2(1/step_x_ech/2, √(π)/2-0.2),
align=(:center, :bottom), fontsize=24)
axislegend()
save(joinpath(@OUTPUT, "tf_signal_ech.svg"), current_figure())