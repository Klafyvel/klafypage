# This file was generated, do not modify it. # hide
function reverse_bit_order!(X, order)
  N = length(X)
  for i in 0:(N-1)
    j = bit_reverse(order, i)
    if i<j
      X[i+1],X[j+1]=X[j+1],X[i+1]
    end
  end
  X
end