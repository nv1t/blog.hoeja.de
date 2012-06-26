preventing mysql injection? nice try...
#######################################
:date: 2011-10-26 15:27
:tags: bugs, de, pastebin, sql injection, wtf

Ich wuerde mal sagen: nice try! :)

::


    Es faengt ja wirklich gut an und ihm/ihr sind auch SQL Injections gelaeufig, aber es wird halt nicht wirklich aufgepasst. Der Comment in Zeile 12 ist ja auch einfach nur zum an die Wand haengen.
    Das Grauen ist aber wirklich in Zeile 38. Wie kann man vorher dran denken und dann ploetzlich nicht? oder ist der Gedanke: "Wenn es in Klammern steht, dann ist keine Injection moeglich"  staerker?

    d.h. wenn Email und Benutzername nicht irgendwie mal in der Datenbank existieren, dann ist eine Injection moeglich. Arg...wenigstens wurde es probiert...das ist schonmal etwas.

    So nebenbei: das Error Handling ist ja auch zu goettlich und dafuer extra ein ob_start() eingefuehrt. Ich lese gerne solchen Code, das heitert mich jeden morgen auf :)

    so long

