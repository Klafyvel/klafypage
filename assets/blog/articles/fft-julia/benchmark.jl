# This file was generated, do not modify it. # hide
#hideall
function benchmark_all_methods(l)
	bench_naive = try
		 @benchmark naive_dft(a) setup=(a = rand($l))
	catch e
		nothing
	end
	bench_fft = try
		 @benchmark fft(a) setup=(a = rand($l))
	catch e
		nothing
	end
	bench_fft! = try
		@benchmark fft!(a) setup=(a = rand($l) .|> complex)
	catch e
		nothing
	end
	bench_my_fft = try
		@benchmark my_fft(a) setup=(a = rand($l))
	catch e
		nothing
	end
	bench_my_fft_2 = try
		@benchmark my_fft_2(a) setup=(a = rand($l) .|> complex)
	catch e
		nothing
	end
	bench_my_fft_3 = try
		@benchmark my_fft_3(x) setup=(x = rand($l))
	catch e
		nothing
	end
	bench_my_fft_4 = try
		@benchmark my_fft_4(x) setup=(x = rand($l))
	catch e
		nothing
	end
  bench_rfft = try
		@benchmark rfft(x) setup=(x = rand($l))
	catch e
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