# ausgabe34
Artikelrepo Ausgabe #34 – 90 Jahre Bibliotheks*wissenschaft in Berlin

CfP https://libreas.wordpress.com/2018/03/21/call-for-papers-34-90-jahre-bibliothekswissenschaft-in-berlin/

# Workflow

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
pandoc --template=../header.sty --include-in-header=meta.tex  --include-after=vita.tex -N master.md -o master.tex
```

Control sections

```
sed -i.bak 's/subsubsection/section/g' master.tex
sed -i.bak 's/paragraph/subsection/g' master.tex

```
and compile

```
pdflatex master.tex
```

Create html

```
pandoc --include-before=meta.yaml --include-after=vita.html --html-q-tags --toc master.md -o index.html
```

Delete head manually before comiling with Jekyll.
