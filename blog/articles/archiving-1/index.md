@def title="Building a proper archiving method for my things, episode 1"
@def subtitle="A.k.a, fixing errors from the past"
@def rss_description = "I'm looking for a solution I like for archiving my things."
@def rss_pubdate = Date(2024, 07, 27)

That's a topic I've been wanting to dive in for a long time. As I'm getting older, I start to have accumulated some amount of files accross, often salvaged from device to device, that are somewhat dear to me. In a way, I want to archive properly my things for the same reasons [this blogpost by my friend cookie](https://bookshelf.thequinn.fr/quinns-journaling-guide) convinced me to start journaling: later in time, I want to be able to remember how things were for me.

# Where do I start from?

I've got data scattered among multiple devices:
- My laptop 'ewilan',
- My two external hard-drives, 'shae' and, uh it does not have a name except 'TOSHIBA',
- My server 'klafyvel.me', that has some various backups and hosts my emails,
- My phone (an android),
- Some old broken android phone where I have pictures I'd like to salvage someday,
- an iPad I won at a hackathon that I do not use a lot, but still.

Most of the things are on ewilan and the two hard drives, and those are what I'll focus on first. 

# Merging the two drives

Because of the limited available disk space on my laptop, I've been chaotically moving stuff to those drives. In principle, things should be duplicated on these two... but I've been doing it by hand, and it's a mess. I've been doing some cleanup on the TOSHIBA hard drive, because I use it less than shae, and removed as many things I could (movies I'd already watched, useless old projects...).

Next, I needed to actually decide what to do with the remaining file: copying them if they were not already on shae, ignoring them otherwise. I am sure there are plenty of smart Linux commands to do that, but I'm dumb and lazy, so I wrote [a Julia script]() to do it the way I want. Essentially: 
- it copies a file if the corresponding file does not exist on the target,
- it does not copy a file whose path already exists on the target, but whose content is identical
- it copies to a renamed path files that are redundant but different,
- it outputs a CSV file that tells me what it did (or plans to do if running in dry mode),
- it can use the output of a dry run to actually move the files, which means I can have a look at what it's going to do before breaking everything.

Thanks to [ProgressMeter.jl](https://github.com/timholy/ProgressMeter.jl) I also have nice outputs.
```bash
✓ Indexing /run/media/klafyvel/TOSHIBA EXT/Vidéos files...    Time: 0:00:01
◑ Processing files...    Time: 0:01:25
  decision:  keep
  file:      TPS/interviews/son/MONO-021.wav
  reason:    Same file at same location
```

The process is quite long, so grab a book if you're gonna use the script. For my video folder, it took 42 minutes. The nice thing with having a CSV file outputed is I can have some statistics, who doesn't like statistics? And here you can see that indeed, I had a lot of duplicated stuff in my video folder:
```
 Row │ decision  count
     │ String7   Int64
─────┼─────────────────
   1 │ keep       2646
   2 │ copy          2
   3 │ ignore        1
```
