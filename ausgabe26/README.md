text repository libreas #26

*Workflow*

Convert `docx` into `markdown`document.

```
pandoc -s master.docx -t markdown -o master.md
```

Add metadata files and convert

```
pandoc vita.md -o vita.tex
pandoc vita.md -o vita.html

pandoc abstract.md -o abstract.tex
```

Create `tex`

```
pandoc --template=../header.sty --include-in-header=meta.tex  --smart --include-before=abstract.tex --include-after=vita.tex -N  --toc master.md -o master.tex
```

Control sections

```
sed -i.bak 's/subsubsection*/section*/g' master.tex
```
and compile

```
pdflatex master.tex
```

Create html

```
pandoc -S --include-before=meta.yaml --include-after=vita.html --html-q-tags --toc master.md -o index.html
```

Delete head manually before comiling with Jekyll.