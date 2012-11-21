[bash] Pizzatimer
#################
:date: 2012-04-02 06:45
:tags: bash, de

Eigentlich ist es ja nicht der Rede wert, aber wir mir ein wenig
langweilig und nachdem ich von `@BakeRolls`_ den PizzaTimer in Java
gesehen habe, dachte ich mir, dass sich das doch sicher auch als
Oneliner in Bash umsetzen laesst :)

 .. code-block :: bash

    sec=$1; 
    while [ $sec -gt 0 ]; do 
        echo -en "\r${sec}";
        sec=$(($sec-1));
        sleep 1; 
    done;

Danach kann mplayer oder aplay oder aehnliches gesetzt werden um den Ton
abzuspielen :) Hatte nicht die Identischen Funktionalitaeten, aber als
einfacher Timer, sollte es reichen...wobei ich eher ein: sleep
$sec;mplayer verwende :D aber jedem das seine ;) Ist ganz nett, aber
wirklich nicht der Rede wert. Vielleicht fuer jemand, der sich nicht so
gut in Bash auskennt und mal sehen moechte, wie man Rechnet, oder mir
\\r arbeitet :) so long

.. _@BakeRolls: http://twitter.com/BakeRolls
