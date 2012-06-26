Sieb des Eratosthenes
#####################
:date: 2011-07-14 09:24
:tags: de, maple, mathematics, numerics

Wir sollten die Wochen in der Uni das Sieb des Eratosthenes in Maple
nachprogrammieren. Nach ein bisschen ueberlegen bin ich auf eine recht
nette Loesung gestossen, die insgesamt 3 Zeilen umfasst :)

::

    n := 100;
    M := {`$`(2 .. n)};
    for j in `$`(2 .. trunc(sqrt(n))) do 
        M := `minus`(M, {seq(i, i = 2*j .. n, j)}) 
    od;

Am Ende ist M die Menge aller Primzahlen im Bereich 2..n. so long
