graphictablet #2
################
:date: 2011-07-11 00:42
:tags: de, fixed, hardware, reverse engineering, tablet, ud-1218-R, wacom

Der heutige Sonntag war ganz im Sinne des Tablets. Endlich hatte ich
Zeit und Ruhe mich damit zu beschäftigen. Das erste war aufschrauben und
reinschauen, was es zu entdecken gibt. Derzeit liegt das ganze so auf
meinem Schreibtisch:

|Arbeitsplatz|

Es ist schon riesig und findet
auf meinem Schreibtisch kaum Platz, aber vielleicht behalte ich es eh
nicht und verschenkes oder verkaufe es. Von einem Netzanschluss war auf
dem Controlboard keine Spur,w as mir ein wenig Sorgen bereitete. Ich
fand zwar raus, dass die beiden Kupferteile wohl Ground sein sollen,
aber wo jetzt tatsächlich der Stromanschluss ist...guuute frage. 

|Wacom Controler|

Es gibt einen Ein-Aus-Schalter, aber das ist auch das
Einzige was ich so gleich sehe, was mit Strom zu tun hat. Ohne näheres
Googeln finde ich die Bauteile nicht raus. Aber es sieht nichts nach
einem Stromanschluss aus. Demzufolge muss der Strom ueber den Seriellen
Port kommen. Mir sind beim suchen im Internet auch Kabel aufgefallen,
die eine Art Y-Form haben und demnzufolge auch einen Netzstecker
zulassen (sehr komische Art, aber naja). Ich wollte nicht selber an der
Platine rumbasteln, weil ich mir nicht sicher war, ob ich nicht etwas
durchbrenne oder kaputt mache. Also hab ich ein wenig im Netz gesucht
und bin auf ein Interressantes Forum gestossen: `forum.bongofish.co.uk`_
Die basteln aus Wacom Tablets und LCD Bildschirmen voll funktionierende
"Bildschirmtablets" (mir fällt grad kein anderer Name ein). Zumindest
haben die auch Schematics, so habe ich gehofft. Und wiederum nach wälzen
von Threads und Posts bin ich auf eine Interressante Grafik gestolpert:
|Pin Schematics| 
(Quelle: `forum.bongofish.co.uk/index.php?topic=316.0`_) Die Grafik gibt es auch
noch in Englisch, aber nunja, es sollte eigentlich relativ verständlich
sein. Theoretisch und Praktisch wird hier beschrieben aus einem ADB
seriellen Anschluss ein Y-Kabel zusammenzubasteln, dass normale 9Pin
Serielle Anschluesse hat. Ich war mir zunächst unsicher, ob mein Tablet
ein ADB ist, aber nachdem ich keinen Anschluss gesehen habe, bin ich von
einer wagen Vermutung ausgegangen und wollte es einfach probieren. Da
ich keinen Lötzinn zur Hand hatte und meine Schrumpfschlauch und
Isolierband auch relativ knapp sind, habe ich kurzerhand Tesafilm
genommen. Rausgekommen ist das hier: 

|Y-Kabel|

Ich weiss, dass es
nicht gerade die feine Art ist, aber ich hatte nunmal nichts anderes zu
Hand. "Rot-Blau" ist die Positive Ader. Schwarz ist negativ. Der Rest
ist nach dem Bild zusammengemanscht. Nachdem das Tablet ein Netzteil
mit: 9-12V, 0.14A möchte, hab ich zunächst auf USB zurückgegriffen. Aber
da war die Spannung mit seinen 5V einfach zu gering. Das nächstbeste
Netzteil das ich finden konnte ist: 7.5V mit 1A. Ich bin über das Ampere
ein wenig am Grübeln, aber solange ich nichts besseres habe, werde ich
erstmal mit dem Testen müssen. Und was will man sagen...die LED hat
geleuchtet. 

|LED - Tablet|

Der Ein-Aus-Schalter am Controlerboard hat
wohl einen Wackler. Wenn ich ihn anlange, geht die LED aus und das ganze
kriegt keinen Strom mehr. Sieht danach aus, als müsste ich den Schalter
ausbauen. Zudem bin ich inzwischen über einen Hack gestolpert, um das
UD-1218-R Tablet als ein Anderes über USB ausgeben zu lassen. Das würde
bedeuten, es wäre unter Windows7 Problemlos verwendbar. Gibt aber
angeblich noch ein paar Softwareprobleme ab und an. Vielleicht werd ich
mir das mal anschauen in näherer Zukunft. Erstmal warte ich auf einen
Stift, den ich am Wochenende von meinem lieben Bruder gestellt kriege.
Dann werde ich über weitere Tests schreiben :) Und ich brauch auf jeden
Fall eine 3. Hand zum löten und rumbauen...mit den vielen Kabeln geht
das sowas von auf den Geist :-/ so long

.. _|image5|: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/arbeitsplatz.jpg
.. _|image6|: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/controler.jpg
.. _forum.bongofish.co.uk: http://forum.bongofish.co.uk/
.. _|image7|: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/schema_cavo_tavoletta.jpg
.. _forum.bongofish.co.uk/index.php?topic=316.0: http://forum.bongofish.co.uk/index.php?topic=316.0
.. _|image8|: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/verbindung.jpg
.. _|image9|: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/led.jpg

.. |Arbeitsplatz| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/arbeitsplatz-300x199.jpg
.. |Wacom Controler| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/controler-300x199.jpg
.. |Pin Schematics| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/schema_cavo_tavoletta-300x283.jpg
.. |Y-Kabel| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/verbindung-300x199.jpg
.. |LED - Tablet| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/led-300x199.jpg
.. |image5| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/arbeitsplatz-300x199.jpg
.. |image6| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/controler-300x199.jpg
.. |image7| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/schema_cavo_tavoletta-300x283.jpg
.. |image8| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/verbindung-300x199.jpg
.. |image9| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/07/led-300x199.jpg
