using Pkg
Pkg.activate(temp=true)
Pkg.add(["FFTW", "CairoMakie", "BenchmarkTools"])
using FFTW, CairoMakie, BenchmarkTools
figures_path = joinpath("_assets", "blog", "articles", "fft-julia")

## Signal

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
set_theme!(theme_latexfonts())
update_theme!(
         fontsize=24,
         resolution=(800,300),
         # Axis=(
         #   xgridvisible=false,
         #   ygridvisible=false,
         #   yticksvisible=false,
         #   yticklabelsvisible=false,
         # ),
         Lines=(
           linewidth=3,
         ),
         Scatter=(
           markerstrokewidth=0, markersize=12,
           color=Makie.wong_colors()[2],
           )
       )

lines(
  x, gaussian.(x),
  label=L"$f(x)$", axis=(xlabel=L"x",),
  color=Makie.wong_colors()[1],
)
xlims!(showx[1], showx[2])
axislegend()
resize_to_layout!(current_figure())
save(joinpath(figures_path, "signal.svg"), current_figure())

## Sampled signal
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
save(joinpath(figures_path, "signal_ech.svg"), current_figure())

## Fourier transform of sampled signal
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
2, color=:black, linewidth=2)
text!(L"\nu_{\mathrm{ech}}", position=Point2(1/step_x_ech/2, √(π)/2-0.2),
align=(:center, :bottom), fontsize=24)
axislegend()
save(joinpath(figures_path, "tf_signal_ech.svg"), current_figure())

## Aliasing
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
0.8, linewidth=2, color=:black)
text!(L"\nu_{\mathrm{ech}}", position=Point2(1/step_x_ech/2, √(π)*0.8-0.2),
align=(:center,:bottom), fontsize=24)
axislegend()
save(joinpath(figures_path, "tf_signal_ech_aliasing.svg"), current_figure())

## Windowed sampled signal
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
2, color=:black, linewidth=2)
text!(L"2x_0", position=Point2(0, 1/2-0.2),
align=(:center,:bottom), fontsize=24)

axislegend()
save(joinpath(figures_path, "signal_ech_fen.svg"), current_figure())

## Windowed sampled signal then sampled in frequency space
lines(
	ν, abs.(tf_sig), 
  label=L"$\hat{f}(\nu)$", color=Makie.wong_colors()[1],
  axis=(xlabel=L"\nu", ylabel="Modulus"),
)
xlims!(showν[1], showν[2])
deuxx₀ = (maxx*0.05) - (minx*0.05)
step_x_ech = stepx * 40

ν_ech = minν:(1/deuxx₀):maxν#[(-1/2step_x_ech):(1/deuxx₀):(-1/deuxx₀); 0:(1/deuxx₀):(1/2step_x_ech)]
tf_ech = sampled_ft(ν_ech, 1/step_x_ech)

nans = repeat([NaN], length(tf_ech))
z = repeat([0], length(tf_ech))
x_display = collect(Iterators.flatten(zip(ν_ech,ν_ech,nans)))
y_display = collect(Iterators.flatten(zip(z,tf_ech,nans)))
lines!(x_display, y_display, color=Makie.wong_colors()[2], linewidth=4)
scatter!(ν_ech, tf_ech, label=L"\hat{l}(\nu)", color=Makie.wong_colors()[2])

axislegend()
save(joinpath(figures_path, "signal_ech_fen_ech.svg"), current_figure())
#
## Windowed sampled signal then sampled and windowed in frequency space
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
save(joinpath(figures_path, "signal_ech_fen_ech_fen.svg"), current_figure())

## naive dft
function naive_dft(x)
  N = length(x)
  k = reshape(0:(N-1), 1, :)
  n = 0:(N-1)
  M = @. exp(-2im * π * k * n / N)
  M * x
end

a = rand(1024)
b = fft(a)
c = naive_dft(a)
b ≈ c

@benchmark fft(a) setup=(a = rand(1024))
@benchmark naive_dft(a) setup=(a = rand(1024))

function my_fft(x)
  # Stop condition, the TF of an array of size 1 is this same array.
  if length(x) <= 1
    x
  else
    N = length(x)
    # Xᵒ contains the TF of odd terms and Xᵉ that of even terms.
    # The subtlety being that Julia's tablals start at 1 and not 0.
    Xᵒ = my_fft(x[2:2:end])
    Xᵉ = my_fft(x[1:2:end])
    factors = @. exp(-2im * π * (0:(N/2 - 1)) / N)
    [Xᵉ .+ factors .* Xᵒ; Xᵉ .- factors .* Xᵒ]
  end
end
@benchmark fft(a) setup=(a = rand(1024))
@benchmark my_fft(a) setup=(a = rand(1024))
bit_reverse(::Val{10}, num) = begin
  num = ((num&0x3e0)>>5)|((num&0x01f)<<5)
  num = ((num&0x318)>>3)|(num&0x084)|((num&0x063)<<3)
  ((num&0x252)>>1)|(num&0x084)|((num&0x129)<<1)
end
bit_reverse(::Val{64}, num) = bit_reverse(Val(32), (num&0xffffffff00000000)>>32)|(bit_reverse(Val(32), num&0x00000000ffffff)<<32)
bit_reverse(::Val{32}, num) = bit_reverse(Val(16), (num&0xffff0000)>>16)|(bit_reverse(Val(16), num&0x0000ffff)<<16)
bit_reverse(::Val{16}, num) = bit_reverse(Val(8), (num&0xff00)>>8)|(bit_reverse(Val(8), num&0x00ff)<<8)
bit_reverse(::Val{8}, num) = bit_reverse(Val(4), (num&0xf0)>>4)|(bit_reverse(Val(4), num&0x0f)<<4)
bit_reverse(::Val{4}, num) =bit_reverse(Val(2), (num&0xc)>>2)|(bit_reverse(Val(2), num&0x3)<<2)
bit_reverse(::Val{3}, num) = ((num&0x1)<<2)|((num&0x4)>>2)|(num&0x2)
bit_reverse(::Val{2}, num) = ((num&0x2)>>1 )|((num&0x1)<<1)
bit_reverse(::Val{1}, num) = num
function reverse_bit_order!(X, order)
  N = length(X)
  for i in 0:(N-1)
    j = bit_reverse(order, i)
    if i<j
      X[i+1],X[j+1]=X[j+1],X[i+1]
    end
  end
  X
end
function my_fft_2(x)
  N = length(x)
  order = Int(log2(N))
  @inbounds reverse_bit_order!(x, Val(order))
  n₁ = 0
  n₂ = 1
  for i=1:order # i done the number of the column we are in.
    n₁ = n₂ # n₁ = 2ⁱ-¹
    n₂ *= 2 # n₂ = 2ⁱ
    
    step_angle = -2π/n₂
    angle = 0
    for j=1:n₁ # j is the index in Xᵉ and Xᵒ
      factors = exp(im*angle) # z = exp(-2im*π*(j-1)/n₂)
      angle += step_angle # a = -2π*(j+1)/n₂
      
      # We combine the element j of each group of subarrays
      for k=j:n₂:N
        @inbounds x[k], x[k+n₁] = x[k] + factors * x[k+n₁], x[k] - factors * x[k+n₁]
      end
    end
  end
  x  
end
@benchmark fft!(a) setup=(a = rand(1024) |> complex)
@benchmark my_fft_2(a) setup=(a = rand(1024) .|> complex)

bit_reverse(::Val{9}, num) = begin
  num = ((num&0x1e0)>>5)|(num&0x010)|((num&0x00f)<<5)
  num = ((num&0x18c)>>2)|(num&0x010)|((num&0x063)<<2)
  ((num&0x14a)>>1)|(num&0x010)|((num&0x0a5)<<1)
end
bit_reverse(::Val{31}, num) = begin
bit_reverse(Val(15), num&0x7fff0000>>16)| (num&0x00008000) |(bit_reverse(Val(7),num&0x00007fff)<<16)
end
bit_reverse(::Val{15}, num) = bit_reverse(Val(7), (num&0x7f00)>>8)| (num&0x0080)|(bit_reverse(Val(7),num&0x007f)<<8)
bit_reverse(::Val{7}, num) = bit_reverse(Val(3), (num&0x70)>>4 )| (num&0x08) |(bit_reverse(Val(3), num&0x07)<<4)

function reverse_bit_order_double!(x, order)
  N = length(x)
  for i in 0:(N÷2-1)
    j = bit_reverse(order, i)
    if i<j
      # swap real part
      x[2*i+1],x[2*j+1]=x[2*j+1],x[2*i+1]
      # swap imaginary part
      x[2*i+2],x[2*j+2]=x[2*j+2],x[2*i+2]
    end
  end
  x
end

function my_fft_3(x)
  N = length(x) ÷ 2
  order = Int(log2(N))
  @inbounds reverse_bit_order_double!(x, Val(order))
  
  n₁ = 0
  n₂ = 1
  for i=1:order # i done the number of the column we are in.
    n₁ = n₂ # n₁ = 2ⁱ-¹
    n₂ *= 2 # n₂ = 2ⁱ
    
    step_angle = -2π/n₂
    angle = 0
    for j=1:n₁ # j is the index in Xᵉ and Xᵒ
      re_factor = cos(angle)
      im_factor = sin(angle)
      angle += step_angle # a = -2π*j/n₂
      
      # We combine element j from each group of subarrays
      @inbounds for k=j:n₂:N
        re_xₑ = x[2*k-1]
        im_xₑ = x[2*k]
        re_xₒ = x[2*(k+n₁)-1]
        im_xₒ = x[2*(k+n₁)]
        x[2*k-1] = re_xₑ + re_factor*re_xₒ - im_factor*im_xₒ
        x[2*k] = im_xₑ + im_factor*re_xₒ + re_factor*im_xₒ
        x[2*(k+n₁)-1] = re_xₑ - re_factor*re_xₒ + im_factor*im_xₒ
        x[2*(k+n₁)] = im_xₑ - im_factor*re_xₒ - re_factor*im_xₒ      
      end
    end
  end
  # We build the final version of the TF
  # N half the size of x
  # Special case n=0
  x[1] = x[1] + x[2]
  x[2] = 0  
  
  step_angle = -π/N
  angle = step_angle
  @inbounds for n=1:(N÷2)
    re_factor = cos(angle)
    im_factor = sin(angle)
    re_h = x[2*n+1]
    im_h = x[2*n+2]
    re_h_sym = x[2*(N-n)+1]
    im_h_sym = x[2*(N-n)+2]
    x[2*n+1] = 1/2*(re_h + re_h_sym + im_h*re_factor + re_h*im_factor + im_h_sym*re_factor - re_h_sym*im_factor)
    x[2*n+2] = 1/2*(im_h - im_h_sym - re_h*re_factor + im_h*im_factor + re_h_sym*re_factor + im_h_sym*im_factor)
    x[2*(N-n)+1] = 1/2*(re_h_sym + re_h - im_h_sym*re_factor + re_h_sym*im_factor - im_h*re_factor - re_h*im_factor)
    x[2*(N-n)+2] = 1/2*(im_h_sym - im_h + re_h_sym*re_factor + im_h_sym*im_factor - re_h*re_factor + im_h*im_factor)
    angle += step_angle
  end
  x
end

@benchmark fft!(x) setup=(x = rand(1024) .|> complex)

@benchmark my_fft_3(x) setup=(x = rand(1024))

function my_fft_4(x)
  N = length(x) ÷ 2
  order = Int(log2(N))
  @inbounds reverse_bit_order_double!(x, Val(order))
  
  n₁ = 0
  n₂ = 1
  
    i=1
  while i<=order # i done the number of the column we are in.
    n₁ = n₂ # n₁ = 2ⁱ-¹
    n₂ *= 2 # n₂ = 2ⁱ
    
    step_angle = -2π/n₂
    α = 2sin(step_angle/2)^2
    β = sin(step_angle)
    cj = 1
    sj = 0
    j = 1
    while j<=n₁ # j is the index in Xᵉ and Xᵒ
      # We combine the element j from each group of subarrays
      k = j
      @inbounds while k<=N
        re_xₑ = x[2*k-1]
        im_xₑ = x[2*k]
        re_xₒ = x[2*(k+n₁)-1]
        im_xₒ = x[2*(k+n₁)]
        x[2*k-1] = re_xₑ + cj*re_xₒ - sj*im_xₒ
        x[2*k] = im_xₑ + sj*re_xₒ + cj*im_xₒ
        x[2*(k+n₁)-1] = re_xₑ - cj*re_xₒ + sj*im_xₒ
        x[2*(k+n₁)] = im_xₑ - sj*re_xₒ - cj*im_xₒ       
        
        k += n₂
      end
      # We compute the next cosine and sine.
      cj, sj = cj - (α*cj + β*sj), sj - (α*sj-β*cj)
      j+=1
    end
    i += 1
  end
  # We build the final version of the TF
  # N half the size of x
  # Special case n=0
  x[1] = x[1] + x[2]
  x[2] = 0  
  
  step_angle = -π/N
  α = 2sin(step_angle/2)^2
  β = sin(step_angle)
  cj = 1
  sj = 0
  j = 1
  @inbounds while j<=(N÷2)
    # We calculate the cosine and sine before the main calculation here to compensate for the first
    # step of the loop that was skipped.
    cj, sj = cj - (α*cj + β*sj), sj - (α*sj-β*cj)
    
    re_h = x[2*j+1]
    im_h = x[2*j+2]
    re_h_sym = x[2*(N-j)+1]
    im_h_sym = x[2*(N-j)+2]
    x[2*j+1] = 1/2*(re_h + re_h_sym + im_h*cj + re_h*sj + im_h_sym*cj - re_h_sym*sj)
    x[2*j+2] = 1/2*(im_h - im_h_sym - re_h*cj + im_h*sj + re_h_sym*cj + im_h_sym*sj)
    x[2*(N-j)+1] = 1/2*(re_h_sym + re_h - im_h_sym*cj + re_h_sym*sj - im_h*cj - re_h*sj)
    x[2*(N-j)+2] = 1/2*(im_h_sym - im_h + re_h_sym*cj + im_h_sym*sj - re_h*cj + im_h*sj)
    
    j += 1
  end
  x
end

a = rand(1024)
b = fft(a)
c = my_fft_4(a)
real.(b[1:end÷2]) ≈ c[1:2:end] && imag.(b[1:end÷2]) ≈ c[2:2:end]

@benchmark fft!(x) setup=(x = rand(1024) .|> complex)
@benchmark my_fft_4(x) setup=(x = rand(1024))

## all benchmarks
function benchmark_all_methods(l)
	bench_naive = try
		 @benchmark naive_dft(a) setup=(a = rand($l))
	catch e
    @warn "Failed for naive" l
		nothing
	end
	bench_fft = try
		 @benchmark fft(a) setup=(a = rand($l))
	catch e
    @warn "Failed for fft" l
		nothing
	end
	bench_fft! = try
		@benchmark fft!(a) setup=(a = rand($l) .|> complex)
	catch e
    @warn "Failed for fft!" l
		nothing
	end
	bench_my_fft = try
		@benchmark my_fft(a) setup=(a = rand($l))
	catch e
    @warn "Failed for my_fft" l
		nothing
	end
	bench_my_fft_2 = try
		@benchmark my_fft_2(a) setup=(a = rand($l) .|> complex)
	catch e
    @warn "Failed for my_fft_2" l
		nothing
	end
	bench_my_fft_3 = try
		@benchmark my_fft_3(x) setup=(x = rand($l))
	catch e
    @warn "Failed for my_fft_3" l
		nothing
	end
	bench_my_fft_4 = try
		@benchmark my_fft_4(x) setup=(x = rand($l))
	catch e
    @warn "Failed for my_fft_4" l
		nothing
	end
  bench_rfft = try
		@benchmark rfft(x) setup=(x = rand($l))
	catch e
    @warn "Failed for rfft" l
		nothing
	end
	
	bench_naive, bench_fft, bench_fft!, bench_rfft, bench_my_fft, bench_my_fft_2,
  bench_my_fft_3, bench_my_fft_4
end

benchmark_lengths = 2 .^ [2, 4, 8, 9, 10, 16]
benchmarks = benchmark_all_methods.(benchmark_lengths)
Base.minimum(::Nothing) = nothing
import Statistics
Statistics.median(::Nothing) = nothing
median_times = vcat(map(x->reshape([if isnothing(a) missing else a.time end for
a in x], 1, :), map(x->median.(x), benchmarks))...);
median_memory = vcat(map(x->reshape([if isnothing(a) missing else a.memory end
for a in x], 1, :), map(x->median.(x), benchmarks))...);
median_allocs = vcat(map(x->reshape([if isnothing(a) missing else a.allocs end
for a in x], 1, :), map(x->median.(x), benchmarks))...);

## plot all benckmarks
update_theme!(
         fontsize=18,
       )
fig = Figure(resolution=(900,800))
Symlog2(hi) = Symlog2(-hi, hi)
function Symlog2(lo, hi)
    forward(x) = if x > 0
        x <= hi ? x / hi * log2(hi) : log2(x)
    elseif x < 0
        x >= lo ? x / abs(lo) * log2(abs(lo)) : -log2(abs(x))
    else
        x
    end
    inverse(x) = if x > 0
        l = log2(hi)
        x <= l ? x / l * hi : exp2(x)
    elseif x < 0
        l = -log2(abs(lo))
        x >= l ? x / l * abs(lo) : -exp2(abs(x))
    else
        x
    end
    return Makie.ReversibleScale(forward, inverse; limits=(0.0f0, 3.0f0), name=:Symlog2)
end
ax_time = Axis(
  fig[1,1],
  xlabel="Input array size",
  ylabel="Execution time (ns)",
  xscale=log2,
  yscale=log10,
)
ticks = [0; [2^i for i in range(start=4, stop=32, step=4)]...]
ticklabels = ["0"; [rich("2", superscript(string(round(Int, i)))) for i in range(start=4, stop=32, step=4)]...]
ax_memory = Axis(
  fig[2,1],
  xlabel="Input array size",
  ylabel="Memory estimate (bytes)",
  xscale=log2,
  yscale=Symlog2(1.0),
  yticks= (ticks, ticklabels),
)
ax_alloc = Axis(
  fig[3,1],
  xlabel="Input array size",
  ylabel="Allocs estimate",
  xscale=log2,
  yscale=Symlog2(1.0),
  yticks= (ticks, ticklabels),
)

linkxaxes!(ax_time, ax_alloc)
linkxaxes!(ax_time, ax_memory)

colors=[Makie.wong_colors(); :black]
markers=[:circle, :utriangle, :dtriangle, :ltriangle, :star4, :rect, :diamond, :star5]
labels = ["Naive DFT", "FFTW.fft", "FFTW.fft!", "FFTW.rfft", "my_fft", "my_fft_2", "my_fft_3", "my_fft_4"]

for i in 1:length(labels)
  scatterlines!(ax_time, benchmark_lengths, max.(median_times[:,i], 1e-20),
  marker=markers[i], color=colors[i])
  scatterlines!(ax_memory, benchmark_lengths, median_memory[:,i],
  marker=markers[i], color=colors[i])
  scatterlines!(ax_alloc, benchmark_lengths, median_allocs[:,i],
  marker=markers[i], color=colors[i], label=labels[i])
end


Legend(fig[:,2], ax_alloc, tellwidth=true, tellheight=false)

save(joinpath(figures_path, "benchmark.svg"), current_figure())

## Final bits
real.(b[1:end÷2]) ≈ c[1:2:end] && imag.(b[1:end÷2]) ≈ c[2:2:end]


function test_signal(s)
b = fft(s)
c = my_fft_4(s)
real.(b[1:end÷2]) ≈ c[1:2:end] && imag.(b[1:end÷2]) ≈ c[2:2:end]
end

t = range(-10, 10; length=1024)
y = @. exp(-t^2)
noise = rand(1024)
test_signal(y .+ noise)


t = range(-10, 10; length=1024)
y = @. sin(t)
noise = rand(1024)
test_signal(y .+ noise)
