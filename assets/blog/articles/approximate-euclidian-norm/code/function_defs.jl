# This file was generated, do not modify it. # hide
#hideall
f(x,y) = max(max(abs(x),abs(y)), (abs(x) + abs(y))/√2)
g(x,y,a) = ((1-a) + a*√(4-2√2))*f(x,y)