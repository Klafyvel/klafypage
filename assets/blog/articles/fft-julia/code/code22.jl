# This file was generated, do not modify it. # hide
@benchmark fft!(x) setup=(x = rand(1024) .|> complex)