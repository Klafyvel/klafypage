+++
title = "My blog posts"

include("blogposts.jl")

contents_displayed = blogposts
+++

~~~
<div class="hero">
  <div class="hero-body">
    <div class="content">
~~~
# Blog posts hosted on this website


~~~
    </div>
  </div>
</div>
~~~

{{ insertcards contents_displayed }}
