# QmdReport.

**Background**: A little background. I am not trying to do this for a specific report and I have a lot of experience creating big complex government reports with R Markdown. But right now our packages that the produce reports are all customized and a massive amount of work to create, e.g. https://github.com/EmilyMarkowitz-NOAA/NMFSReports. It looks like switching to Quarto is going to take care of the custom stuff that we had to write for NMFSReports, but I need to be able to control of the title page in html, Word and PDF. 

If I demo a Quarto report and have to hack hard to make a title page, then the response will be "that's a non-starter. you're saying we need a computer programmer just to be able to make a title page for our report?? um, no. let's stick with the current tools (Word)." That's what we are facing when we try to transition to R Markdown reports; it's just requires too much technical skill to do things that are simple in Word.

Quarto solves a lot of that. Last piece is the title page and copyright page. If I could just a basic title page get across HTML, Word and PDF without hacking that'd be huge. If I could edit that title page and its layout with the visual editor too!! Well, one can dream.

## July 30 22 update

I hacked the index.qmd yaml to make what looks like a title page using the `subtitle:`. But now PDF and Word won't build. Word says it can't find the image file even though it finds it fine when the image is in the main text.

I spend the day also playing with [quarto](https://github.com/quarto-journals) for making templates. I don't think that's the way forward. I struggled to make sense of the structure. Given my experience with LaTeX books, R Markdown Hugo blogs, html, css, etc, I can usually makes sense of templates with a bit of poking around the repo and start creating my own. 

The way they approached the title page design struck me as completely foreign coming from a LaTeX background and would require me to duplicate decades of LaTeX document class work (in the LaTeX community). There is a standard way to specify title pages (along with copyright pages etc) and to specify the parameters that go in: a document class definition and a redefinition of the `\maketitle` command along with parameters (that would presumably come in from the `_quarto.yml`). All I need is ablitity to freely define parameters in the yaml (e.g. `publishers`) AND the ability to control the LaTeX that is coming before `\mainmatter` in the document.  That's it. Then all the existing LaTeX document classes would work seamlessly.

Re Word, I didn't dig too deep. I need to find out how they are creating Word docs. Is it strictly pandoc or is {officerdown} helping out? If the latter, then I can hack (ug so tired of hacks) a title page.

Other things that are hard

* pandoc is not respecting `{.nolisting}` on the `index.qmd` for HTML output. So `# titlepage {.nonumbering .nolisting}` should work to for a title page without the first chapter starting on the html title page without `titlepage` appearing in the TOC. But `{.nolisting}` is only working on pages after `index.qmd`.

* My hack to get control of the front page for HTML output by hacking the `subtitle:` block breaks both Word and PDF output. :(
