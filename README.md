# QmdReport.

[A demo a Quarto report live view](https://rverse-tutorials.github.io/QmdReport/)

## Aug 6 22 update

I presented QmdReport at the last RWorkflow workshop. I'd made a lot of progress but many things were not working still. I made a bunch of updates and cleaned things up.

* After fighting to try to get tables to look ok using one table engine, I have up and wrote some helper functions in `tables/_common.R` to select the best engine for LaTeX versus Word/HTML.
* flextable cross-refs don't work in pdf but kableExtra tables work and look better in some ways. So I use kableExtra for pdf's.
* flextable is by far best for Word but cross-refs are broken. The Quarto dev team knows about the problem.
* I worked out how to use child Rmds.
* I put tables separate from figures.
* I tried using `quarto publish gh-pages` but I had to (or it seemed easier that) install pandoc to my bin instead of where RStudio has it. And then all the cross-ref links worked by showed "unresolved" and didn't look right. Turns out Quarto breaks with pandoc 2.19, so I have to figure out how to uninstall pandoc so RStudio goes back to using the old version.

## Aug 5 22 update

The title page work is living here at the moment: https://github.com/nmfs-opensci/quarto_titlepages

## Aug 2 22 update

I see a path forward (for HTML at least)! I can pass in `page-layout: custom` and use `::: ` to add the content in the right places. https://github.com/quarto-dev/quarto-web/blob/main/index.qmd
But I still don't know how to get any control over the page.

## July 30 22 update

I hacked the index.qmd yaml to make what looks like a title page using the `subtitle:`. But now PDF and Word won't build. Word says it can't find the image file even though it finds it fine when the image is in the main text.

I spend the day also playing with [quarto](https://github.com/quarto-journals) for making templates. I don't think that's the way forward. I struggled to make sense of the structure. Given my experience with LaTeX books, R Markdown Hugo blogs, html, css, etc, I can usually makes sense of templates with a bit of poking around the repo and start creating my own. 

The way they approached the title page design struck me as completely foreign coming from a LaTeX background and would require me to duplicate decades of LaTeX document class work (in the LaTeX community). There is a standard way to specify title pages (along with copyright pages etc) and to specify the parameters that go in: a document class definition and a redefinition of the `\maketitle` command along with parameters (that would presumably come in from the `_quarto.yml`). All I need is ablitity to freely define parameters in the yaml (e.g. `publishers`) AND the ability to control the LaTeX that is coming before `\mainmatter` in the document.  That's it. Then all the existing LaTeX document classes would work seamlessly.

Re Word, I didn't dig too deep. I need to find out how they are creating Word docs. Is it strictly pandoc or is {officerdown} helping out? If the latter, then I can hack (ug so tired of hacks) a title page.

Other things that are hard

* pandoc is not respecting `{.nolisting}` on the `index.qmd` for HTML output. So `# titlepage {.nonumbering .nolisting}` should work to for a title page without the first chapter starting on the html title page without `titlepage` appearing in the TOC. But `{.nolisting}` is only working on pages after `index.qmd`.

* My hack to get control of the front page for HTML output by hacking the `subtitle:` block breaks both Word and PDF output. :(
