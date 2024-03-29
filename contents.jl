contents = [
            (
             href="https://zestedesavoir.com/billets/4505/le-fediverse-dans-tous-ses-meta/",
             image="https://zestedesavoir.com/media/galleries/21588/187f6afc-3591-41da-bd07-8dbb3861974b.png.60x60_q95_crop.png",
             subtitle="",
             title=" Le Fediverse dans tous ses Meta ",
             intro="Ces dernières semaines ont été mouvementées sur le Fediverse. Les réseaux sociaux fédérés qui le composent, et Mastodon en tête, ont grossi soudainement depuis l’acquisition de Twitter par le controversé Elon Musk. Mais des concurrents commerciaux pourraient bien émerger.
<br/>
Ce long article finit par un petit guide pratique pour se mettre au Fediverse. N’hésitez pas à vous y rendre si le reste vous intéresse moins !",
             date=Date("03-08-2023", dateformat"d-m-y"),
             tags=["French", "Fediverse"],
             site="zestedesavoir.com",
             highlight=true,
             ),
            (
             href="https://zestedesavoir.com/billets/4328/petite-lecon-de-vim-apprendre-a-gerer-ses-motions/",
             image="https://zestedesavoir.com/media/galleries/19161/ec9ba647-9b8a-482a-86c7-92f9b904ab44.png.60x60_q95_crop.png",
             subtitle="",
             title="Petite leçon de Vim : Apprendre à gérer ses motions",
             intro="Vous êtes-vous déjà demandé pourquoi un éditeur tel que Vim, à l’apparence si austère dans sa configuration par défaut, jouissait d’une popularité importante sur les Internets ? Ou peut-être qu’en assistant à une de ces présentations où quelqu’un utilise Vim et où l’on voit s’afficher chacune des touches appuyées vous avez pensé qu’il fallait être fou pour être capable de mémoriser autant de combinaisons obscures ? Ou encore peut-être êtes-vous tombés complètement par hasard sur cet article et cherchez de quoi occuper vos dix prochaines minutes.",
             date=Date("29-10-2022", dateformat"d-m-y"),
             tags=["French", "vim", "neovim"],
             site="zestedesavoir.com",
             ),
            (
             href="https://www.reddit.com/r/swaywm/comments/we946s/a_simple_stupid_script_to_toggle_wireguard_using/",
             image="https://styles.redditmedia.com/t5_39q1c/styles/communityIcon_6wjsixewzz211.png?width=256&s=b5fba30f9a6b7c9cddb4f26ca96576f1b50dfb47",
             title="A simple, stupid script to toggle wireguard using systemd.",
             subtitle="",
             intro="""Hi there,

             I got tired of having to manage my wireguard connection using the command line (especially checking if the connection was active), so I wrote a small script that allows me to start and stop the connection whenever I want. It is simple enough that you can customize any part you want.

             Please, feel free to send suggestions!

             <a href="https://github.com/Klafyvel/wireguard-manager">https://github.com/Klafyvel/wireguard-manager</a>""",
             date=Date("02-08-2022", dateformat"d-m-y"),
             site="r/swaywm",
             tags=["English", "Sway", "Wayland", "Wireguard"],
            ),
            (
             href="https://zestedesavoir.com/billets/4258/en-periode-de-canicule-une-idee-fixe-economiser-la-float/",
             image="https://zestedesavoir.com/media/galleries/18437/ffed6cd7-df47-4ca5-867a-0d893209aad8.png.60x60_q95_crop.jpg",
             title="En période de canicule, une idée fixe: économiser la float",
             subtitle="",
             intro="""<p>Dans le deuxième article de cette série, nous avons vu comment implémenter une
             simili multiplication pour les flottants. Cette approximation nous permettait
             de gagner quelques microsecondes par multiplication, et avait également
             l’avantage d’avoir un coût d’utilisation constant.</p>
             <p>Pour la comparaison, j’ai donné les temps nécessaires pour multiplier deux entiers <code>long</code> de 32 bits.
             Notre petite mesure donnait 5,75 µ s pour la multiplication entière, contre
             7,1875µ s pour la multiplication flottante. La différence étant encore plus
             flagrante pour l’addition. Nous avions expliqué cela par la nécessité pour le
             compilateur d’émuler une FPU (<em>Floating Point Unit</em>) afin d’être en mesure de
             réaliser les opérations sur les flottants. La conclusion que nous en avions tirée
             était qu’il fallait parfois mieux ne pas utiliser ces flottants, et les
             remplacer par des nombres en virgule fixe. C’est tout l’objet de ce troisième et
             dernier article de la série!</p>""",
             date=Date("02-08-2022", dateformat"d-m-y"),
             site="zestedesavoir.com",
             tags=["French", "arduino", "assembly", "fixed-point"],
            ), 
            (
             href="https://zestedesavoir.com/billets/4228/utiliser-son-ipad-pro-comme-deuxieme-ecran-avec-sway/",
             image="/assets/bouletmaton.jpg",
             title="Utiliser son IPad Pro comme deuxième écran avec Sway",
             subtitle="Via une connection VNC sur le réseau local.",
             intro="""""",
             date=Date("30-06-2022", dateformat"d-m-y"),
             site="zestedesavoir.com",
             tags=["French", "linux", "arch linux", "sway", "wayland", "ipad", "vnc"],
            ),
            (
             href="https://zestedesavoir.com/contenus/4226/multiplications-avec-arduino-jetons-nous-a-la-float/",
             image="https://zestedesavoir.com/media/galleries/18166/3ceb7570-bb51-4605-9174-e743c5de4074.png.60x60_q95_crop.jpg",
             title="Multiplications avec Arduino : jetons-nous à la float",
             subtitle="",
             intro="""<p>Dans <a href="https://zestedesavoir.com/billets/4199/ieee-754-quand-votre-code-prend-la-float/">mon précédent billet</a>, nous avons discuté de la représentation flottante des nombres. Dans cet article, on va voir comment on peut utiliser cette représentation pour effectuer des opérations. En particulier, on va s’intéresser à l’implémentation d’une multiplication de flottants sur le processeur de l’Arduino Uno: l’ATMega328P, un microcontrôleur 8 bits.</p>""",
             date=Date("26-06-2022", dateformat"d-m-y"),
             site="zestedesavoir.com",
             tags=["French", "assembly", "arduino", "float"],
            ),
            (
             href="https://zestedesavoir.com/contenus/4199/ieee-754-quand-votre-code-prend-la-float/",
             image="https://zestedesavoir.com/media/galleries/17899/36fca3eb-f2f9-4ef7-8475-70ea466b8a95.png.60x60_q95_crop.jpg",
             title="IEEE 754 : Quand votre code prend la float",
             subtitle="",
             intro="""Ceci est le premier article d’une série de trois. Le but de la série est de s’amuser avec les nombres à virgule. On va jouer avec les flottants et les nombres à virgule fixe sur des processeurs 8 bits. Dans ce premier article, je vous propose de vous (re)familiariser avec les nombres flottants. Bref, on va parler de la norme IEEE 754.""",
             date=Date("26-05-2022", dateformat"d-m-y"),
             site="zestedesavoir.com",
             tags=["French", "c++", "arduino", "bits", "float"],
            ),
            (
             href="https://zestedesavoir.com/contenus/4153/approximer-rapidement-le-carre-dun-nombre-flottant/",
             image="/assets/bouletmaton.jpg",
             title=" Approximer rapidement le carré d'un nombre flottant ",
             subtitle=" Plus un aide mémoire pour moi, mais si ça peut aider quelqu'un pourquoi pas ? ",
             intro="""<p>Je cherchais récemment un moyen de calculer rapidement des carrés de nombres flottants sur mon Arduino. J’avais en tête quelque chose dans le style du fameux <a href="https://en.wikipedia.org/wiki/Fast_inverse_square_root">calcul de l’inverse de la racine carrée</a>, mais après quelques minutes de recherche je n’ai pas réussi à mettre la main dessus. Du coup j’ai passé une vingtaine de minutes à bidouiller une solution.</p>""",
             date=Date("07-03-2022", dateformat"d-m-y"),
             site="zestedesavoir.com",
             tags=["French", "c++", "arduino", "bits", "float"],
            ),
            (
             href="https://zestedesavoir.com/contenus/4117/quelques-outils-pour-le-physicien-avec-julia/",
             image="https://zestedesavoir.com/media/galleries/16980/a884b2c9-9b8d-44fa-a240-fac763168958.png.60x60_q95_crop.png",
             title=" Quelques outils pour le physicien avec Julia",
             subtitle="",
             intro="""<p>Bien choisir les outils que l’on utilise au quotidien est important. Pour ma part, je veux des outils avec lesquels je suis à
             l’aise, qui soient suffisamment performants et qui produisent
             des rendus de bonne qualité.</p>
             <p>Dans la vie de tous les jours, je suis physicien. Plus précisément, j’étudie la photo-physique de semi-conducteurs un
             peu exotiques. Concrètement, cela signifie que je passe beaucoup de temps en salle de manipe à collecter des données de
             spectroscopie. Je ne suis donc pas un physicien théoricien qui
             utiliserait l’informatique pour faire du calcul symbolique, ou
             un numéricien qui utiliserait de gros calculateurs pour faire
             tourner des simulations. Mon utilisation de l’informatique est
             double :</p>
             <ul>
             <li>Contrôler mon expérience finement;</li>
             <li>Traiter les données acquises, c’est-à-dire réaliser des ajustements de variable sur les données par rapport à des modèles relativement simples, et surtout afficher les données
             pour alimenter ma réflexion.</li>
             </ul>
             <p>Aujourd’hui j’ai choisi de vous détailler un peu la manière
             dont je réalise la seconde partie. Ceci n’a absolument pas vocation à être une recommandation d’utilisation, ou à dénigrer
             d’autres manières de travailler. Cependant, si cela peut donner
             des idées pour s’inspirer, ou si vous pensez que je suis passé à
             côté d’un outil intéressant, n’hésitez pas à me contacter.</p>""",
             date=Date("14-02-2022", dateformat"d-m-y"),
             site="zestedesavoir.com",
             tags=["French", "Julia"],
             highlight=true,
            ),
            (
             href="https://zestedesavoir.com/tutoriels/3939/jouons-a-implementer-une-transformee-de-fourier-rapide/",
             image="https://zestedesavoir.com/media/galleries/14851/fee78415-904c-4699-a560-df813fc10b3d.png.60x60_q95_crop.png",
             title="Jouons à implémenter une transformée de Fourier rapide !",
             subtitle="Un algorithme que vous utilisez probablement au quotidien.",
             intro="""La transformée de Fourier est un outil essentiel dans de nombreux domaines, que ce soit en Physique, en traitement du signal, ou en Mathématiques. La méthode qui est probablement la plus connue pour la calculer numériquement s’appelle la FFT pour Fast Fourier Transform, ou Transformée de Fourier Rapide. Dans ce petit tutoriel, je vous propose d’essayer de comprendre et d’implémenter cet algorithme de manière efficace. J’utiliserais pour cela le langage Julia, mais il devrait vous être possible de suivre en utilisant d’autres langages tels que Python ou C. Nous comparerons les résultats obtenus avec ceux donnés par le portage en Julia de la bibliothèque FFTW.""",
             date=Date("29-06-2021", dateformat"d-m-y"),
             site="zestedesavoir.com",
             tags=["French", "FFT", "Signal Processing", "Julia"],
             highlight=true,
            ),
            (
             href="https://zestedesavoir.com/contenus/3519/des-lentilles-et-des-matrices/",
             image="https://zestedesavoir.com/media/galleries/10827/5aaa1889-a47d-4add-8737-743e962390c2.png",
             title="Des lentilles et des matrices",
             subtitle="",
             intro="""Dans mon <a href="https://zestedesavoir.com/billets/3515/optique-geometrique-et-matrices/">précédent billet</a> j’ai introduit une approche matricielle de l’optique géométrique. Cependant la méthode que j’ai donnée ne permet pas encore d’aller bien loin. Dans ce billet je vous propose de l’étendre un petit peu pour nous permettre de traiter des lentilles !""",
             date=Date("05-05-2020", dateformat"d-m-y"),
             site="zestedesavoir.com",
             tags=["French", "Optics", "Physics"],
            ),
            (
             href="https://zestedesavoir.com/contenus/3515/optique-geometrique-et-matrices/",
             image="https://zestedesavoir.com/media/galleries/10795/8ede4a5b-8442-4e7d-b9d0-683fa5f3158e.png",
             title=" Optique géométrique et matrices ",
             subtitle="",
             intro="Aujourd’hui j’aimerais vous présenter une technique qui permet de simplement modéliser un système optique sans recourir aux traditionnelles formules de conjugaison que l’on apprend au lycée. Cette technique a l’avantage d’être relativement simple et c’est pourquoi je vais tenter de l’introduire dans ce billet !",
             date=Date("12-04-2020", dateformat"d-m-y"),
             site="zestedesavoir.com",
             tags=["French", "Optics", "Physics"],
            ),
            (
             href="https://zestedesavoir.com/contenus/2750/re2o-un-projet-de-federeziens/",
             image="https://zestedesavoir.com/media/galleries/5333/8395db80-75e3-415f-a0a9-ec8955068cf6.png.60x60_q95_crop.png",
             title="Re2o, un projet de federeziens",
             subtitle="",
             intro="Il y a de cela presque un an, je disais définitivement au revoir à la prépa et me préparais à intégrer une école d’ingénieurs, Supélec, sur le campus de Metz. Je m’étais alors promis que ce serait l’occasion de me remettre à bricoler et programmer plus sérieusement. J’avais en particulier envie de m’investir dans la vie associative. Dans ce billet je vais vous présenter le projet qui a occupé une très grande place pour moi cette année.",
             date=Date("17-08-18", dateformat"d-m-y"),
             site="zestedesavoir.com",
             tags=["French", "Free software", "Python", "Sys-Admin"],
            )
           ]


