@def title="A nice approximation of the norm of a 2D vector."
@def subtitle=""
@def mintoclevel=1
@def rss_description = "A nice approximation of the norm of a 2D vector."
@def rss_pubdate = Date(2022, 10, 30)

While wandering on the internet, I stumbled uppon [Paul Hsieh's blog-post](http://www.azillionmonkeys.com/qed/sqroot.html#distance),  where he demonstrates a way to approximate the norm  of a vector without any call to the sqrt function. Let's see if I can reproduce the steps to derive this.

----
# Table of contents

\toc

----

# Setting-up the scene.

Calculating the norm of a vector $(x,y)$, or a complex number $x+iy$ means calculating $\sqrt{x^2+y^2}$. Without loss of generality, we can set $\sqrt{x^2+y^2}=1$. If we draw this, we get the following.

```julia:./code/import.jl
#hideall
using CairoMakie
```

```julia:./code/defines.jl
#hideall
θ = 0:0.01:2π
x,y = cos.(θ), sin.(θ);
```
```julia:./code/illustration1.jl
#hideall
let
	f = Figure()
	ax = Axis(f[1,1], 
		xlabel="x", ylabel="y",
		limits=(-2,2,-2,2),
		aspect=1,
		xgridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		ygridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		xticks=([0], ["0"]),
		yticks=([0], ["0"]),
		xlabelvisible=false,
		ylabelvisible=false,
		xticksvisible=false,
		yticksvisible=false,
		xticklabelsvisible=false,
		yticklabelsvisible=false,
	)
	hidespines!(ax)
	lines!(ax, x, y, label=L"\sqrt{x^2+y^2}=1")
	axislegend(ax)
  save(joinpath(@OUTPUT, "illustration1.svg"), f)
end
```

\figure{The (x,y) pairs with an euclidian norm of 1.}{./code/output/illustration1.svg}

# Finding a lower bound to the norm.

Now, the issue with the norm is that the $\sqrt{}$ operation is expensive to compute. That's why we would like anohter way to approximate the norm. A first idea is to look at other norms available, indeed, what we have called "norm" so far is actually the 2-norm, also named *euclidian norm*. Let's have a look at two other norms : the infinity norm and the manhattan norm.

Infinity norm is :
$$
\lVert(x,y)\rVert_\infty = \max(x,y)
$$

Manhattan norm is :
$$
\lVert(x,y)\rVert_1 = |x|+|y|
$$

```julia:./code/illustration2.jl
#hideall
let
	f = Figure()
	ax = Axis(f[1,1], 
		xlabel="x", ylabel="y",
		limits=(-2,2,-2,2),
		aspect=1,
		xgridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		ygridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		xticks=([0], ["0"]),
		yticks=([0], ["0"]),
		xlabelvisible=false,
		ylabelvisible=false,
		xticksvisible=false,
		yticksvisible=false,
		xticklabelsvisible=false,
		yticklabelsvisible=false,
	)
	hidespines!(ax)
	lines!(ax, x, y, label=L"\sqrt{x^2+y^2}=1")
	lines!(ax, [-1, 0, 1, 0, -1], [0, 1, 0, -1, 0], label=L"|x|+|y|=1")
	lines!(ax, [-1, -1, 1, 1, -1], [-1, 1, 1, -1, -1], label=L"\max(|x|,|y|)=1")
	axislegend(ax)
  save(joinpath(@OUTPUT, "illustration2.svg"), f)
end
```

\figure{The (x,y) pairs with an euclidian norm of 1, an infinity norm of 1 or a manhattan norm of 1.}{./code/output/illustration2.svg}

Now we see the Manhattan norm is indeed a lower bound for the 2-norm, even if it's rough. The Infinity norm, however, is too high. But that is not an issue, we could simply scale it up so that it is always higher than the 2-norm. The scaling factor is chosen, such as the yellow curve tangent to the circle. For that, we need it to be equal to $\cos\frac{\pi}{4}=\frac{1}{\sqrt{2}}$.

```julia:./code/illustration3.jl
#hideall
let
	f = Figure()
	ax = Axis(f[1,1], 
		xlabel="x", ylabel="y",
		limits=(-2,2,-2,2),
		aspect=1,
		xgridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		ygridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		xticks=([0], ["0"]),
		yticks=([0], ["0"]),
		xlabelvisible=false,
		ylabelvisible=false,
		xticksvisible=false,
		yticksvisible=false,
		xticklabelsvisible=false,
		yticklabelsvisible=false,
	)
	hidespines!(ax)
	lines!(ax, x, y, label=L"\sqrt{x^2+y^2}=1")
	lines!(ax, [-√2, 0, √2, 0, -√2], [0, √2, 0, -√2, 0], label=L"\frac{1}{\sqrt{2}}(|x|+|y|)=1")
	lines!(ax, [-1, -1, 1, 1, -1], [-1, 1, 1, -1, -1], label=L"\max(|x|,|y|)=1")
	axislegend(ax)
  save(joinpath(@OUTPUT, "illustration3.svg"), f)
end
```

\figure{We now have a nice lower bound of the euclidian norm!}{./code/output/illustration3.svg}

We have a lower bound! By choosing the closest to the circle between the yellow and green curves, we get an octagon that is very close to the circle. We can define the upper bound of the circle with a function $f$ such as:

$$
f(x,y) = \max\left(\max(x,y), \frac{1}{\sqrt{2}}(|x|+|y|)\right)
$$

Note that this is different from Paul's article. You **do** need to take the maximum value of the two norms to select the points that are closest to the center. Generally speaking, for two norms, if one's value is higher than the other, then the former will be drawn closer to the origin when plotting the $\text{norm}(x,y)=1$ curve.

To trace this function, note that Manhattan and infinity norms isolines cross when $|y|=1$ and $|x| = \sqrt{2}-1$ or $|x|=1$ and $|y| = \sqrt{2}-1$.

```julia:./code/illustration4.jl
#hideall
let
	f = Figure()
	ax = Axis(f[1,1], 
		xlabel="x", ylabel="y",
		limits=(-2,2,-2,2),
		aspect=1,
		xgridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		ygridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		xticks=([0], ["0"]),
		yticks=([0], ["0"]),
		xlabelvisible=false,
		ylabelvisible=false,
		xticksvisible=false,
		yticksvisible=false,
		xticklabelsvisible=false,
		yticklabelsvisible=false,
	)
	hidespines!(ax)
	lines!(ax, x, y, label=L"\sqrt{x^2+y^2}=1")
	lines!(ax, [-√2, 0, √2, 0, -√2], [0, √2, 0, -√2, 0], label=L"\frac{1}{\sqrt{2}}(|x|+|y|)=1", linestyle=:dot)
	lines!(ax, [-1, -1, 1, 1, -1], [-1, 1, 1, -1, -1], label=L"\max(|x|,|y|)=1", linestyle=:dot)
	lines!(ax, [-1, -1, -(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1], [-(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1, -1, -(√2 - 1)], label=L"f(x,y)=1")
	axislegend(ax)
  save(joinpath(@OUTPUT, "illustration4.svg"), f)
end

```
\figure{The lower bound of the norm outlined.}{./code/output/illustration4.svg}

# Finding an upper bound to the norm.
The first idea you can get from the lower bound we found is to scale it up so that the octagon corners touch the circle.

To do so, we need to find the 2-norm of one of the corners and divide $f$ by it.

Let's take the one at $x=1$, $y=\sqrt{2}-1$. We have:

$$
\begin{align}
\sqrt{x^2+y^2} &=& \sqrt{1 + \left(\sqrt{2}-1\right)^2}\\
&=& \sqrt{1 + 2 - 2\sqrt{2} + 1}\\
&=& \sqrt{4 - 2\sqrt{2}}
\end{align}
$$

Thus the upper-bound for the 2-norm with the octagon method is $\sqrt{4 - 2\sqrt{2}}f(x,y)$:

$$
f(x,y) \leq \sqrt{x^2+y^2} \leq \sqrt{4 - 2\sqrt{2}}f(x,y)
$$

```julia:./code/illustration5.jl
#hideall
let
	f = Figure()
	ax = Axis(f[1,1], 
		xlabel="x", ylabel="y",
		limits=(-2,2,-2,2),
		aspect=1,
		xgridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		ygridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		xticks=([0], ["0"]),
		yticks=([0], ["0"]),
		xlabelvisible=false,
		ylabelvisible=false,
		xticksvisible=false,
		yticksvisible=false,
		xticklabelsvisible=false,
		yticklabelsvisible=false,
	)
	hidespines!(ax)
	lines!(ax, x, y, label=L"\sqrt{x^2+y^2}=1")
	lines!(ax, [-√2, 0, √2, 0, -√2], [0, √2, 0, -√2, 0], label=L"\frac{1}{\sqrt{2}}(|x|+|y|)=1", linestyle=:dot)
	lines!(ax, [-1, -1, 1, 1, -1], [-1, 1, 1, -1, -1], label=L"\max(|x|,|y|)=1", linestyle=:dot)
	lines!(ax, [-1, -1, -(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1], [-(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1, -1, -(√2 - 1)], label=L"f(x,y)=1")
	a = 1/√(4-2√2)
	lines!(ax, [-1, -1, -(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1].*a, [-(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1, -1, -(√2 - 1)].*a, label=L"\sqrt{4 - 2\sqrt{2}}f(x,y)=1")
	axislegend(ax, nbanks=2)
  save(joinpath(@OUTPUT, "illustration5.svg"), f)
end

```
\figure{The upper and lower bounds of the norm outlined.}{./code/output/illustration5.svg}

# Choosing the best approximation for the norm.
Now, we could stick to Paul Hsieh's choice of taking the middle between the lower and the upper bounds, and it will probably be fine. But come on, let's see if it is the *best* choice. 😉

Formally, the problem is to find a number $a\in[0,1]$ such as $g$ defined as follow is the closest possible to the norm-2.

$$
\begin{align}
g(x,y,a) &=& (1-a)f(x,y)+\frac{a}{\sqrt{4 - 2\sqrt{2}}}f(x,y)\\
&=& \left((1-a) + a\sqrt{4 - 2\sqrt{2}}\right)f(x,y)
\end{align}
$$

Let's plot this function for various values of $a$. To make things easier, I will "unroll" the circle, and plot the norms against $\theta$, the angle between our vector and the $x$ axis.

```julia:./code/function_defs.jl
#hideall
f(x,y) = max(max(abs(x),abs(y)), (abs(x) + abs(y))/√2)
g(x,y,a) = ((1-a) + a*√(4-2√2))*f(x,y)
```

```julia:./code/illustration6.jl
#hideall
let
	f = Figure()
	ax = Axis(
		f[1,1],
		xlabel=L"\theta\;(\text{rad})",
		ylabel="Norm"
	)
	hlines!(ax, 1, label=L"\sqrt{x^2+y^2}=1")
	for (i,a) in enumerate([0, 0.25, 0.5, 0.75, 1])
		if a∈[0, 1]
			linestyle=:solid
		else
			linestyle=:dot
		end
		lines!(ax, θ, g.(x, y, a), color=Cycled(1+i), label=L"g(x,y,a=%$(a))", linestyle=linestyle)
	end
	axislegend(ax)
  save(joinpath(@OUTPUT, "illustration6.svg"), f)
end

```
\figure{Various possible approximations for the norm.}{./code/output/illustration6.svg}

As expected, we can continuously vary our approximation between the upper and lower bounds. Notice that these functions are periodic and even. We can thus focus on the first half period to minimize the error. The first half period is when the vector is at the first octagon vertice, starting from the $x$ acis and circling anti-clockwise.

```julia:./code/illustration7.jl
#hideall
let
	f = Figure()
	ax = Axis(f[1,1], 
		xlabel="x", ylabel="y",
		limits=(0,2,-0.5,0.5),
		aspect=DataAspect(),
		xgridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		ygridcolor=RGBAf(0.0,0.0,0.0, 0.5),
		xticks=([0], ["0"]),
		yticks=([0], ["0"]),
		xlabelvisible=false,
		ylabelvisible=false,
		xticksvisible=false,
		yticksvisible=false,
		xticklabelsvisible=false,
		yticklabelsvisible=false,
	)
	θn = -π/5:0.001:π/5
	xn,yn = cos.(θn), sin.(θn);
	hidespines!(ax)
	lines!(ax, xn, yn, label=L"\sqrt{x^2+y^2}=1")
	lines!(ax, [1/√2, √2, 1/√2], [1/√2, 0, -1/√2], label=L"\frac{1}{\sqrt{2}}(|x|+|y|)=1", linestyle=:dot)
	lines!(ax, [1, 1], [-1/√2, 1/√2], label=L"\max(|x|,|y|)=1", linestyle=:dot)
	lines!(ax, [-1, -1, -(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1], [-(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1, -1, -(√2 - 1)], label=L"f(x,y)=1")
	a = 1/√(4-2√2)
	lines!(ax, [-1, -1, -(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1].*a, [-(√2 - 1), √2 - 1, 1, 1, √2 - 1, -(√2 - 1), -1, -1, -(√2 - 1)].*a, label=L"\sqrt{4 - 2\sqrt{2}}f(x,y)=1")
	a = √2-1
	ablines!(ax, 0, a, color=RGBAf(0.0,0.0,0.0, 0.5))
	θa = 0:0.01:atan(a)
	lines!(ax, 0.3cos.(θa), 0.3sin.(θa), color=RGBAf(0.0,0.0,0.0, 0.5))
	text!(ax, 0.3, 0.05;text=L"\theta_r=\arctan({\sqrt{2}-1})")
	axislegend(ax, nbanks=2)
  save(joinpath(@OUTPUT, "illustration7.svg"), f)
end

```
\figure{Zooming in the part of the unit circle that is interesting for calculating the error.}{./code/output/illustration7.svg}

To minimize the error with our approximation, we want to minimize the square error. That is:

$$
\begin{align}
e(a) &=& \int_0^{\arctan\left(\sqrt{2}-1\right)}(g(x,y,a)-1)^2\text{d}\theta
\end{align}
$$

Thankfully, the expression of $f(x,y)$ and thus of $g(x,y,a)$ should simplify a lot on the given interval. You can see on schematic above that on this interval we have, $f(x,y)=max(|x|,|y|)=|x|=x=\cos\theta$. We can thus rewrite $e(a)$ as follow.

$$
\begin{align}
e(a) &=& \int_0^{\arctan\left(\sqrt{2}-1\right)}(g(x,y,a)-1)^2\text{d}\theta\\
&=& \int_0^{\arctan\left(\sqrt{2}-1\right)}\left(\left(1-a + a\sqrt{4-2\sqrt{2}}\right)\cos\theta-1\right)^2\text{d}\theta\\
&=& \int_0^{\arctan\left(\sqrt{2}-1\right)}\left(h(a)\cos\theta-1\right)^2\text{d}\theta
\end{align}
$$
Where $h(a)=\left(1-a + a\sqrt{4-2\sqrt{2}}\right)$ and $\arctan\left(\sqrt{2}-1\right)=\frac{\pi}{8}$.

```julia:./code/hdef.jl
#hideall
h(a) = (1-a + a*√(4-2√2))
```

```julia:./code/illustration8.jl
#hideall
let
	f = Figure()
	ax = Axis(
		f[1,1],
		xlabel=L"\theta\;(\text{rad})",
		ylabel=L"(h(a)\cos\theta-1)^2"
	)
	a = √2-1
	θa = 0:0.01:atan(a)
	for (i,a) in enumerate([0, 0.25, 0.5, 0.75, 1])
		lines!(ax, θa, (h(a).*cos.(θa).-1).^2, label=L"a=%$(a)", color=Cycled(i))
	end
	axislegend(ax)
  save(joinpath(@OUTPUT, "illustration8.svg"), f)
end

```
\figure{Square error against θ.}{./code/output/illustration8.svg}

```julia:./code/illustration9.jl
#hideall
let
	f = Figure()
	ax = Axis(
		f[1,1],
		xlabel=L"a",
		ylabel=L"e(a)"
	)
	a = √2-1
	θa = 0:0.01:atan(a)
	A = 0:0.01:1
	lines!(ax, A, [sum((h(a).*cos.(θa).-1).^2 .* 0.01) for a in A])
  save(joinpath(@OUTPUT, "illustration9.svg"), f)
end

```
\figure{Sum square error against a.}{./code/output/illustration9.svg}

As we can see from these plots, there is a minimal error, and though 0.5 is a reasonable choice for $a$, we can do slightly better around 0.3.

We can explicitely calculate $e(a)$. Let $h(a)=(1+a(A-1))$. We have

$$
\begin{align}
e(a) &=& \int_0^{\pi/8}(h(a)\cos\theta-1)^2\text{d}\theta\\
&=&h^2(a)\int_0^{\pi/8}\cos^2\theta\text{d}\theta-2h(a)\int_0^{\pi/8}\cos\theta\text{d}\theta + \frac{\pi}{8}\\
&=& h^2(a)B-2h(a)\sin\frac{\pi}{8} + \frac{\pi}{8}
\end{align}

$$
Where $B=\frac{\pi}{16}+\frac{1}{4\sqrt2}$. Thus we look for the position of the minimum, that is where $e'(a)=0$.

$$
\begin{align}
0 &=& 2B(A-1)(1+a(A-1))-\sin\frac{\pi}{8}\\
0 &=& 2B(A-1)(1+a(A-1)) - \frac{A}{2\sqrt2}\\
a &=& \left(\frac{A}{2B\sqrt2}-1\right)\times\frac{1}{A-1}\\
a &\approx& 0.311
\end{align}
$$

Not that far from 0.3!

```julia:./code/def_a.jl
#hideall
a = let
	B = π/16 + 1/(4√2)
	A = √(4-2√2)
	(A/(2B*√2)-1)/(A-1)
end
```

```julia:./code/def_ha.jl
#hideall
ha = h(a)
```

```julia:./code/def_max_dev.jl
#hideall
max_dev = max(h(a)-1, abs(h(a)*cos(π/8)-1))
```
The maximum deviation from the result is then $\max_\theta{|h(a)\cos\theta-1|}$. Looking for that maximum is like looking for the maximum of $\left(h(a)\cos\theta-1\right)^2$. Long story short, the maxima can only occur on the boundaries of the allowed domain for $\theta$, that is $\theta=0$ or $\theta=\pi/8$, meaning

$$
\max_\theta{|h(a)\cos\theta-1|} = \max\left(h(a)-1, \left|h(a)\frac{\sqrt{2-\sqrt{2}}}{2}-1\right|\right)
$$

With our choice for $a$, we get $h(a)\approx 1.026$, so the maximum deviation is 0.052. That is, we have at most a 5.3% deviation from the norm-2!

```julia:./code/illustration10.jl
#hideall
let
	f = Figure()
	ax = Axis(
		f[1,1],
		xlabel=L"\theta\;(\text{rad})",
		ylabel="Norm"
	)
	hlines!(ax, 1+max_dev, color=:black, label="Higher bound")
	hlines!(ax, 1-max_dev, color=:black, label="Lower bound")
	hlines!(ax, 1, label=L"\sqrt{x^2+y^2}=1")
	lines!(ax, θ, g.(x, y, a), color=Cycled(2), label=L"g(x,y,a\approx%$(round(a, sigdigits=3)))")
	axislegend(ax)
  save(joinpath(@OUTPUT, "illustration10.svg"), f)
end

```
\figure{Our best approximation for the euclidian norm, with the calculated maximum errors.}{./code/output/illustration10.svg}

# Conclusion
That was a fun sunday project! Originally this was intended to be included in a longer blog-post that is yet to be finished, but I figured it was interesting enough to have its own post. The take-home message being, you can approximate the Euclidian norm of a vector with:

$$
\begin{align}
\text{norm}(x,y) &=& \frac{\sqrt{2-\sqrt{2}}}{\frac{\pi}{8}+\frac{1}{2\sqrt{2}}}\max\left(\max(x,y), \frac{1}{\sqrt{2}}(|x|+|y|)\right)\\
&\approx& 1.026\max\left(\max(x,y), \frac{1}{\sqrt{2}}(|x|+|y|)\right)
\end{align}
$$

You'll get at most a 5.3% error. This is a bit different from what's proposed on [Paul Hsieh's blog-post](http://www.azillionmonkeys.com/qed/sqroot.html#distance). Unless I made a mistake, there might be a typo on his blog!

If you are interested in playing with the code used to generate the figures in this article, have a look at the [compagnon notebook](/assets/blog/articles/approximate-euclidian-norm/notebook.jl)!

As always, if you have any question, or want to add something to this post, you can leave me comment or ping me on [Twitter](httms://twitter.com/klafyvel) or [Mastodon](https://mastodon.social/@klafyvel).

