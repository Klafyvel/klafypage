@def title="Modeling a honeycomb grid in FreeCAD"
@def subtitle="A small tutorial on FreeCAD"
@def rss_description = "A small tutorial on FreeCAD"
@def rss_pubdate = Date(2022, 08, 4)

\information{This was originally a [Twitter thread](https://twitter.com/klafyvel/status/1555128187964858368), but it is easier to read here.}

Someone asked me how to make a honeycomb grid in @FreeCADNews. Here's how I do it, and bonus it's parametric! ⬇️

~~~
<figure style="text-align=center;">
<video controls>
    <source src="/assets/blog/articles/freecad-honeycomb/animated.mp4"
            type="video/mp4">

    Sorry, your browser doesn't support embedded videos.
</video>
<figcaption>A nicely animated plate with a honeycomb cut.</figcaption>
</figure>
~~~

Let's start with a simple plate with four holes. I give a name to each dimension in the sketcher so that I can re-use them later.

\figure{Sketching the plate.}{/assets/blog/articles/freecad-honeycomb/image-1.jpg}
\figure{Extruding it.}{/assets/blog/articles/freecad-honeycomb/image-2.jpg}

Then I create a new body and start sketching on the `XY` plane. For this example I wanted to constrain the hexagon side, so a bit of trigonometry is needed to get the width of each hexagon. I also decided here that the separation between hexagons would be about 2mm.

\figure{Sketching the first hexagon of the pattern}{/assets/blog/articles/freecad-honeycomb/image-3.jpg}
\figure{Extruding it.}{/assets/blog/articles/freecad-honeycomb/image-4.jpg}

The two construction lines will serve as directions to which we repeat the hexagon. Notice how I also link the pad length of the new solid with the plate pad length. Then we head to the `Create MultiTransform` tool in Part Design, and start a first `LinearPattern`. We need it a bit longer than the width of the plate since we will duplicate the hexagons sideways. Any "big" number will do, but a bit of trigonometry gives me the exact length.

\figure{Using MultiTransform to expand the pattern to the right.}{/assets/blog/articles/freecad-honeycomb/image-5.jpg}

Then using another `LinearPattern` I can complete the line of hexagons. Since our pattern is symmetric I could also have used a symmetry tool. As before I use one of the construction lines for the direction of the pattern.

\figure{Expanding the pattern to the left.}{/assets/blog/articles/freecad-honeycomb/image-6.jpg}

Now I do the other direction! Using another `LinearPattern`, the second construction line, and a bit of trigonometry (again).

\figure{Expanding the pattern to the top.}{/assets/blog/articles/freecad-honeycomb/image-7.jpg}

The number of occurrences is given by `Length / <<Sketch001>>.hexagon_sep` . Freecad will round that to the nearest integer, if you're not happy with that, you can mess around with ceil and floor. Then, once again I can complete the pattern.

\figure{Expanding the pattern to the bottom.}{/assets/blog/articles/freecad-honeycomb/image-8.jpg}

Let's create another body using the sketcher. It will represent the area where I want the honeycomb pattern to be present. I can re-use the dimensions I set for the base plate using their name.

\figure{Sketching the area where the honeycomb pattern will be cut.}{/assets/blog/articles/freecad-honeycomb/image-9.jpg}
\figure{Extruding it.}{/assets/blog/articles/freecad-honeycomb/image-10.jpg}

One body remaining! We want some of the hexagons to be full. So let's create a body representing these. It re-uses the dimensions of the first hexagon.

\figure{Sketching an hexagon looking exactly like the first one.}{/assets/blog/articles/freecad-honeycomb/image-11.png}
\figure{Extruding it.}{/assets/blog/articles/freecad-honeycomb/image-12.jpg}

Now I want to repeat the body a certain amount of time to fill some of the hexagons. Once again MultiTransform is our friend.

\figure{Expanding the new hexagon pattern to the right...}{/assets/blog/articles/freecad-honeycomb/image-13.jpg}
\figure{... then to the left.}{/assets/blog/articles/freecad-honeycomb/image-14.jpg}

Notice that I used the dimension from the honeycomb pattern to match the correct positions of the hexagon. Also, everything being parametric, I can simply change the number of hexagons by setting the `Occurrences` parameter of `LinearPatter004`. At this stage, I have four bodies. I named them `main_plate`, `hexagons`, `allowed_cut_zone` and `text_zone`.
Let's combine them cleverly using boolean operations!

\figure{`main_plate`}{/assets/blog/articles/freecad-honeycomb/image-15.jpg}
\figure{`hexagons`}{/assets/blog/articles/freecad-honeycomb/image-16.jpg}
\figure{`allowed_cut`}{/assets/blog/articles/freecad-honeycomb/image-17.jpg}
\figure{`text_zone`}{/assets/blog/articles/freecad-honeycomb/image-18.jpg}

First, let's remove the text zone from the allowed cut, using `PartDesign`'s boolean operation.

\figure{Combining `allowed_cut` and `text_zone`.}{/assets/blog/articles/freecad-honeycomb/image-19.jpg}
\figure{Resulting geometry.}{/assets/blog/articles/freecad-honeycomb/image-20.jpg}

Then I can create the cut zone, which is the intersection between the allowed cut zone and the hexagons.

\figure{Combining the previous geometry with `hexagons`.}{/assets/blog/articles/freecad-honeycomb/image-21.jpg}
\figure{This is the final pattern we want to cut from the original plate.}{/assets/blog/articles/freecad-honeycomb/image-22.jpg}

Finally, I can do the cutting, by taking the difference between the base plate and the cut zone.

\figure{Combining the pattern with the original plate.}{/assets/blog/articles/freecad-honeycomb/image-23.jpg}
\figure{Resulting cut plate.}{/assets/blog/articles/freecad-honeycomb/image-24.jpg}

I just need to add some text using the Draft workbench... whoops, the text zone is a bit too big, good thing that our model is parametric, so we can easily change its size. 😬

\figure{What a messy boy I am.}{/assets/blog/articles/freecad-honeycomb/image-25.jpg}

And there you have it!

\figure{Our nice and clean result.}{/assets/blog/articles/freecad-honeycomb/image-26.jpg}

If you want to mess around with the model, it is available [here](https://github.com/Klafyvel/FreeCad-Hexagon-showcase).

Have fun!

