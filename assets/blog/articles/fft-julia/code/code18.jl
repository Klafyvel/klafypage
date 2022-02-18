# This file was generated, do not modify it. # hide
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