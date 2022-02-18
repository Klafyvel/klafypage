# This file was generated, do not modify it. # hide
function reverse_bit_order_double!(x, order)
  N = length(x)
  for i in 0:(N÷2-1)
    j = bit_reverse(order, i)
    if i<j
      # swap real part
      x[2*i+1],x[2*j+1]=x[2*j+1],x[2*i+1]
      # swap imaginary part
      x[2*i+2],x[2*j+2]=x[2*j+2],x[2*i+2]
    end
  end
  x
end