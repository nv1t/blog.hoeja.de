nifty feature of http_build_request in PHP
##########################################
:date: 2012-01-18 15:43
:tags: de, php

Ich habe heute lange an einem Problem gebastelt, was sich am Ende als
recht leicht herrausgestellt hat, wenn man die richtigen Funktionen
kennt. Ich denke jeder hatte mal das Problem, dass er ein assoziatives
Array hat und daraus eine beliebige Ausgabe erstellen wollte, in der
Form: "a=1, b=2" oder aehnlich. Das geht eigentlich recht einfach mit
einer einfachen foreach Schleife, aber das wollte ich nicht, weil ich es
direkt in die Ausgabe pipen wollte. Meine naechste Ueberlegung war mit
einem doppelte array\_map, was aber ein Problem aufwirft: man kann den
key nicht uebergeben bei PHP. Also doch zurueck zu foreach? NEIN! Es
gibt eine kleine Funktion namens `http\_build\_request`_. Diese ist
sogar so veraenderbar, dass man fast alles damit machen kann. Leider hat
sie einen kleinen Nachteil: sie codiert die Ausgabe fuer http
Uebergaben. Aber auch dies ist kein Problem:

::

     1,
        "b" => 2
    );

    print urldecode(http_build_query($arr, '', ', '));

    // Ausgabe:
    // "a=1, b=2"

Natuerlich kann damit noch viel mehr erreicht werden. Ich wuensch euch
viel spass :) solong

.. _http\_build\_request: http://php.net/http_build_request
