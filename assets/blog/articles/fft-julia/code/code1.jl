# This file was generated, do not modify it. # hide
function naive_dft(x)
  N = length(x)
  k = reshape(0:(N-1), 1, :)
  n = 0:(N-1)
  M = @. exp(-2im * π * k * n / N)
  M * x
end