JOIN, y u so slow?!
###################
:date: 2012-03-08 04:16
:tags: benchmark, de, sql

Ich sass heute den ganzen Arbeitstag an einem SQL Query. Ich habe schon
lange nichtmehr soviele Produktives ueber SQL gelernt, wie der gestrige
Tag. Moechte euch jetzt einige interessante Ergebnisse zeigen. Spaeter
fueg ich noch ein paar Messergebnisse dazu, aber die grosse Datenbank
liegt auf der Arbeit.

Problem:
--------

Ich hab 1ne Datenbank in der die geparste Postfix Log liegt. Diese
Datenbank ist in einer Art "Key:Value" Storage angelegt um die Arbeit
damit ein wenig zu erleichtern. Das bedeutet, dass im Feld "message" die
Daten als JSON vorliegen und daher nicht wirklich von SQL verarbeitet
werden koennen. Dies wirft Probleme auf. Ich habe im Prinzip eine zum
Teil geparste Logfile. Der finale Status einer Mail wird ueber die
Intelligente Zusammenfuehrung der History gemacht. (Vielleicht geb ich
euch da mal die Klasse fuer, noch ist sie im Roh Zustand) Nunja, es
sollen nun aber beispielsweise alle Nachrichten angezeigt werden, die
"bounced" sind. Man moege meinen ein einfaches:

 .. code-block :: sql

    select mailid 
    from history 
    where message like "%bounced%" 
    group by mailid

wuerde ausreichen um alle mailids zu kriegen. Aber falsch gedacht. Das
sind alle Nachrichten, die jemals einen Status "bounced" hatten. Wenn
wir das nun einschraenken wollen: "bounced und nicht sent", dann kriegen
wir ein Problem, oder?

Hoere ich ein JOIN?
-------------------

Ich hoer euch schon schreien: "Das geht ueber ein LEFT JOIN". Das wurde
mir auch von den SQL-Gurus gesagt. Die Abfrage wuerde dann so lauten,
oder so aehnlich:

 .. code-block :: sql

    select aa.mailid 
    from history as aa 
    left join (
        select mailid 
        from history 
        where message like "%sent%" 
        group by mailid
    ) as ab 
    on (aa.mailid = ab.mailid) 
    where 
        (message like "%bounced%") and 
        ab.mailid is NULL 
    group by mailid

Wenn man nicht weiss, was JOIN genau macht, Wikipedia beschreibt es
Klasse mit Beispielen (`Wikipedia: Join\_(SQL)#Left\_outer\_join`_) Was
passiert hier eigentlich: Er nimmt die Liste der mailids die "bounced"
sind. Fuegt das ganze mit einem JOIN an der mailid zusammen, die "sent"
sind. Nachdem es ein LEFT OUTER JOIN ist, wird er die "bounced"-Liste
bevorzugen, d.h. wenn dazu kein equivalente mailid aus der "sent"-Liste
vorhanden ist, ist das Feld NULL. Wenn was Feld NULL ist, Filter ich das
ueber ein WHERE raus. Und dann mach ich die Liste der mailids noch
eindeutig. Das ist an sich nicht schlecht und funktioniert auch, wirft
aber Probleme auf, wenn man nach 2 oder 3 Elementen Limitieren will.
Wenn ich alle Nachrichten woellte, die "bounced" sind, nicht "sent" und
noch in der Mailqueue, also nicht "removed", saehe das so aus:

 .. code-block :: sql

    select aa.mailid 
    from history as aa 
    left join (
        select mailid 
        from history 
        where 
            message like "%sent%" or
            message like "%removed%" 
        group by mailid
    ) as ab 
    on (aa.mailid = ab.mailid) 
    where 
        (message like "%bounced%") and 
        ab.mailid is NULL 
    group by mailid;

Die Zeit betraegt dann aber um die 30-40 Sekunden und ist wirklich
nichtmehr zu verkraften.

Warum ist der Benchmark so unheimlich schlecht?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Das Problem ist das JOIN. Man muss es sich wie eine doppelte
For-Schleife vorstellen, der alle Eintraege miteinander vergleicht. Je
mehr Elemente er in einer der beiden Listen hat, desto laenger wird die
Laufzeit.

Any Solution
------------

Mir wurde auch die Funktion ANY ans Herz gelegt. Ja, sowas gibt es:

 .. code-block :: sql

    select mailid
    from history 
    where mailid=any(
        select from mailid 
        from history
        where (
            message like "%sent%" or
            message like "%removed%"
        )
        group by mailid 
    ) and message like "%bounced%";

Probiert es garnicht erst: das ist noch schlimmer als JOIN bei grossen
Datenmengen :)

Was jetzt?!?
~~~~~~~~~~~~

Ich suchte also Krampfhaft nach einer anderen Moeglichkeit. Bin endlos
mit Kaffee in der einen Hand und Stift drehend in der anderen durch die
Flure gewandert. Wir wissen, dass wir mit

 .. code-block :: sql

    select mailid 
    from history 
    where (
        message like "%sent%" or 
        message like "%removed%"
    ) 
    group by mailid

eine Liste aller mailids kriegen, die nicht in der 2. Liste

 .. code-block :: sql

    select mailid 
    from history 
    where message like "%bounced%"
    group by mailid;

enthalten sein duerfen. Wir muessen also irgendwie entscheiden, ob wir
da eindeutige Elemente drin haben. Theoretisch koennen wir beide Listen
zusammenschmeissen mit einem UNION und koennen darauf mithilfe eines
Subquerys ein GROUP BY anwenden

 .. code-block :: sql

    select mailid 
    from 
        (
            select mailid 
            from history 
            where (message like "%bounced%") 
            group by mailid
        ) union (
            select mailid 
            from history 
            where (message like "%sent%" or message like "%removed%") 
            group by mailid
        )
    as T
    group by mailid;

Damit haette ich eine eindeutige Liste von mailids die entweder bounced,
sent oder removed sind. Ich will aber eindeutige Elemente haben. Wir
wissen, dass wenn sie eindeutig sind, wird das Element ohne das GROUP BY
mehrfach auftreten. Gluecklicherweise bietet SQL eine HAVING Klausel und
ein COUNT an. Ein HAVING ist im Prinzip ein WHERE auf die Felder der
Ausgabe. Ziemlich praktisch, wenn man Sachen, die man ueber ein SUM()
oder so etwas berechnet hat, nochmal einschraenken moechte. Ich verwende
es hier um die doppelten Zeilen zu zaehlen und nur die mit
Zeilenanzahl=1 zurueckzugeben:

 .. code-block :: sql

    select mailid 
    from 
        (
            select mailid
            from history
            where (message like "%bounced%") 
            group by mailid
        ) union (
            select mailid 
            from history 
            where (message like "%sent%" or message like "%removed%") 
            group by mailid
        )
    as T
    group by mailid
    having count(*) = 1;

Womit ich eine Liste aller mailids, die nur 1mal auftreten. Nun haben
wir aber ein Problem, mit dem ich etwas laenger gekaempft habe! Ich kann
nicht sagen, ob die Nachricht nur in bounced, sent oder removed
Auftritt. Die Loesung meines Problems war eine Variable, die ich vor dem
UNION setze! :) Damit krieg ich ein weiteres Feld:

 .. code-block :: sql

    select mailid
    from 
        (
            select mailid,(@t:="1") as stat        
            from history
            where message like "%bounced%" 
            group by mailid
        ) union (
            select mailid,(@t:="0") as stat
            from history 
            where (
                message like "%sent%" or 
                message like "%removed%"
            ) 
            group by mailid
        )
    as T
    group by mailid
    having count(*) = 1 and stat="1";

Diese Abfrage ist bedeutend schneller, weil ich keine Vergleiche
anstell. Wer jetzt noch meckert, dass ich kein DISTINCT verwende und
stattdessen ein GROUP BY nehme: Ich habe das Gefuehl, dass GROUP BY
schneller ist und schon waehrend der Abfrage gruppiert, waehrend
DISTINCT erst vor der Ausgabe noch eine Art: "sort \| uniq"
drueberlaufen laesst, kann ich aber nicht direkt bestaetigen, ist nur so
ein Gefuehl. Ich denke der groesste Bremser in dem Query wird jetzt das
LIKE sein. Ich denke man kann es noch verschnellern, wenn man eine
andere Datenbank Struktur nimmt und das ordentlich im Vorfeld parsed.
Aber bin mit der Moeglichkeit nun eigentlich ziemlich zufrieden und
moechte die Erfahrung mit SQL nicht missen :) Auch moechte ich nicht
behaupten, dass meine endgueltige Loesung die beste ist. Wer eine andere
hat, oder eine noch bessere...immer her damit! :) so long

.. _`Wikipedia: Join\_(SQL)#Left\_outer\_join`: http://en.wikipedia.org/wiki/Join_(SQL)#Left_outer_join
