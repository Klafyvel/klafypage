# This file was generated, do not modify it. # hide
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