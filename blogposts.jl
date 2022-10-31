blogposts = [
    (
        href="/blog/articles/approximate-euclidian-norm/",
        image="/assets/blog/articles/approximate-euclidian-norm/logo.png",
        title="A nice approximation of the norm of a 2D vector.",
        subtitle="Some cool sunday project!",
        intro="""
While wandering on the internet, I stumbled uppon Paul Hsieh's blog-post, where he demonstrates a way to approximate the norm  of a vector without any call to the sqrt function. Let's see if I can reproduce the steps to derive this.
""",
        date=Date("30-10-2022", dateformat"d-m-y"),
        site="this website !",
        tags=["English", "julia", "calculus"],
        highlight=true,
    ), 
    (
        href="/blog/articles/freecad-honeycomb/",
        image="/assets/blog/articles/freecad-honeycomb/image-26.jpg",
        title="Modeling a honeycomb grid in FreeCAD",
        subtitle="A small tutorial on FreeCAD",
        intro="""Someone asked me how to make a honeycomb grid in @FreeCADNews. Here's how I do it, and bonus it's parametric! ⬇️""",
        date=Date("04-08-2022", dateformat"d-m-y"),
        site="this website !",
        tags=["English", "FreeCAD", "honeycomb", "twitter"],
        highlight=true,
    ), 
    (
        href="/blog/articles/fft-julia/",
        image="/assets/blog/articles/fft-julia/logo.png",
        title="Let's play at implementing a fast Fourier transform!",
        subtitle="An algorithm you probably use on a daily basis.",
        intro="""The Fourier transform is an essential tool in many fields, be it in Physics, Signal Processing, or Mathematics. The method that is probably the most known to calculate it numerically is called the FFT for Fast Fourier Transform. In this little tutorial, I propose to try to understand and implement this algorithm in an efficient way. I will use the language Julia, but it should be possible to follow using other languages such as Python or C. We will compare the results obtained with those given by the Julia port of the FFTW library.""",
        date=Date("13-02-2022", dateformat"d-m-y"),
        site="this website !",
        tags=["English", "FFT", "Signal Processing", "julia"],
        highlight=true,
    ),
   ]
