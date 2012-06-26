PHP 5.1....ARG!?!
#################
:date: 2012-01-13 14:31
:tags: de, php, there i fixed it

Die letzten Tage und Wochen gingen fuer eine Lerneinheit einer Freundin
drauf. Ich habe auf meinem Server entwickelt und dann das Projekt erst
im Nachhinein auf den Uni-Server migriert, weil ich dort keinen Account
hatte. Stellt sich herraus, dass auf den Uni-Servern noch ein PHP 5.1
laeuft. Ich dachte eigentlich, dass es keine Probleme gibt, aber wie das
immer so ist, mit neu auf alt, mussten welche auftreten. Das
Hauptproblem, welches die komplette Struktur des Programms in Frage
stellt war diese:

::

     function() {
                    //do something
            },

            'hook2' => function() {
                    //do something else
            }
    );
    $str = 'hook1';
    $hooks[$str]();
    ?>

Ich habe ein assoziatives Array, wobei der Value eine Funktion ist. Die
ganze Idee dahinter ist, dass ich einen String habe, der mein
Funktionsname ist und damit die Funktion aufrufen kann. Ich wollte also
eine Lambda Funktion machen. Dies geht in fast jeder interpretierten
Sprache (JS, Python, Ruby,...), nur wieder PHP straeubt sich in alten
Versionen. Ich dachte eigentlich, dass es insgesamt in 5.x geloest sein
sollte, war es aber nicht. Anscheinend existieren diese anonymen
Funktionen erst ab PHP 5.3...na toll, was jetzt... Ich musste also das
obige Skript dahingehend umbauen:

::


    Es ist im groben das gleiche, nur gefaellt mir nicht alle Funktion anlegen zu muessen. Zumal ich im anderen eine Art Namespace generiert

    Desweiteren hat mich etwas anderes aufgeregt, was in PHP 5.3 geflickt war. Ich hab noch nicht weiter getestet (wenn jemand ein 5.1 rumliegen hat, bitte mal schauen)
    Ich pruefe ob ein key in einem Array existiert. Das geht recht einfach ueber json_decode auslese. Der Grund, ist erst nach PHP 5.1 standardmaessig dabei :-/ d.h. ich musste schnell eine Alternative finden. Es wurde auf PECL verwiesen, was ich aber nicht machen kann, weil ich keine shell hab und an der konfiguration nicht rumschrauben kann.
    Es gibt genuegend JSON-Klasse, aber das war mir eigentlich zu gross.
    Dann bin ich darauf gestossen:


    Ich weiss nicht ob es alle Cases parsen kann, aber fuer meine Zwecke reicht es aus. Es ist nicht sonderlich schoen und man schafft sich eine Sicherheitsluecke, wenn der JSON String editiert werden koennte (koennen sie aber nicht).
    Zudem wird es nur im Notfall verwendet, wenn kein json_decode definiert ist.
    Was tut es genau: Es uebersetzt das JSON in ein PHP-Array und fuehrt es ueber eval aus. Im Prinzip ist JSON auch nichts anderes als ein assoziatives Array (man nehmen mal [] aus, was ein normales Array ist). aber die Zeichen muessen dementsprechend ausgetauscht werden. Ich habe diese Technik schon einmal bei einem Brainfuck Interpreter gesehen und fuer Ziemlich clever erachtet. Man ueberlaesst die Arbeit dem Interpreter selber. Muss sich also nicht wirklich um etwas kuemmern.

    So sah gestern mein Abend aus...Luecken schliessen und Web Applikation anpassen :-/

    so long

