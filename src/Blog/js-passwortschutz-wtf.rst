JS Passwortschutz, wtf?!
########################
:date: 2012-05-14 14:53
:tags: bugs, de, javascript

Zufaelligerweise bin ich ueber ein Gallery gestolpert, die mir zuanfangs
auch noch recht gut gefallen hat. Leider ist sie ein wenig Javascript
lastig. Auch kann fuer einzelne Ordner ein Passwortschutz eingebaut
werden, welcher dann lustigerweise so aussieht: 

|image0|

Das sollte
einem bekannt vorkommen. Wenn man auf Abbrechen klickt, wird auch ein
alert-Dialog angezeigt. Dementsprechend wird es wahrscheinlich ueber
Javascript geregelt. Und dem ist auch so. Beim Laden der Gallerien wird
ein Ajax Call ueber cpaint gemacht, der eine bestimmte PHP Funktion
aufruft.

 .. code-block :: javascript

    cp.call( base_url+'libraries/ajax.gateway.php',
                'get_galleries',
                updateGalleries );

Jetzt kann man entweder im SourceCode suchen, wie genau diese Funktion
aufgerufen wird, weil wahrscheinlich wird ein Post oder Get Parameter
gesetzt, oder man wirft mal eben wireshark an: 

|image1| 

Es wird also
ueber GET uebertragen. Nun denn...wir wissen auch was rauskommt:

::

    Brautfotos:7:rupertundbirgit:Brautfotos\u000a|Feier:8:rupertundbirgit:Feier\u000a|Hochzeit:63:rupertundbirgit:Hochzeit\u000a|hz gramss 1:634:|hz gramss 2:181:|hz gramss 3:0:|hz gramss standesamt:87:|Standesamt:8:rupertundbirgit:Standesamt\u000a|

Die einzelnen Gallerien sind durch "\|" bzw sogar "\\u000a\|"
voneinander getrennt. Intern ist es: "Name":"id":"passwort":"Name?"
Somit haben wir die Passwoerter fuer die einzelnen Gallerien. so long.

.. |image0| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/05/2012-05-14-140410_629x413_scrot-300x196.png
.. |image1| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/05/2012-05-14-141548_660x209_scrot-300x95.png
.. |image2| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/05/2012-05-14-140410_629x413_scrot-300x196.png
.. |image3| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/05/2012-05-14-141548_660x209_scrot-300x95.png
