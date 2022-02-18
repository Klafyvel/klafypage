# This file was generated, do not modify it. # hide
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