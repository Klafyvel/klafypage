<!--
Add here global page variables to use throughout your website.
-->
+++
author = "Hugo Levy-Falk"
description = """PhD student in Photophysics"""
mintoclevel = 2
div_content = ""

avatar = "assets/bouletmaton.jpg"

date_format = "U dd, yyyy"

# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = ["node_modules/"]

# RSS (the website_{title, descr, url} must be defined to get RSS)
generate_rss = true
website_title = "Klafyvel"
website_descr = "Hugo Levy-Falk's web-page"
website_url   = "klafyvel.me"
rss_full_content = true
+++

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}

\newcommand{\blockcommand}[3]{
~~~
<div class="message #1">
<div class="message-header">
<p>#2</p>
</div>
<div class="message-body">
~~~
#3
~~~
</div>
</div>
~~~
}

\newcommand{\information}[1]{\blockcommand{is-info}{Information}{#1}}
\newcommand{\question}[1]{\blockcommand{is-link}{Question}{#1}}
\newcommand{\secret}[1]{\blockcommand{}{}{#1}}

\newcommand{\figure}[2]{
~~~
<figure style="text-align=center;">
~~~
\figalt{#1}{#2}
~~~
<figcaption>#1</figcaption>
</figure>
~~~
}
