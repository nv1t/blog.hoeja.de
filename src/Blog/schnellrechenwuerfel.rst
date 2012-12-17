Wuerfel, sie zu knechten...
###########################
:date: 2012-12-17 14:16
:tags: bugs, de, exploits, javascript, reverse engineering


.. container:: float-left

    .. figure:: http://images.hoeja.de/blog/schnellrechenwuerfel.jpg
        :height: 200px
        :alt: Schnellrechenwuerfel

...sie alle zu finden, ins Dunkel zu treiben und ewig zu binden!
----------------------------------------------------------------

.. container:: clear

    .. figure:: http://images.hoeja.de/blog/1x1.png


Jedes Jahr geh ich auf dem Weihnachtsmarkt an einen bestimmten Stand. Das Holzspielzeug ist
phantastisch und die Raetsel sind klasse. Dieses Jahr hatte Sie nur Wuerfel, die man moeglichst
schnell addieren muss.

Mag am Anfang ein wenig langweilig klingen, aber wenn man sich ein wenig fuer die Mathematik
dahinter interessiert wird es ploetzlich ziemlich interessant und wir haben einen kompletten
Samstagabend damit verbracht eigene Wuerfel zu bauen, bzw. die Vorhandenen zu Beweisen.

Wer den Trick nicht wissen moechte, einfach nicht weiterlesen, nachdem ich Versuchen werde den hier 
Mathematisch zu Beweisen :)

Herleitung der Schnellrechenformel
----------------------------------

Was sieht man, wenn man sich die Wuerfel genauer anscheint. Picken wir uns 2 Stueck raus:

 .. code-block :: plain

    W1  W2  W3  W4  W5
    186 366 855 147 179
    285 168 657 345 278
    780 960 459 147 377
    384 564 954 642 872
    681 762 756 543 971
    483 663 558 840 773

Jetzt sollte einem schon ein paar Kleinigkeiten auffallen an den beiden Wuerfeln.
Die 10er Stelle ist konstant, und die Quersumme ist immer die Gleiche. Das bedeutet, dass 
die Summe aus 100er und 1er Stelle konstant ist. Auf einem Wuerfel versteht sich.

Demzufolge koennen wir eine Zahl aus nur 1ner Ziffer aufbauen.
Eine Zahl ist allgemein gesagt: $$100*a+10*b+c$$
Mit unserem Wissen koennen wir das mit $b = k_{12}$ und $a = (k_{11}-c_1)$ nun umformen in: 
$$100*(k_{11} - c_1)+k_{12}+c_1 = 100*k_{11}+k_{12}-99c_1$$

Nun haben wir eine Zahl bestimmt. Wir wollen aber die Summe der Zahlen, also:
$$\\sum (100*k_{i1}+k_{i2}-99c_i) = 100*\\sum k_{i1} + \\sum k_{i2} - 99*\\sum c_i$$
Da wir die Summen der Konstanten ausrechnen koennen, indem wir alle Wuerfel zu Rate ziehen kriegen wir als
Berechnungsvorschrift folgende Formel:
$$100*47 + 300 - 99*\\sum c_i = 5000 - 99*\\sum c_i$$
Nachdem man das nicht wirklich im Kopf ausrechnen kann, vereinfachen wir die Gleichung auf:
$$100*50 - 99*\\sum c_i = 50+99*50 - 99*\\sum c_i = 50 + 99(50-\\sum c_i)$$
Hier muessen wir aber immer noch mit 99 multiplizieren. Das ist einfach nicht schoen.

Wir koennen aber einen kleinen Trick anwenden, denn $50 = \\sum c_i + 50 - \\sum c_i$ und jetzt
setzt man das wiederrum in unsere Gleichung ein und kommt auf:
$$ \\sum c_i + (50 - \\sum c_i) + 99*(50-\\sum c_i) = \\sum c_i + 100*(50-\\sum c_i)$$

Fuer MatheLaien
---------------

Um den Trick nochmal fuer Mathe Laien zu erklaeren: Man nehme die Einer, addiere sie zusammen. Damit hat man
schonmal die 10er und 1er Stellen der neue Zahl. 

Daraufhin nimmt man 50-(die Zahl) und bekommt die 100er und 1000er Stelle raus.


Warum aber so kompliziert beweisen?
-----------------------------------

Man kann sich jetzt ueberlegen, was passieren wuerde, wenn ich 2 Sets dieser Wuerfel verwende.
Das ist noch eine der leichtesten Uebungen, denn, ueberlegen wir uns, was mit den Konstanten passiert, da diese
der Entscheidende Knackpunkt fuer diese ganze "Zauberei" sind.

Beide werden sich einfach verdoppeln, dementsprechend muss die Formel angepasst werden auf:
$$\\sum c_i + 100*(100-\\sum c_i)$$
Und schon funktioniert der Trick wieder.

Wir koennen auch Beispielsweise einen eigenen Wuerfel hinzufuegen, was sich aber komplizierter erweist, um dann wieder auf eine
ordentliche Berechnungsvorschrift zu kommen um das ganze wieder im Kopf zu berechnen.
Aber um mal die Vorgehensweise zu erklaeren:

 .. code-block :: plain

    Wir suchen uns eine coole Zahl fuer b und die Quersumme aus, nehmen diese wieder in die Konstanten auf und berechnen unsere neue
    Formel. Tada. Wir haben den Trick erweitert.

Ich wuensche euch viel Spass mit diesem Mathematischen Spiel und Spass und Huepferei in Pfuetze.

so long


.. |wuerfel| image:: http://images.hoeja.de/blog/schnellrechenwuerfel.jpg
