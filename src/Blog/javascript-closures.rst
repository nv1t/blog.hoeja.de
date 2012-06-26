Javascript Closures
###################
:date: 2011-10-14 12:52
:tags: bashing, de, fixed, javascript

Ich hab letztes Wochenende intensiv an einem JavaScript Projekt fuer
eine Freundin gearbeitet. Es ging um Schattenwurf und Optik fuer die
Schule am Computer aufbereitet. Im Zuge dessen hatte ich mich in
JSXGraph eingelesen und bin ziemlich begeistert davon. Es ist intuitiv
und schnell, wobei einige Sachen nicht dokumentiert sind. Heute hatte
ich wegen einem Bug und ein paar andere Frage bezueglich des Codes ein
Gespraech mit einem Entwickler. Ein Fehler mit dem ich schon etwas
laenger rumkaempfe beruht garnicht auf JSXGraph, sondern auf Javascript
selber. Stellen wir uns folgenden Fall vor:

::

    funs = [];
    for(i = 0; i < 10; i++) {
       funs.push(function() { 
          return i;
       });
    }
    alert(funs[3]());

Das ganze ist recht straightforward. Wir schreiben Funktionen in ein
Array und wollen dann spaeter den Wert ausgeben. Aber das geht nicht so
einfach. Er wird 10 zurueckliefern. Zum Glueck hatte er gleich eine
Loesung parat:

::

    funs = [];
    for(i = 0; i < 10; i++) {
       funs.push(
           (function (_i) {
               return function () {
                   return _i;
               };
           })(i)
       );
    }
    alert(funs[3]());

Das ist die korrekte Schreibweise. Macht euch nur drueber lustig...ich
fand es auch ein wenig over the top. Wenn die anonyme Funktion
aufgerufen wird, benutzen sie immer die gleiche einzelne Closure und es
wird der aktuelle Wert von i verwendet. Deswegen braucht man ein Closure
um das Closure, vorallem eine 2. Variable \_i :) Javascript is a bitch!
:P so long
