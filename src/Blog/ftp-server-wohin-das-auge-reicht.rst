ftp server - wohin das Auge reicht
##################################
:date: 2011-10-17 20:59
:tags: de, pastebin, wtf

Ich hab heute mal wieder durch meinen pastebin ordner gescannt.
Standardanfragen sind wie immer:

::

    21:49:31 seda:~/dev/pastebin/data/
    % grep "password" *

Da kommt immer einiges zu Tage, aber Dumm sind die Leute auch nicht
jeden Tag. Aber ich dachte mir, schau ich mir mal an, was an Links
gepostet wird...vorallem an ftp:// Verweisen.

::

    21:49:31 seda:~/dev/pastebin/data/
    % grep "ftp:/" *

reicht da eigentlich schon aus und ich war erstaunt,was ich zu Tage
gefoerdert hab: 

|image0| 

Es sind viele Leerzeichen drin und ich hab
das schon auf ein paar Servern gesehen, dass ein Ordner erstellt wird,
ala:

::

    21:53:02 seda:~/troubleshooting/whitespace/
    % ls
    21:53:02 seda:~/troubleshooting/whitespace/
    % mkdir "   "
    21:53:06 seda:~/troubleshooting/whitespace/
    % ls
       
    21:53:34 seda:~/troubleshooting/whitespace/
    % rm -r \ \ \ 

Das faellt nicht sonderlich auf, wenn man nur mal kurz ueber sein
Verzeichnis schaut. Es scheinen sich also um gehackte Server zu handeln.
Zumindest sind auf den Servern einige Warez zu finden.

::

    1318819883|@|WB1AZLEF|@|Untitled|@|10 min ago|@|Never|@|373.85 KB|@|None

Die Datei wurde am "Mon, 17 Oct 2011 02:41:23 GMT" hochgeladen, naja
ungefaehr und wird auch nie vom Server geloescht. Insgesamt sind in der
Datei:

::

    22:05:06 seda:~/dev/pastebin/data/
    % wc -l WB1AZLEF
    5684 WB1AZLEF

5684 Server... Teilweise sind die Server auch noch online, ich war auf
2-3 drauf. [STRIKEOUT:Hat jemand lust die durchzuscannen? Ich wuerde
auch die Datei zur Verfuegung stellen.] Ich hab sie gerade selber
gescannt. Ist ja kein grosser Aufwand.

::

    22:36:37 seda:~/dev/pastebin/data/
    % for i in `cat WB1AZLEF | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | uniq`; do nmap -sn $i >> ../output; done;

Es ist ungefaehr 50:50.

::

    23:03:44 seda:~/dev/pastebin/
    % grep "Host is up" output| wc -l
    725
    23:37:33 seda:~/dev/pastebin/
    % grep "Host seems down" output| wc -l
    747

Natuerlich kann ich nicht versprechen, dass dann auch der FTP-Port offen
ist und man ueber anonymous drauf zugreifen kann, aber wenigstens der
Server ist erreichbar. Auch koennten die anderen Server noch die
Ping-Probes abblocken, was bedeutet, dass tatsaechlich mehr Server
online sind. Eigentlich sollte man sich mal zu den online Servern
verbinden und ein Listing erstellen, was alles drauf ist. Aber das ist
nichtmehr im Rahmen von "pastebin, wtf?!?" so long

.. |image0| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/10/2011-10-17-213951_1024x768_scrot-300x225.png
.. |image1| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/10/2011-10-17-213951_1024x768_scrot-300x225.png
