Fileserve Liste und Bash
########################
:date: 2011-12-01 01:20
:tags: bash, de

Heute stand ich vor einem interessanten Problem. Ich hatte eine
Fileserve-List mit einigen hundert Links und ich wollte eigentlich nur
die Direktlinks fuer plowdown rausfiltern. Ein Skript schreiben ist ein
wenig wie mit Kanonen auf Spatzen zu schiessen und nachdem ich mich
langsam an sed gewoehnt habe, dachte ich mir, dass sich das problem auch
recht gut damit loesen laesst.

::

    list="http://fileserve.com/list/..."; # link zur liste
    for i in `curl -s "$list"
    | grep '

    Das ist dabei herrausgekommen. Er laedt die Seite mit curl, piped sie durch grep, welche alle Links rausfiltert. sed erledigt den Job nur die ID herrauszufiltern. Am Ende wird noch ein fileserve.com angefuegt, um es fuer plowdown richtig zu machen.
    Das kann man natuerlich noch mit

    echo "http://fileserve.com${i}" >> output;

noch in eine Datei pipen. so long edit: Einfacher geht es uebrigens,
wenn man einfach plowlist verwendet :-/ wie ich spaeter rausgefunden
habe..ein typisches fail
