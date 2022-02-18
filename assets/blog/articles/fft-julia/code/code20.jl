# This file was generated, do not modify it. # hide
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