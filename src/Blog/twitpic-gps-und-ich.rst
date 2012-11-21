Twitpic, GPS und ich
####################
:date: 2011-12-11 07:12
:tags: bot, de, ttytter, twitpic, twitter

Ich stoer mich ja schon etwas laenger an dieser GPS Geschichte. Aber um
das ganze mal ein wenig weiter zu treiben und weil mir heute Nacht
langweilig war, habe ich mich mit Twitpic naeher beschaeftigt.
Eigentlich bestanden alle Scripte schon, aber den Murks wollte ich nicht
online stellen, da es nur Proof of Concept war. Jetzt hab ich aber etwas
dran gearbeitet und alle auf Bash Level runtergebracht. Es speichert
auch nichtmehr alle Bilder ab sondern checkt diese gleich auf GPS durch
und loescht sie, wenn sie nicht interressant sind.

 .. code-block :: bash

    #!/bin/bash

    mkdir -p data/${1};

    # Fetching first Page
    p=1
    curl -s twitpic.com/photos/${1}?page=${p} > data/${1}/tmp

    # Getting useful information about the number of pictures
    quantity=`cat data/${1}/tmp | tr '\n' ' ' | sed 's/.*Stats[^o]*ount">[^<]*]*>\([^<]*\)<.*/\1/'`
    echo "Checking ${quantity} pictures";
    a=1
    b=0
    echo -en "0.0%";

    # Generating stats file inside the new directory
    echo "" > data/${1}/stats.txt
    echo "Photographs with GPS:" >> data/${1}/stats.txt

    # dirty workaround for do-while
    while [ 1 ]; do 
        curl -s twitpic.com/photos/${1}?page=${p} > data/${1}/tmp1
        # incrementing page 
            p=`echo "${p}+1"|bc`

        # Fetching all picture ids from the current page
        for i in `grep " data/${1}/tmp;
            url=`grep "photo-display" data/${1}/tmp | sed 's/^.*src="\([^"]*\)".*$/\1/g'`;
            # saving the new pictures, so we don't have to fetch it twice
            curl -s "$url" > data/${1}/${i}.jpg; 
            exiftool data/${1}/${i}.jpg > data/${1}/tmp;
        
            # checking for gps inside the exif
            if ! grep -q "GPS Position" data/${1}/tmp; then
                rm data/${1}/${i}.jpg
            else
                gps=`grep "GPS Position" tmp | sed 's/.*:\(.*\)$/\1/'`;
                b=`echo "${b}+1"|bc`;
                echo "${i}: ${gps}" >> data/${1}/stats.txt
            fi;
            a=`echo "${a}+1"|bc`;
        done;
        
        # dirty hack for a do-while
        if ! grep -q "More photos >" data/${1}/tmp1; then break; fi; 
    done;
    rm data/${1}/tmp*
    echo ""
    echo ""
    sed -i "1s/.*/There are ${b} of ${quantity} pictures with GPS Information in @${1}'s account/" data/${1}/stats.txt;
    head -n 1 data/${1}/stats.txt

Ich erklaere das Skript nicht weiter, ausser, dass es eine
Ordnerstruktur "data/AccountToScan" anlegt und man es mit
"./scriptname.sh AccountToScan" aufrufen sollte :) Dem Nachgefolgt ist
ein kleines Script, welches in einer Endlosschleife laeuft. Ja, ich
traue es mich zu sagen: Es ist ein Twitterbot. Dieser Twitterbot traegt
den Namen `@nuitgaspard`_ und tut nichts anderes als den Public-Timeline
Feed von twitpic zu scannen und die Bilder auf GPS Koordinaten zu
ueberpruefen. Sollten welche existieren haut er einen Tweet raus, mit
den Koordinaten, dem Bild und natuerlich dem Namen des Posters, um auch
ihn darauf hinzuweisen. Zudem folgt er dem "Suender" auch noch. Ich bin
ganz froh, dass Twitpic ganz wenige Bilder in seiner Public-Timeline
raushaut, sonst haette ich wahrscheinlich ein Twitterproblem mit diesen
350 Zugriffen pro Stunde. Der Bot nervt auch nicht sonderlich in der
Timeline und man lernt viele Leute kennen mit klassen Bildern und weiss
oft gleich wo sie wohnen.

 .. code-block :: bash

    #!/bin/bash
    while [ 1 ]; do
        for i in `curl "http://twitpic.com/public_timeline/feed.rss" -s | grep "guid" | sed "s/<[^>]*>//g;s/ //g"`; do
            curl -s "$i" > tmp;
            user=`grep "photo_username" tmp | sed 's/<[^>]*>//g;s/\t//g'`;
            url=`grep "photo-display" tmp | sed 's/^.*src="\([^"]*\)".*$/\1/g'`;
            curl -s "$url" | exiftool - > tmp
            if grep -q "GPS Position" tmp; then
                gps=`grep "GPS Position" tmp | sed 's/.*:\(.*\)$/\1/'`;
                echo "photo taken at ${gps} from ${user}: ${i}" | ttytter -script;
                echo "/follow ${user}" | ttytter -script;
                echo "${user};${gps};${i}" >> finding;
            fi;
        done;
        sleep 30
    done;

Wer sich jetzt fragt: "Haaaeehh...wie schickt der an Twitter?!?". Das
ist ganz einfach zu beantworten. Ich twittere oftmals (wenn ich auf
Arbeit bin) ueber ein kleines Tool namens `ttytter`_. Das ist ein
Twitterclient der in Perl geschrieben ist, auf der Konsole laeuft und
fuer Konsolejunkies wirklich angenehm ist. Unter anderem unterstuetzt er
eben auch Scripting, was ihn fuer solche Aktionen ungemein nuetzlich
macht :) Vielleicht kommt es noch, dass man ihm ein Bild schicken kann
und er ueberprueft das. Faende ich spannend. Also: Folgt
`@nuitgaspard`_. Ich folge auch garantiert zurueck, sollte ich mal ein
Bild von euch sehen ;) so long

.. _@nuitgaspard: http://twitter.com/#!/nuitgaspard
.. _ttytter: http://www.floodgap.com/software/ttytter/
