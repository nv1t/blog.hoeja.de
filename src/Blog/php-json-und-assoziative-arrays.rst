PHP, JSON und assoziative Arrays
################################
:date: 2012-01-11 12:37
:tags: de, php

Eigentlich gehoert das ja in PHP-Bashing, aber ich weiss nicht so recht.
Kann mir bisher selber keinen Reim draus machen, also bleib ich mal
lieber locker und erklaere das Problem. Vielleicht weiss jemand eine
Antwort drauf. Ich wollte ein Array shuffeln dass ich aus einem
stdObject gecasted hatte. Grundaufbau: Ich habe einen JSON-String den
ich mit json\_decode in ein stdObject gebracht habe, um damit in PHP zu
arbeiten. Doch hier steht mir immer noch nicht die Moeglichkeit zu das
Object zu shuffeln. Dieses Object laesst sich nun in ein assoziatives
Array casten. Das funktioniert auch Problemlos und es werden keine
Fehler geliefert. Doch, als ich auf Elemente zugreifen wollte, die nur
eine Zahl als String hatten, fiel das ganze fehl. (dass keiner verwirrt
ist: das ist die php shell, die man mit php -a bekommt)

 .. code-block :: php

    php > $str = '{"b": {"a": "test","1": "test2"}}';
    php > $arr = json_decode($str);
    php > var_dump($arr);
    object(stdClass)#3 (1) {
      ["b"]=>
      object(stdClass)#4 (2) {
        ["a"]=>
        string(4) "test"
        ["1"]=>
        string(5) "test2"
      }
    }
    php > $arr2 = (array) $arr->{'b'};
    php > var_dump($arr2);
    array(2) {
      ["a"]=>
      string(4) "test"
      ["1"]=>
      string(5) "test2"
    }
    php > print($arr2["1"]);
    PHP Notice:  Undefined index: 1 in php shell code on line 1
    php > print($arr2[1]);
    PHP Notice:  Undefined index: 1 in php shell code on line 1
    php > print($arr2['"1"']);
    PHP Notice:  Undefined index: "1" in php shell code on line 1
    php > foreach($arr2 as $key=>$elem){ print $key."=>".$elem."\n"; }
    a=>test
    1=>test2
    php > foreach($arr2 as $key=>$elem){ print $key."=>".$arr2[$key]."\n"; }
    a=>test
    PHP Notice:  Undefined index: 1 in php shell code on line 1
    1=>
    php > $p = array("a" => "test","1" => "test2");
    php > $p["1"];
    php > print($p["1"]);
    test2
    php > var_dump($p);
    array(2) {
      ["a"]=>
      string(4) "test"
      [1]=>
      string(5) "test2"
    }
    php >

Anscheinend wird selbst bei einem assoziativen Array in PHP die Nummern
als Integer gespeichert und auch so gesucht. Casted man es aber, wird
der String nicht in einen Integer umgewandelt, weshalb es spaeter beim
Suchen versagt, weil ja nur Integer gesucht werden. So kann ich mir
zumindest vorstellen, warum es nicht funktioniert. Dieses Problem ist
mir bisher nur bei JSON Decoding aufgefallen. Bei Klassen kann soetwas
nicht vorkommen, da keine Variablen $\\d existieren duerfen. Mir wurde
gerade ans Herz gelegt, den 2. Parameter von json\_decode zu nutzen, der
das JSON direkt in ein assoziatives Array uebersetzt. Aber damit umgeht
man das Problem nur, welches ja weiterhin besteht. Frage ist nun, ob es
ein Bug oder Feature ist. Ich wuerde auf einen Bug hindeuten, nachdem
das Casting falsch laeuft, aber intern alles korrekt geregelt wird. Der
String wird beim Abspeichern nur nicht als Integer geparsed, was einen
spaeteren Zugriff unmoeglich macht. so long
