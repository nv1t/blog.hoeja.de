ahhh...found it...array_map
###########################
:date: 2012-01-18 18:59
:tags: de, php

Ich hab in meinem letztigen Blogeintrag geschrieben, dass ich ewig an
diesem Problem gebastelt hab... Mein Ziel war es eigentlich immer ueber
array\_map das ganze zu machen, aber es hat nie so hingehauen wie ich
wollte, weil array\_map die keys nicht uebergibt. Aber es gibt eine
andere Moeglichkeit:

::

    print implode(', ',array_map(function($key,$val) { 
        return $key.'='.$val; 
    },array_keys($arr),$arr));

Ich hoffe es ist klar, was es macht :) Eigentlich das gleiche, wie in
meinem letzten Blogpost auch, nur ein wenig schoener und ausgereifter.
`@mkzer0`_ hat mich mit seinem Kommentar ueber array\_walk draufgebracht
und bin ihm dankbar, weil sonst haette ich mich nichtmehr damit
beschaeftigt :) Eigentlich war das nicht wirklich einen Blogpost wert,
aber nunja :)

.. _@mkzer0: http://twitter.com/#!/mkzer0
