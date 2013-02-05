Hotspot Login
#############
:date: 2011-12-05 21:10
:tags: bash, de, login

Ich habe mich in den letzten Tagen ein wenig mit einem Hotspot
beschaeftigt. Es basiert auf `Coova`_. Nachdem ich einen festen Zugang
eigentlich habe, wollte ich meinen Laptop automatisch einloggen. Dazu
gibt es 2 Moeglichkeiten. Entweder man laesst seine Mac-Adresse
eintragen, womit der Passwort-Login nichtmehr funktioniert, oder man
muss so den Benutzername und Passwort eintragen. Ich hab mich fuer
letzteres Entschieden, weil es mir deutlich mehr Bewegungsfreiraum gibt
ueber die Geraete die ich verwende. Aber, weil ich nicht staendig mich
einloggen wollte, hab ich ein kleines Script gebastelt:

 .. code-block :: bash

    #!/bin/bash
    username="" # username
    password="" # password
    loginurl="" # path to loginurl

    if [ -e '~/.cookies' ]; then
      rm ~/.cookies;
    fi;

    url=`curl -c ~/.cookies -b ~/.cookies -L -s "http://google.de" | grep 'meta http-equiv="refresh"' | sed -n 's/.*URL=\(.*\)".*$/\1/p'`
    content=`curl -c ~/.cookies -b ~/.cookies  -L -s "$url"`
    challenge=`echo "$content" | grep 'name="challenge"' | sed -n 's/.*value="\(.*\)".*/\1/p'`

    curl -L -s -c ~/.cookies -b ~/.cookies -e "${url}" -d "challenge=${challenge}&username=${username}&password=${password}&userurl=http%3A%2F%2Fgoogle.de" "${loginurl}" > /dev/null

    rm ~/.cookies;

Dieses Script wird durch wicd nach einem connect ausgefuehrt, wenn es
sich um den Hotspot handelt. Wie funktioniert eigentlich dieser Login.
Ich rufe ueber curl eine beliebige Seite auf, dies wird durch das
Hotspot-Portal abgefangen und ich werde auf eine Seite mit einem Refresh
weitergeleitet. Nachdem dies nicht automatisch passiert, grep ich mir
die neue URL raus und speicher sie $url ab. Danach hole ich mir Content
von der neuen Seite, welches die Loginseite ist. An diesem Punkt hole
ich mir die Challenge, die aus einem Secret und ein paar anderen Dingen
berechnet wird (wer es wissen will, Source nachschlagen). Daraufhin
uebergeb ich alles der login.php welches mich einloggt. Natuerlich wird
auch hier noch ein paar Weiterleitungen gemacht, aber das fang ich alles
ueber curl ab, welches alles fuer mich regelt. Interressant ist noch,
dass curl Sessions nur verarbeiten kann, wenn Cookies eingesetzt werden
(was eigentlich auch verstaendlich ist), weshalb ich ueberall auf das
Cookiejar zugreife, um eine Session am Leben zu erhalten. Was Passiert
eigentlich bei diesen ganzen Requests? Ich mach mir das Leben mit Curl
einfach und such mir nur das raus wo ich am Ende hinwill. Aber unter der
Haube passiert eine ganze Menge. Es treten insgesamt 4 Requests auf, bis
ich auf der eigentlichen Loginseite lande:

 .. code-block :: plain

    GET / HTTP/1.1
    Host: www.google.de
    User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0.1) Gecko/20100101 Firefox/8.0.1
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    Accept-Language: en-us,en;q=0.5
    Accept-Encoding: gzip, deflate
    Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
    Connection: keep-alive
    Cookie: PREF=ID=54297857141214c2:U=d85a6623d96fa5bb:FF=0:TM=1321985976:LM=1321985979:S=mPPJT4Ja5VlmwkyG; NID=53=sLbHfFxtCoQYLifthwtTzbPofE_YAhJmCJTFo6onapDxErtMVfpxIcpoz0RSALjNMTQt4r_yq7pcHdJw0Un9VJTq3oWstIUXpfct58ohejvl7lKBoDtnuyaGUSEdyArI

    HTTP/1.0 302 Moved Temporarily
    Connection: close
    Pragma: no-cache
    Expires: Fri, 01 Jan 1971 00:00:00 GMT
    Cache-Control: no-cache, must-revalidate
    P3P: CP="IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT"
    Location: https://hotspot.tmt.de/coova/splash.php?loginurl=https%3a%2f%2fhotspot.tmt.de%2fcoova%2fhs_land.php%3fres%3dnotyet%26uamip%3d88.209.16.1%26uamport%3d3990%26challenge%3d63189192171624f280e7b58d2d7a9c07%26called%3d92-11-75-7D-2A-67%26mac%3d00-19-D2-97-92-16%26ip%3d88.209.16.107%26nasid%3dtmt_coova%26sessionid%3d4eddeeb200000027%26userurl%3dhttp%253a%252f%252fwww.google.de%252f%26md%3d091099DB48081C771BD7E6C886722B89
    Content-Type: text/html; charset=UTF-8
    Content-Length: 901

Dies ist der eigentliche Aufruf, wenn ich google aufruf und noch nicht
eingeloggt bin. Er legt sich mal nen Cookie an und kriegt vorallem einen
302er zurueck auf eine Location Namens splash.php. An diese splash.php
wird unter anderem auch die IP, die zu dem Rechner gehoert, die
Client-Mac und die Router-Mac uebermittelt. Dies ist deshalb wichtig, um
festzustellen, in welchem Wlan sich der Benutzer befindet. Die
Client-Mac wird zur Mac-Authentifizierung eingesetzt. Auch wird hier
schon eine Challenge berechnet, die spaeter noch interressant sein wird.
Der 2. Request ist eigentlich bloss der follow zur splash.php

 .. code-block :: plain

    GET /coova/splash.php?loginurl=https%3a%2f%2fhotspot.tmt.de%2fcoova%2fhs_land.php%3fres%3dnotyet%26uamip%3d88.209.16.1%26uamport%3d3990%26challenge%3d63189192171624f280e7b58d2d7a9c07%26called%3d92-11-75-7D-2A-67%26mac%3d00-19-D2-97-92-16%26ip%3d88.209.16.107%26nasid%3dtmt_coova%26sessionid%3d4eddeeb200000027%26userurl%3dhttp%253a%252f%252fwww.google.de%252f%26md%3d091099DB48081C771BD7E6C886722B89 HTTP/1.1
    Host: hotspot.tmt.de
    User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0.1) Gecko/20100101 Firefox/8.0.1
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    Accept-Language: en-us,en;q=0.5
    Accept-Encoding: gzip, deflate
    Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
    Connection: keep-alive

    HTTP/1.1 200 OK
    Date: Tue, 06 Dec 2011 10:30:24 GMT
    Server: Apache/2.2.16 (Debian)
    Vary: Accept-Encoding
    Content-Encoding: gzip
    Content-Length: 1331
    Keep-Alive: timeout=15, max=98
    Connection: Keep-Alive
    Content-Type: text/html

Das hier koennen wir recht kurz halten. Die Splash wird aufgerufen um
alle Daten zu uebergeben. Auf dieser splash.php ist eben dieser meta-tag
mit einem Refresh. Dieser Refresh geht zur hs\_land.php.

 .. code-block :: plain

    GET /coova/hs_land.php?res=notyet&uamip=88.209.16.1&uamport=3990&challenge=63189192171624f280e7b58d2d7a9c07&called=92-11-75-7D-2A-67&mac=00-19-D2-97-92-16&ip=88.209.16.107&nasid=tmt_coova&sessionid=4eddeeb200000027&userurl=http%3a%2f%2fwww.google.de%2f&md=091099DB48081C771BD7E6C886722B89 HTTP/1.1
    Host: hotspot.tmt.de
    User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0.1) Gecko/20100101 Firefox/8.0.1
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    Accept-Language: en-us,en;q=0.5
    Accept-Encoding: gzip, deflate
    Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
    Connection: keep-alive

    HTTP/1.1 200 OK
    Date: Tue, 06 Dec 2011 10:30:26 GMT
    Server: Apache/2.2.16 (Debian)
    Vary: Accept-Encoding
    Content-Encoding: gzip
    Content-Length: 1526
    Keep-Alive: timeout=15, max=97
    Connection: Keep-Alive
    Content-Type: text/html

Die hs\_land.php macht nichts anderes als die eigentliche Loginseite
aufzurufen. Damit sind wir auf der Loginseite gelandet. Wie geht es nun
mit dem Login weiter? Hier werden wir auch von einer Loginseite zur
naechsten geworfen, mit einem 302er nach dem anderen. An login.php wird
das Formular uebermittelt als Post-Variablen. Auch wird hier die
Challenge uebermittelt, welche im weiteren Verlauf interressant wird.

 .. code-block :: plain

    POST /coova/login.php HTTP/1.1
    Host: hotspot.tmt.de
    User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0.1) Gecko/20100101 Firefox/8.0.1
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    Accept-Language: en-us,en;q=0.5
    Accept-Encoding: gzip, deflate
    Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
    Connection: keep-alive
    Referer: https://hotspot.tmt.de/coova/hs_land.php?res=notyet&uamip=88.209.16.1&uamport=3990&challenge=63189192171624f280e7b58d2d7a9c07&called=92-11-75-7D-2A-67&mac=00-19-D2-97-92-16&ip=88.209.16.107&nasid=tmt_coova&sessionid=4eddeeb200000027&userurl=http%3a%2f%2fwww.google.de%2f&md=091099DB48081C771BD7E6C886722B89
    Content-Type: application/x-www-form-urlencoded
    Content-Length: ${length}
    challenge=63189192171624f280e7b58d2d7a9c07&userurl=http%253A%252F%252Fwww.google.de%252F&username=${username}&password=${password}

    HTTP/1.1 302 Found
    Date: Tue, 06 Dec 2011 10:30:34 GMT
    Server: Apache/2.2.16 (Debian)
    Location: http://88.209.16.1:3990/logon?username=${username}&password=${calcPassword}&userurl=http%3A%2F%2Fwww.google.de%2F
    Vary: Accept-Encoding
    Content-Encoding: gzip
    Content-Length: 192
    Keep-Alive: timeout=15, max=96
    Connection: Keep-Alive
    Content-Type: text/html

Denn aus dieser Challenge wird ein neues Password generiert, welches nun
hin und hergeworfen werden. Dieses Passwort krieg ich schon beim letzten
Request und jetzt nur wieder mitueberben an logon. Das ganze ist wohl
ein kleines Programm/Server, welcher auf Port 3990 laeuft.

 .. code-block :: plain

    GET /logon?username=${username}&password=${calcPassword}&userurl=http%3A%2F%2Fwww.google.de%2F HTTP/1.1
    Host: 88.209.16.1:3990
    User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0.1) Gecko/20100101 Firefox/8.0.1
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    Accept-Language: en-us,en;q=0.5
    Accept-Encoding: gzip, deflate
    Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
    Connection: keep-alive

    HTTP/1.0 302 Moved Temporarily
    Connection: close
    Pragma: no-cache
    Expires: Fri, 01 Jan 1971 00:00:00 GMT
    Cache-Control: no-cache, must-revalidate
    P3P: CP="IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT"
    Location: https://hotspot.tmt.de/coova/hs_land.php?res=success&uamip=88.209.16.1&uamport=3990&called=92-11-75-7D-2A-67&uid=${username}&mac=00-19-D2-97-92-16&ip=88.209.16.107&nasid=tmt_coova&sessionid=4eddeeb200000027&redirurl=&userurl=http%3a%2f%2fwww.google.de%2f&md=E9237655ECBB6B4F191AAA36B7F5A267
    Content-Type: text/html; charset=UTF-8
    Content-Length: 630

Man wird nun auf die Haupseite, die "hs\_land.php" zurueckgeleitet.
Diesmal aber mit meinem res=success

 .. code-block :: plain

    GET /coova/hs_land.php?res=success&uamip=88.209.16.1&uamport=3990&called=92-11-75-7D-2A-67&uid=${username}&mac=00-19-D2-97-92-16&ip=88.209.16.107&nasid=tmt_coova&sessionid=4eddeeb200000027&redirurl=&userurl=http%3a%2f%2fwww.google.de%2f&md=E9237655ECBB6B4F191AAA36B7F5A267 HTTP/1.1
    Host: hotspot.tmt.de
    User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0.1) Gecko/20100101 Firefox/8.0.1
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    Accept-Language: en-us,en;q=0.5
    Accept-Encoding: gzip, deflate
    Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
    Connection: keep-alive

    HTTP/1.1 302 Found
    Date: Tue, 06 Dec 2011 10:30:34 GMT
    Server: Apache/2.2.16 (Debian)
    Location: http://www.google.de/
    Vary: Accept-Encoding
    Content-Encoding: gzip
    Content-Length: 1564
    Keep-Alive: timeout=15, max=95
    Connection: Keep-Alive
    Content-Type: text/html

Der letzte 302er geht auf die Ursprungsseite die ich eigentlich aufrufen
wollte.

 .. code-block :: plain

    GET / HTTP/1.1
    Host: www.google.de
    User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0.1) Gecko/20100101 Firefox/8.0.1
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    Accept-Language: en-us,en;q=0.5
    Accept-Encoding: gzip, deflate
    Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
    Connection: keep-alive
    Cookie: PREF=ID=54297857141214c2:U=d85a6623d96fa5bb:FF=0:TM=1321985976:LM=1321985979:S=mPPJT4Ja5VlmwkyG; NID=53=sLbHfFxtCoQYLifthwtTzbPofE_YAhJmCJTFo6onapDxErtMVfpxIcpoz0RSALjNMTQt4r_yq7pcHdJw0Un9VJTq3oWstIUXpfct58ohejvl7lKBoDtnuyaGUSEdyArI

    HTTP/1.1 200 OK
    Date: Tue, 06 Dec 2011 10:30:22 GMT
    Expires: -1
    Cache-Control: private, max-age=0
    Content-Type: text/html; charset=UTF-8
    Content-Encoding: gzip
    Server: gws
    Content-Length: 16141
    X-XSS-Protection: 1; mode=block
    X-Frame-Options: SAMEORIGIN

Das ganze wird in einer Session gehalten. Das neue Passwort wird aus
einem Secret und dem Challenge berechnet. Aber der Code ist komplett
Opensource. Das ist nur, wie das LoginScript aufgebaut ist, Wie man
sieht, wird die Macadresse verwendet. Es gibt einen Macadressen Login.
Nachdem dort auch nur die Macadresse uebermittelt wird, kann man sich,
wenn man die richtige Macadresse erwischt, welche zufaellig eingetragen
ist ohne Probleme in den Hotspot einloggen. Nur, wenn eine Macadresse
eingeloggt ist, kann man sich nicht noch einmal mit dieser Macadresse
einloggen. In keinem Hotspot. Das ist ein notwendiges Uebel, welches
durch diese "Macadressenauthentifizierung" aufkommt und nicht wirklich
geloest werden kann. so long

.. _Coova: http://coova.org/
