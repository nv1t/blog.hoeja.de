Sniffen mit Fritzbox
####################
:date: 2011-05-21 14:34
:tags: de, fritzbox, hardware, statistics

Warum will man den Datenverkehr auf seiner Fritzbox ueberwachen? Keine
Ahnung... Eine Zeitlang hab ich mit USB-Sticks und einem statisch
gelinktem tcpdump rumprobiert und das funktioniert super. Hab ein paar
berrauschende Ergebnisse erzielt, aber es war doch sehr
umstaendlich...man musste immer erst den USB-stick einstecken und dann
hat er aufgenommen. Dann hab ich eine Datei namens capture\_notimeout
entdeckt, und mich dran gemacht, zu verstehen, was das alles kann.
Stellt sich herraus, dass man es aus dem Web verwenden kann und es
komplett mitloggt und eine dauerhafte Verbindung unterstuetzt :)

::

    #!/bin/sh
    IP="fritz.box"
    Passwd=""

    #----------------------------nothing to change from here----------------#
    ChallengeXML=`wget -O - "http://$IP/cgi-bin/webcm?getpage=../html/login_sid.xml" 2>/dev/null| grep Challenge`
    Challenge=`echo $ChallengeXML | awk '{match($0,/>[^<>]+/dev/null| grep "name=\"sid\"" | head -1 | awk '{match($0,/value="[^"]+"/); print substr($0,RSTART+7,RLENGTH-8)}'`

    # Internet Capture
    wget -O - "http://$IP/cgi-bin/capture_notimeout?ifaceorminor=3-17\&snaplen=1600&capture=Start&sid=$SID" 2>/dev/null > $1

aufgerufen wird das Skript mit: ./skript.sh Damit laesst sich der
komplette Datenverkehr der ueber die FritzBox laeuft von einem Rechner,
der angeschlossen ist, mitloggen, ohne irgendwas an der Box, oder an der
software zu veraendern. Erklaerung folgt ...aehm....never :) so long
