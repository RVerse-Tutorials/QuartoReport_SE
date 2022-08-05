# QmdReport.

A demo a Quarto report

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
