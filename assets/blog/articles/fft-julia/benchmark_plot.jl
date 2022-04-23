# This file was generated, do not modify it. # hide
#hideall
fig = Figure(resolution=(900,800))

theme_benchmark = Theme(
  Axis=(
    xgridvisible=true,
    ygridvisible=true,
    yminorticksvisible=true,
    xminorticksvisible=true,
    yminorgridvisible=true,
    xminorgridvisible=true,
    yticksvisible=true,
    yticklabelsvisible=true,
    ylabelsize=20,
    xlabelsize=20,
    xminorticks = IntervalsBetween(5),
    yminorticks = IntervalsBetween(10),
    xticklabelssize=18,
    yticklabelsssize=18,
  ),
  ScatterLines=(
    markersize=24,
  )
)

set_theme!(theme_benchmark)
ax_time = Axis(
  fig[1,1],
  xlabel="Input array size",
  ylabel="Execution time (ns)",
)
ax_memory = Axis(
  fig[2,1],
  xlabel="Input array size",
  ylabel="Memory estimate (bytes)",
  limits=(nothing, nothing, 1/2, nothing),
)
ax_alloc = Axis(
  fig[3,1],
  xlabel="Input array size",
  ylabel="Allocs estimate",
  limits=(nothing, nothing, 1/2, nothing),
)
linkxaxes!(ax_time, ax_alloc)
linkxaxes!(ax_time, ax_memory)

colors=[Makie.wong_colors(); :black]
markers=[:circle, :utriangle, :dtriangle, :ltriangle, :star4, :rect, :diamond, :star5]
labels = ["Naive DFT", "FFTW.fft", "FFTW.fft!", "FFTW.rfft", "my_fft", "my_fft_2", "my_fft_3", "my_fft_4"]

for i in 1:length(labels)
  scatterlines!(ax_time, benchmark_lengths, median_times[:,i],
  marker=markers[i], color=colors[i])
  scatterlines!(ax_memory, benchmark_lengths, max.(median_memory[:,i], 1/2),
  marker=markers[i], color=colors[i])
  scatterlines!(ax_alloc, benchmark_lengths, max.(median_allocs[:,i], 1/2),
  marker=markers[i], color=colors[i], label=labels[i])
end


ax_time.xscale[] = log2
ax_memory.xscale[] = log2
ax_alloc.xscale[] = log2
ax_time.yscale[] = log10
ax_memory.yscale[] = log2
ax_alloc.yscale[] = log2


Legend(fig[:,2], ax_alloc, tellwidth=true, tellheight=false)

save(joinpath(@OUTPUT, "benchmark.svg"), current_figure())