# This file was generated, do not modify it. # hide
t = range(-10, 10; length=1024)
y = @. sin(t)
noise = rand(1024)
test_signal(y .+ noise)