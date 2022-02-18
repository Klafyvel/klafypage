# This file was generated, do not modify it. # hide
a = rand(1024)
b = fft(a)
c = my_fft_4(a)
real.(b[1:end÷2]) ≈ c[1:2:end] && imag.(b[1:end÷2]) ≈ c[2:2:end]