tar it, untar it, break it
##########################
:date: 2012-04-15 17:03
:tags: bash, break, de

Wir hatten das seltsame Phaenomen, dass ploetzlich eine Website
nichtmehr ging. Nach suchen im Quelltext, Abfragen der SQL Datenbank per
Hand und endlos vielen Logssichtungen ist uns etwas seltsames
aufgefallen: Das /tmp Verzeichnis gehoerte einem ominoesem User und
hatte seltsame Rechte. Wir konnten uns dies zuanfangs nicht Erklaeren,
bis uns jemand gesagt hat er habe darin eine tar entpackt hat. Nachdem
wir uns die tar angeschaut haben, war relativ klar, was passiert ist.
Aber erstmal ein Bild, vielleicht kommt ihr selber drauf: 

|image0|

Eigentlich sollte jetzt schon klar sein was passiert. Im Archiv
restore.tar ist ./ gepackt. Natuerlich hat dieses ./ andere Rechte und
versucht sie dementsprechend anzupassen. Zuerst dachten wir uns, dass
das ein Bug sei. Aber wenn man laenger drueber nachdenkt: Expected
Behaviour! Was fuer Moeglichkeiten gibt es nun: die eine waere ein
Unterverzeichnis tiefer zu gehen und darein zu entpacken. Die andere
Moeglichkeit ist ./ zu loeschen:

 .. code-block :: bash

    tar --delete --no-recursion -f restore.tar ./

Natuerlich alles nicht so prickelnd. Man sollte lieber beim Packen
aufpassen nicht ./ sondern ./\* zu packen. Vor ungefaehr ewig wurde
sogar in Debian ein Bug Report eingeschickt:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=605425 Der das Problem
naeher beschreibt. Aber wie schon gesagt, ist das in meinen Augen kein
Bug. so long

.. _|image1|: http://images.hoeja.de/blog/nvr.png

.. |image0| image:: http://images.hoeja.de/blog/nvr-300x175.png
.. |image1| image:: http://images.hoeja.de/blog/nvr-300x175.png
