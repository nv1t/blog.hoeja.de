TalkingMac
##########
:date: 2011-12-18 02:40
:tags: de, mac, php

Das hier stammt aus der Zeit "Als ich noch einen Mac hatte". Ja ich war
mal ein MacOSX Benutzer. Ein stolzer Mac Besitzer. Bei MacOSX ist bzw.
war zu dieser Zeit ein PHP5.2 vorinstalliert. Weil ich bei Jugend
Forscht an meinem Stand ein wenig Verwirrung stiften wollte, hab ich ein
kleines Script geschrieben, was es moeglich macht ueber TCP/IP auf den
say command zuzugreifen (man kann sich auch einfach ueber ssh einloggen
:-/)

::

     1) {
                    $out = '-v '.secureShell($split[0]).' "'.secureShell($split[1]).'"';
                } else {
                    $out = '"'.secureShell($buf).'"';
                }
                `say $out`;
            }
        }while($buf != 'quit');
        #socket_write($client, $msg, strlen($msg));
        socket_close($client);
    } 
    ?>

Ich rate zur Vorsicht. Es hat definitiv irgendwo eine Sicherheitsluecke.
Es ist nur notduerftig gegen die groebsten Dummheiten geflickt. Ich
uebernehme keine Verantwortung zu gehijackten Macs. so long ps.: damit
kann man auch uebrigens im MediaMarkt oder AppleStore einen fetzen Spass
haben :)
