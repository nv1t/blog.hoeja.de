postfix und ich #1
##################
:date: 2011-11-15 15:32
:tags: de, logfile, postfix, python

Derzeit schreibe ich an einer kleinen Applikation, die es Ermoeglichen
soll auch im grossen Rahmen sich Postfix Logfiles in Echtzeit
anzuzeigen. Ich habe noch niemals so ein wirres Logfile Format
gelesen...nie nie nie nie!!!! Es tauchen disconnects auf, bevor es zu
einem connect kam. Es werden "," als Trenner eingesetzt, aber im
gleichen Atemzug in Klammern verwendet. Ich sass grad 1h ueber einem
Problem, dass ich erst dadurch bemerkt habe:

::

    0C3916091: to=, relay=relay.de[0.0.0.0]:25, delay=0.95, delays=0.44/0/0.11/0.4, dsn=2.0.0, status=sent (250 Requested mail action okay, completed.)

naa....wer sieht den Fehler! Genau...ich trenne anhand von ", " ... und
im letzten Teil taucht das in der Klammer auf...an so was denkt man doch
nich :-/ Der Grund warum ich mich ueberhaupt hingesetzt habe: die
Komplette Datei zu parsen von 1ner Woche dauert 40 sekunden und umfasst
200.000 Zeilen. Rechnen wir das ganze mal auf einen Monat hoch, weil der
Server Monthly Rotations hat. Ich hoffe, dass ich den Kampf ueberlebe.
so long
