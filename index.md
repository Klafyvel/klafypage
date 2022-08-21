@def title = "Klafyvel's personal page"

+++

using Markdown

include("contents.jl")

highlighted_contents = filter(x->hasproperty(x,:highlight)&&x.highlight, contents)

include("projects.jl")

highlighted_projects = filter(x->hasproperty(x,:highlight)&&x.highlight, projects)

include("blogposts.jl")

highlighted_blogposts = filter(x->hasproperty(x,:highlight)&&x.highlight, blogposts)

include("academics.jl")

highlighted_academics = filter(x->hasproperty(x,:highlight)&&x.highlight,
academics)

+++

~~~
<header class="section">
  <div class="container">
    <div class="columns is-mobile is-centered is-multiline">
      <div class="column is-one-fifth-tablet">
        <div class="content">
          <img class="is-rounded" src="{{ avatar }}" alt="A picture of my uggly mug" />
          <h1>
            Hugo Levy-Falk
          </h1>
          <p>
            {{ description }}
            <br/>
            at <a href="https://www.lumin.universite-paris-saclay.fr/fr">Laboratoire LuMIn</a>
          </p>
          <p id="social">
            <a href="https://twitter.com/klafyvel" class="icon is-large">
              <img src="assets/logo-twitter.svg" alt="@klafyvel"/>
            </a>
            <a href="https://www.linkedin.com/in/hugo-levy-falk/" class="icon is-large">
              <img src="assets/logo-linkedin.svg" alt="hugo-levy-falk"/>
            </a>
            <a href="https://github.com/klafyvel" class="icon is-large">
              <img src="assets/logo-github.svg" alt="@klafyvel"/>
            </a>
            <a href="#contact" class="icon is-large">
              <img src="assets/logo-mail.svg" alt="contact@klafyvel.me"/>
            </a>
          </p>
        </div>
      </div>
      <div class="column is-two-thirds-tablet">
        <div class="content is-medium">
~~~

## You Somehow made it to my personal page !

I am a PhD student working on hybrid halide perovskites' photophysics. I enjoy making things in my free time, such as small electronics projects, nice physics animations or programming small utilities.

I have a degree in engineering from [CentraleSupélec](https://www.centralesupelec.fr/en) (Diplôme d'ingénieur de l'École Supérieure d'Électricité) and a master of science in optics and photonics from [Imperial College London](http://www.imperial.ac.uk/), that I both obtained in 2020. I am currently studying for my PhD in Université Paris-Saclay.

You can find [here](/assets/cv.pdf) an up-to-date CV (august 2022).

On this page you can find :
- My [academics publications](#academics),
- Some highlighted [contents](#contents) that I published on the Internet,
- Some of my [projects](#projects) that I am proud to share,
- Some [blog posts](#blogposts),
- A way to [contact](#contact) me if you wish !

~~~
        </div>
      </div>
    </div>
  </div>
</header>
~~~

~~~
~~~

{{ cardsection "Academic publications" "I am a physicist exploring condensed matter property through various spectroscopy methods. Check <a href='/academics'>the Academics section</a>." "academics" highlighted_academics }}

{{ cardsection "Contents available on the internet" "I update thoses from time to time. Some are in english others are in french. A more complete list is available in <a href='/contents'>the Contents section</a>." "contents" highlighted_contents right }}

{{ cardsection "Some interesting projects of mine" "You might be interested in my <a href='https://github.com/Klafyvel/' class='link'>Github account</a>. A more complete list is also available in <a href='/projects'>the Projects section</a>." "projects" highlighted_projects}}

{{ cardsection "Highlighted blog posts" "A more complete list is also available in <a href='/blog'>the Blog section</a>." "blogposts" highlighted_blogposts right}}

~~~
<section class="hero is-fullheight" id="contact">
  <div class="hero-body">
    <div class="content is-medium">
~~~
## Contact me !

You can contact me *via* [my social media](#social), or drop-me an email at [contact@klafyvel.me](mailto:contact@klafyvel.me).

If you do so, feel-free to use my PGP key :
~~~
<a href="assets/public.key" class="icon-text">
  <span class="icon">
    <img src="assets/lock-closed.svg" alt="PGP lock"/>
  </span>
  <span>
    <small><code>85B696BB7726AF2739E98AD75154221C97ABD7DC</code></small>
  </span>
</a>
~~~

~~~
    </div>
  </div>
</section>
~~~
