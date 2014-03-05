# libreas test repository

```

$ textutil -convert html Beitrag_Haas_Rusch_final.doc -stdout | pandoc -f html -t markdown -o master.md

$ pandoc --template=header.sty --include-before=meta.tex  --include-after=abstractTex.tex master.md -o master.tex

```
