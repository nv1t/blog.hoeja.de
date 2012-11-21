Ueberall Chaos...
#################
:date: 2012-03-13 10:14
:tags: de, fake, mathematics, random

Ich bin vor einiger Zeit ueber einen Artikel gestolpert, der Chaos in
der Mathematik beschrieb. Sie demonstrierten anhand einer einfachen
Funktion mit einer Minimalen Aenderung des Ausgangswerts riese
Veraenderungen rauskamen nach einige Durchlaeufen. Stellen wir uns mal
die Funktion vor: $$c\_{n+1} = c\_n^2-2$$

0.5
0.5000000000001

 .. code-block :: plain

    -1.75
     1.0625
    -0.87109375
    -1.24119567871
    -0.459433287149
    -1.78892105466
     1.2002385398
    -0.559427447572
    -1.6870409309
     0.846107102544
    -1.28410277103
    -0.351080073445
    -1.87674278203
     1.5221634699
     0.316981629099
    -1.89952264681
     1.60818628576
     0.586263129697
    -1.65629554276
     0.743314924959
    -1.44748292233
     0.0952068104469
    -1.99093566324
     1.96382481518
     1.85660790471
     1.44699291184
     0.0937884869186
    -1.99120371972
     1.96489225343
     1.8608015676
     1.46258247398
     0.139147493204

 .. code-block :: plain

    -1.75
     1.0625
    -0.871093750001
    -1.24119567871
    -0.459433287153
    -1.78892105466
     1.20023853979
    -0.559427447597
    -1.68704093088
     0.846107102448
    -1.28410277119
    -0.351080073029
    -1.87674278232
     1.522163471
     0.31698163244
    -1.8995226447
     1.60818627771
     0.58626310382
    -1.6562955731
     0.743315025468
    -1.44748277291
     0.0952063778795
    -1.99093574561
     1.96382514315
     1.85660919288
     1.44699769507
     0.0938023295368
    -1.99120112297
     1.96488191213
     1.86076092862
     1.46243123347
     0.138705112641

Bei einer minimalen Veraenderung des Seedes faellt das relativ schnell
ins Gewicht. Ich habe das mal versucht zu plotten mit 0.5 und 0.501:

|fake-0.5|

|fake-0.501|

Wenn man es mit einem
Bild aus einem Random Number Generator aus Python vergleicht:

|real|

erkennt man garnicht soooviel
unterschied :) Die Frage ist nun, wie generiert man den Seed...aus der
Zeit? Das Problem hatten wir ja schon bei RFID Chips :) Aber Zeit
scheint noch die beste Idee zu sein. Sieht zumindest relativ angenehm
aus. Ich betrachte in diesem Punkt 2 Statii. d.h. ich schau nicht
welchen Wert der genau ist, sondern mache nur eine: Ist er Plus oder
Minus. aber seht selbst: https://github.com/nv1t/Fakerandom/ so long

.. |fake-0.5| image:: http://images.hoeja.de/blog/fake-0.5.png
.. |fake-0.501| image:: http://images.hoeja.de/blog/fake-0.501.png
.. |real| image:: http://images.hoeja.de/blog/real.png
