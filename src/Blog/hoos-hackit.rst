hoos hackit
###########
:date: 2011-11-13 19:04
:tags: bash, de

hoohead hat heute ein kleines "hackit" veroeffentlicht. Ich hatte mir
zum Ziel genommen, dass komplett in Bash zu loesen. Das ist mir auch
gelungen...hab sogar einen Einzeiler, aber ich trenn es auf, damit es
schoener zu lesen ist Das Hackit ist uebrigens hier zu finden, wer es
selber machen will:
`http://hoohead.hoohost.org/2011/11/kleines-sonntags-hackit/`_ [spoiler
title="ACHTUNG SPOILER"]

::

    name="nuit";
    cookiejar="cookie.jar";
    url="http://browsercheck.ath.cx/hackit/sonntags-hackit1.php";

    calc=$(curl -s -c "${cookiejar}" -F "name=${name}" "${url}" \
    | grep -o ' [0-9]*' \
    | sed '/^\s$/d' \
    | tr '\n' '+' \
    | sed 's/+$/\n/' \
    | bc
    );
    curl -b "${cookiejar}" -F "name=${name}" -F "ergebnis=${calc}" "${url}";

Was macht das Script eigentlich um das zu loesen. Wer sich das hackit
angeschaut hat, dem sollte aufgefallen sein, dass man Zahlen
zusammenzaehlen muss. Also hol ich mir diese Zahlen ueber ein grep aus
dem content raus, hau Leerzeilen raus (1. sed). Damit bleibt man mit
etwas uebrig, das ungefaehr so aussieht:

::

    2345
    6547
    2345
    3456

Dann ersetz ich alle Newlines durch Pluszeichen. Da aber eines zuviel
drin ist, muss ich das letzte Pluszeichen zurueckersetzen, womit ich
dann damit uebrig bleib:

::

    2345+6547+2345+3456

Und das pipe ich in bc rein, was mir dann die Antwort ausrechnet. Nun
muss ich die Antwort noch ueber ein curl eintragen und Tada :) geloest.
Nachdem anscheinend auch die Cookies wichtig sind, nutze ich einfach die
cookiejar Funktionen von curl, erleichtert mir das Leben ein wenig nice
one, hoo :) [/spoiler] so long

.. _`http://hoohead.hoohost.org/2011/11/kleines-sonntags-hackit/`: http://hoohead.hoohost.org/2011/11/kleines-sonntags-hackit/
