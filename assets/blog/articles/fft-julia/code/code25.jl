# This file was generated, do not modify it. # hide
function test_signal(s)
b = fft(s)
c = my_fft_4(s)
real.(b[1:end÷2]) ≈ c[1:2:end] && imag.(b[1:end÷2]) ≈ c[2:2:end]
end

t = range(-10, 10; length=1024)
y = @. exp(-t^2)
noise = rand(1024)
test_signal(y .+ noise)