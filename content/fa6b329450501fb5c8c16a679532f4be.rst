SSH auf Dom0 mit einem DomU Namen
#################################
:date: 2012-11-13 20:18
:tags: de, xen

Schon vor einem halben Jahr hab ich mir Gedanken gemacht, wie man am
sinnvollsten auf die jeweilige Dom0 kommt, wenn man nur den DomU Namen hat.
Das erweist sich aeusserst schwierig, wenn man nicht genau weiss, wo die 
Virtualisierung laeuft.

Normalerweise gibt es dafuer meistens Virtualisierungsmanager, wie Archipel,
Puppet, vSphere oder aehnliches, doch alles laesst sich nur wirklich einsetzen,
wenn man etwas neues Aufbaut, oder viel Arbeit investiert um vorhandes zu migrieren.

Ich wollte trotzdem eingeben koennen: sshdom0 <domU>, oder ssh <domU>.zusatz.
Der erste Gedanke ist relativ einfach: Wir machen uns eine eigene Zone im DNS und
jeder Xen Host traegt seine respektiven Virtualisierungen dort ein.
Das geht. Zweifelsohne. 

Das Skript das die Eintraege macht und anpasst war auch relativ schnell geschrieben.
Doch irgendwie wurde es nie ausgerollt und kam nie ueber die testing Phase raus. Vielleicht
weil niemand davon wirklich ueberzeugt war.

Das ganze versank im Sand und man ging zur alten Methode zurueck:

 .. code-block :: bash

    ssh xen1 "xm list"; ssh xen2 "xm list" ...

Nachdem mir das zu bloed wurde, gab es ein kleines Suchskript, das genau diesen
Prozess automatisierte:

 .. code-block :: bash

    #!/bin/bash
    function searchDomU() {
        servers=(xen1 xen2);
        SEARCH=$1
        KEY="aaa";
        SSH="ssh -i ${KEY} -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -oBatchMode=yes root@"
        for i in ${servers[@]}; do
            XMLIST=`${SSH}${i} "xm list" 2> /dev/null`;

            if echo ${XMLIST} | grep "${SEARCH}" > /dev/null; then
                echo "${i}: ";
                xens=`echo "${XMLIST}" | sed '1,2d' | awk '{print $1}'`;
                for a in $xens; do
                    if echo "${a}" | grep "${SEARCH}" > /dev/null; then
                        echo -e "\t${a}"
                    fi
                done;
            fi;
        done;
    }

Sicher nicht die beste Loesung, aber es taugte um schnell was zu finden. Daraufhin 
verschwand das ganze in meiner Schublade.

Vor ein paar Tagen wurde es dann wieder aus der Versenkung gehoben als ich die Dom0s
von Virtualisierung suchte und ich die Funktion vergessen hatte.

Meine Ueberlegung war, dass die Dom0 in einem traceroute auf die DomU auftauchen MUSS.
Das ist natuerlich eine voellig falsche Annahme, aber durch "glueckliche" Umstaende
passierte genau das.

In guenstigen firewall Einstellungen ist es tatsaechlich der Fall, dass die Dom0 der
letzte Eintrag ist.

Ein traceroute macht im Prinzip nichts anderes als die TTL immer weiter um eins zu erhoehen,
bis es den Zielort oder seine maximalen Hops erreicht hat.
Da die Pakete auf dem Port von der Firewall Rejected werden, muss zwangslaeufig die Firewall als
letzter bekannter Punkt auftauchen.

Meine Funktion veringerte sich kurzfristig auf das:

 .. code-block :: bash

    function sshdom0() {
        ssh root@`traceroute $1 | awk 'END{print $2}'`
    }

Das ist aber keine sichere Methode und funktioniert nur "zufaellig" bei unserem Setup.
Man koennte traceroute auf einen Port setzen, der definitiv zu ist, so wuerde man wenigstens
die Chancen nochmal ein bisschen nach oben treiben.

Aber dann, nach ein wenig suchen, bin ich auf eine ziemlich schoene Methode gestossen.
Man kann eine extra-line der cmdline hinzufuegen. Das bedeutet, man kann den Namen, der Dom0 
den DomUs direkt uebergeben beim Bootup.

Dadurch hat man keine nervigen Crons und man hat keine nervigen Zonen um die man sich kuemmern muss.
Zudem wuerden die sich bei automatischen Migrationen zwischen Dom0s automatisch anpassen.
In den Configs fuer die einzelnen Virtualisierungen muss nur eine Zeile hinzugefuegt werden:

 .. code-block :: python

    extra="Dom0Hostname="+socket.gethostbyaddr(socket.gethostname())[0]

Das fuegt den FQDN der cmdline hinzu, die ueber /proc/cmdline auf der DomU ausgelesen werden kann.
Fals man nur den Hostname will, wird ein os.uname()[1] reichen, statt dem ganzen socket.gethost...

Wie man das dann verwendet, bleibt der Fantasie ueberlassen. Man koennte zum Beispiel die sshdom0 
Funktion abwandeln in:

 .. code-block :: bash

    function sshdom0() {
        ssh root@`ssh root@${1} "sed 's/.*Dom0Hostname=//g' /proc/cmdline"`
    }


Ich bekam daraufhin die Frage, was passiert, wenn die DomU haengt und man deshalb auf Dom0 muesste, um sie
abzuschiessen bzw. neuzustarten. Dann waere man komplett abgeschnitten.
Wozu haben wir traceroute ;) 
Wenn die Maschine haengt, kann sie auch keine Packages annehmen, weshalb die Firewall ein Reject Package bekommt
und fuer uns antwortet.

Demnach ist eine Kombination der beiden Techniken wohl am besten.


 .. code-block :: bash

    function sshdom0() {
        ssh root@`ssh root@${1} "sed 's/.*Dom0Hostname=//g' /proc/cmdline" || traceroute $1 | awk 'END{print $2}'`
    }

Achtung: Die Funktion ist schnell geschrieben und macht die Annahme, dass Dom0Hostname am Ende von der cmdline steht.
Dies muss natuerlich nicht der Fall sein.

so long
