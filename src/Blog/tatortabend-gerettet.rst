Tatortabend gerettet
####################
:date: 2011-09-15 22:11
:tags: automation, de, there i fixed it

Tatortabende sind immer wieder cool. Nur etwas hat mich immer gestoert,
wenn wir mit meinem Laptop geschaut haben. Der Standby-Modus! Mein
Rechner schaltet den Bildschirm nach 10min aus. Ich hab etliche
Moeglichkeiten probiert, das auszuschalten und nichts hat geholfen,
ausser neben dem Laptop zu sitzen und die Maus alle paar Minuten zu
Bewegen. Inzwischen bin ich drauf gekommen,dass acpi den in Anspruch
nimmt, ich zieh aber immer noch mein kleines Script vor :) Letzten
Sonntag war mir das aber zu bloed. Ich habe mir ueberlegt,dass es
theoretisch moeglich sein muss, die Maus ueber ein kleines Script zu
bewegen und genau das hab ich damit gemacht. Es gibt ein nettes kleines
Paket namens xautomation, welches eigenltich in sich selbsterklaerend
ist. Wer nur seine Maus alle paar Minuten mal bewegen will, ist hiermit
gut beraten:

::

    #!/bin/bash
    while [ 42 ]
    do
      xte 'mousermove 1 0' 'mousermove -1 0';
      sleep 120 
    done

Nicht wundern, man sieht die Bewegung nicht. Es faellt im normalen
Betrieb auch nicht auf und man merkt davon garnichts. Alle 2 Minuten
koennte es sein, dass die Maus ein wenig flickert, aber wer sieht das
schon. Mit xte lassen sich noch viele andere lustige Sachen machen und X
von einem Script aus steuern, ohne sich gross in die xlibs einzulesen.
so long
