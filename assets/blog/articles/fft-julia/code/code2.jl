# This file was generated, do not modify it. # hide
a = rand(1024)
b = fft(a)
c = naive_dft(a)
b ≈ c