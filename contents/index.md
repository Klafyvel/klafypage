+++
title = "My online contents"

include("contents.jl")

contents_displayed = contents
+++

~~~
<div class="hero">
  <div class="hero-body">
    <div class="content">
~~~
# Contents available on the Internet

I update thoses from time to time. Some are in english others are in french.

~~~
    </div>
  </div>
</div>
~~~

{{ insertcards contents_displayed }}
