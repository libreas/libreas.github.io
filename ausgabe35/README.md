# ausgabe35
Neutralität


# Vorarbeiten

* Pandoc aktualisieren
* neuen Ordner pro Artikel anlegen (Ordnername: idR Nachname Erstautor)
* ggf. Unterordner `img` anlegen und dort Abbildungen speichern
* s. auch [Zusatzinfos Satz](https://github.com/libreas/libreas.github.io/wiki/Zusatzinfos-Satz)

# Markdown-Datei erstellen (Artikel)

```
pandoc -s master.docx -t markdown -o master.md
```

Markdown nachbearbeiten:

* löschen: `—-- title stuff —--`
* Anführungszeichen: (single + double) 'smart quotes' mit 'normalen' Anführungszeichen ersetzen
* Links zu Abb. editieren

# Metadaten / Zusatzdateien

`meta.yaml` + `meta.tex` von anderem Artikel kopieren + bearbeiten (author, title, issue no, ...)

Zusatzdateien anlegen (s. Workflow-Dokument pro Ausgabe) und konvertieren:
```
pandoc vita.md -o vita.tex
pandoc vita.md -o vita.html

pandoc abstract.md -o abstract.tex
```

# Latex/PDF

```
pandoc --template=../header.sty --include-in-header=meta.tex --include-before=abstract.tex --include-after=vita.tex -N --toc master.md -o master.tex
```

Überschriftenebene anpassen:
```
sed -i.bak 's/subsubsection*/section*/g' master.tex
```

PDF kompilieren:
```
pdflatex master.tex
```

PDF prüfen: Werden alle Bilder korrekt dargestellt? Tabellen ok? Muss bei Umbrüchen manuell nachgeholfen werden?

# HTML erstellen

```
pandoc --include-before=meta.yaml --include-after=vita.html --html-q-tags --toc master.md -o index.html
```

* we do not need head or closing tags (check prior index.html to make sure you delete all necessary parts)
*  manually before compiling with Jekyll

HTML nachbearbeiten: 

* head / closing tags löschen (alles bis `---`und `</body></html>`
* index.html sollte mit `---` beginnen (keine Leerzeile!)

# HTML kompilieren

Dateien erstellen:

`bundle exec rake generate`

Vorschau generieren:

`bundle exec rake preview`

Preview in Browser (URL-Struktur z.B. `localhost:4000/ausgabe34/editorial`): sieht Artikel so ok aus?

# in Git-Repo ablegen

vor Push ins Git-Repo letztes Mal nachdenken/prüfen:

* Metadaten vollständig und korrekt, wirklich? (Schreibweise Titel, Autor*innen!)
* index.html korrekt nachbearbeitet?
* sieht PDF ok aus?

dann mal los:

```
$ git add .
$ git commit -m "useful commit message"
$ git pull origin master
$ git push origin master
```