GPS on viliv x70
################
:date: 2011-05-08 05:27
:tags: de, gps, hardware, reverse engineering, viliv x70

Die letzten Tage hab ich das Web durchsucht und ueberall nachgefragt,
was ich nur finden konnte. Ich bin ueber einen ziemlich interressanten
Blog gestolpert (`Maik's Blog`_), der die GPS unterstuetzung fuer einen
huawei-em770w erklaert. Auch auf dem viliv sind die Ports zu
finden.

|Huawai Mobile Connect|

Die COM-Ports sind nur belegt, wenn
das Modem eingeschalten ist. Auf COM5 scheint ein GPS zu sein, welches
auch Daten zurueckgibt, wenn man es ueber den COM7, den Controlport
anschaltet. Wie man das genau tut, liest man im oben genannten Blog
nach. Doch die Daten, die zurueckgeliefert werden, sind fehlerhaft und
bessern sich mit der Zeit auch nicht. Es steht einfach nichts drin und
es werden keine Satelliten empfangen. Zuerst schob ich das Problem auf
das Gebaeude. Aber auch spaeter, als wir im Auto durch die Gegend
fuhren, empfingen wir nichts. Als ich mich vorhin mit dem Thema
beschaeftigt hab las ich einen Artikel. Viele GPS Programme greifen auf
COM1 oder COM2 zu . Zudem setzt NMEA als Standard 4800 baud. Die
Baudrate ist ziemlich uninterressant, weil ich die selber setzen kann
und in meinem Fall 9600 ist. Aber auf COM1 liegt ein Kommunikationsport.
Ich hielt den ich fuer ein Breakout Port fuer das viliv oder als Jtag
oder so in der Richtung. Vorallem weil COM5 Daten in NMEA form lieferte.
Trotzdem nervte mich COM1 und deshalb lies ich mal Putty drauf los, um
zu sehen, was wirklich darueber lief. Ploetzlich sprangen mir das NMEA
Protokoll ins Auge... 

|GPS COM1|

Auch hat er bereits Satelliten, aber
noch nicht genug fuer einen Fix, aber ich befand mich auch wieder in
einem Gebaeude. Solangsam versteh ich auch den Aufbau: Es existieren 2
GPS devices. Das eine ist das Huawei UMTS Modem. Das scheint aber keine
Sateliten zu empfangen, wobei ich hier auch ueberfragt bin. Ich denke
aber, dass man noch ein paar Sachen festlegen muss. Unter Umstaenden
laeuft das "UMTS-GPS" nur als eine Art AGPS, und funktioniert nur ueber
Cell-Tower-Triangulation. Das andere, auf COM1, ist das Standard Sirf
III GPS Device, welches ohne Probleme funktioniert. Anscheinend laeuft
dieses, sobald das Geraet eingeschalten wird, was ein wenig nervt, wenn
Strom ein kritischer Faktor ist. Ein Trost ist, dass der Positionsfix
relativ schnell ist (Ich hab vorhin auf meinem Balkon 28sek gemessen)
Damit waere ein Raetsel um das Viliv geloest....man findet ja irgendwie
nichts zu diesem Geraet :-/ Es waere weitaus schneller gegangen, waere
mal ein anstaendiges OS installiert....sollte ich endlich mal in Angriff
nehmen. so long

.. _Maik's Blog: http://blog.maikter.net/2011/04/18/huawei-em770w-gps-unterstutzung-aktvieren/

.. |Huawai Mobile Connect| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/05/device.png
.. |GPS COM1| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/05/gps-300x180.png
.. |image2| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/05/device.png
.. |image3| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/05/gps-300x180.png
