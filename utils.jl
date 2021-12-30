function hfun_bar(vname)
  val = Meta.parse(vname[1])
  return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
  var = vname[1]
  return pagevar("index", var)
end

function lx_baz(com, _)
  # keep this first line
  brace_content = Franklin.content(com.braces[1]) # input string
  # do whatever you want here
  return uppercase(brace_content)
end

function insertcard!(io, content)
    (;href, image, title, subtitle, intro, date, site, tags) = content

    write(io, """
    <div class="card mb-3">
      <div class="card-content">
        <div class="media">
          <div class="media-left">
            <figure class="image is-48x48">
              <a href="$href"><img src="$image" alt="Placeholder image"></a>
            </figure>
          </div>
          <div class="media-content">
            <p class="title is-4"><a href="$href"> $title </a></p>
            <p class="subtitle is-6"> $subtitle </p>
            <div class="tags">
        """)
    for t in tags
        write(io, """<span class="tag">$t</span>\n""")
    end
    write(io, """
            </div>
            <p class="has-text-justified"> $intro </p>
            <div class="columns is-mobile mt-2">
            <div class="column is-half has-text-left"><time datetime="$date">$(Dates.format(date, globvar("date_format")))</time></div>
              <div class="column is-half has-text-right"><a href="$href">⮩ See on $site</a></div>
            </div>
          </div>
        </div>
      </div>
    </div>""")
end

function hfun_insertcards(params)
    @assert length(params)==1 "Only one parameter for insertcards !"
    io = IOBuffer()
    contents = locvar(params[1])
    for c in contents
        insertcard!(io, c)
    end
    String(take!(io))
end

function hfun_cardsection(params)
    @assert length(params)>=4 "cardsection needs at least three parameters: title, subtitle, id and cards"
    io = IOBuffer()
    title, subtitle, id = params[1:3]
    cards = locvar(params[4])
    title_on_left = !(length(params) >= 5 && params[5] != "left")

    if title_on_left
        write(io, """
        <section class="section" id="$id">
          <div class="container">
            <div class="columns">
              <div class="column is-one-third">
                <h2 class="title">$title</h2>
                <p class="subtitle">$subtitle</p>
              </div>
              <div class="column">
              """)
    else
        write(io, """
        <section class="section" id="$id">
          <div class="container">
            <div class="columns">
              <div class="column">
              """)
    end
    for c in cards
        insertcard!(io, c)
    end
    if title_on_left
        write(io, """
              </div>
            </div>
          </div>
        </section>
        """)
    else
        write(io, """
              </div>
              <div class="column is-one-third">
                <h2 class="title">$title</h2>
                <p class="subtitle">$subtitle</p>
              </div>
            </div>
          </div>
        </section>
        """)
    end
    String(take!(io))
end
