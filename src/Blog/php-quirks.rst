PHP Quirks
##########
:date: 2012-06-26 06:09
:tags: de, php, quirks, bashing


Ich bin schonmal ueber ein paar PHP Quirks gestolpert. Alles was hier an
Code geschrieben ist, ist kurzzeitig mal gelaufen als Test.
Entweder ihr probiert es mit "php -a" in der interaktiven Shell aus,
oder macht immer ein kleines Script.
Have fun!

Konstanten wirklich konstant?
=============================
Sind Konstanten wirklich Konstanten? Oh nein...man kann sie Redefinen, wenn der
dritte ominoese Parameter gesetzt ist, der alles Case-Insensitiv macht. 

.. code-block :: php

	<?php
	define('A',1,true);
	var_dump(A);
	var_dump(a);
	define('A',2);
	var_dump(A);
	var_dump(a);
	?>

Bei Case-Insensitiv wird es naemlich als Kleinbuchstabe abgespeichert.
Das laesst sich schnell ueber ein: define('a',3); rausfinden ;)

serialize awaaaaay...
=====================
Ihr kennt alle die gute alte serialize Funktion. Schoen und gut. Ich habe 
sie gerne genutzt. Aber schauen wir mal, was sie mit einem DOMDocument macht.

.. code-block :: php

	<?php
	$dom = new DOMDocument; 
	$dom->loadXML('<test/>');

	$dom = serialize($dom);
	$dom = unserialize($dom);

	var_dump($dom->saveXML());
	?>

Ich wuerde sagen BAEEEEM. Klappe zu, Affe tot!
Aehnliches Funktioniert auch mit anderen XML Objekten.

json awaaaaaay.....
===================
Einen aehnlichen Fall gibt es uebrigens auch bei JSON. Darueber habe ich
schonmal gebloggt, weil es mich zu der Zeit ziemlich aufgeregt hat. (`here <http://blog.hoeja.de/php-json-und-assoziative-arrays.html>`_). Aber 
ich will es hier nochmal einmal kurz aufgreifen.

.. code-block :: php
	
	<?php
	$str = '{"b": {"a": "test","1": "test2"}}';
	$arr = json_decode($str);
	var_dump($arr);
	$arr2 = (array) $arr->{'b'};
	var_dump($arr2);
	?>

Und jetzt versucht mal auf $arr2["1"] zuzugreifen :) Have fun trying!
Ausfuehrliche Erklaerung ist im anderen Artikel.

this and that.
==============
Jeder stellt sich immer vor, dass $this eine simple Variable sei. 
HAHA...Habe noch nie so gelacht. Das ist nur eine pseudo-Variable und 
dies laesst sich auch leicht beweisen:

.. code-block :: php
	
	<?php
	class A { 
		function init() { 
			$this=$this;
		} 
	}
	?>

Lustigerweise laesst sich aber genau dies mit einer Hilfsvariable
und machen:

.. code-block :: php

	<?php
	class A {
		function init() {
			$a = 'this';
			$$a = $this;
		}
	}
	?>	


strings, no not the girly ones!
===============================
Man sollte wissen, dass man Strings genau wie ein Array
ansprechen kann. Das ist im Normalfall auch schneller bei einem Vergleich.
Aber es lassen sich auch einzelne Characters veraendern und da beginnt der Spass.

.. code-block :: php

	<?php
	$str = 'hello world';
	$str{1} = 'b'; // hbllo world
	$str{9} = '456'; // hbllo wor4d

	$str{12} = 'c'; // hbllo wor4d c
	?>

Das 11. Zeichen am Ende ist in der Tat ein Leerzeichen. Soweit ist das alles noch 
expected behaviour wuerde ich sagen (bis auf Zeile 4).
Aber jetzt fuegen wir zu einem leeren String ein Zeichen hinzu:

.. code-block :: php
	
	<?php
	$str = '';
	$str{0} = 'a'; // array( 0 => 'a' )
	?>

Magic: $str ist nun ein Array. (And the Array is on a horse)

**Strings=>Array?**

Wir haben ja oben schon darueber gesprochen, dass man Strings als "Array"
ansprechen kann. Aber sind es wirklich Arrays?
Nein, es ist nur Beauty. Sie sind zum Beispiel nicht iterable, was 
eine foreach-Schleife unmoeglich macht:

.. code-block :: php

	<?php
	$str = 'foo';
	for ($i=0; $i<strlen($str); $i++)  {
		echo $str[$i];
	}
	// outputs: foo

	foreach ($str as $char) {
		echo $char;
	}
	// Warning: Invalid argument supplied for foreach() ...
	?>

Als Workaround wird str_split() vorgeschlagen...pff workaround...

Strings sind in PHP keine Character-Arrays...nein,nein,nein
und sie werden auch nicht so gecastet.
Wenn man einen String in ein Array castet, kriegt man nicht wie 
erwartet ein Character-Array. Nein, man bekommt ein Array
mit einem Element, naemlich dem String selber.

**Wir zaehlen einen String hoch**

Was viele nicht wissen: Es gibt die Moeglichkeit einen String hochzuzaehlen.
Ja, ihr habt richtig gehoert.

.. code-block :: php
	
	<?php
	$a = 'a';
	$a++; // 'b'
	?>

Nein, das ist kein Spass. Es hat sogar die lustige Angewohnheit,
wenn a = 'z' ist, auf 'aa' ueberzuspringen. Lustigerweise geht das 
aber nur mit ++.

Das ein a+1 nicht funktioniert, ist vielleicht noch verstaendlich, weil
dann a in ein Integer gecasted wird. Aber ein a-- haetten sie schon
einbauen koennen.

Arrays are FUN!
===============
Wo wir gerade schon bei Array-Artigen Elementen sind. Nehmen
wir mal richtige Arrays.

.. code-block :: php
	
	<?php
	foreach(array("08","09","10") as $k) {
		$a[$k] = $k;
	}

	array_shift($a);
	echo $a["10"];
	?>

Ihr werdet feststellen, dass der Index "10" nichtmehr existiert. Er hat noch 
nie als String existiert. 

Das ist genau das Gleiche Problem wie beim casten eines JSON-Objekts.
Die PHP Doku sagt dazu:

.. code-block :: plain

	A key may be either an integer or a string. 
	If a key is the standard representation of an integer, 
	it will be interpreted as such (i.e. "8" will be interpreted as 8, 
	while "08" will be interpreted as "08").

`http://www.php.net/manual/en/language.types.array.php <http://www.php.net/manual/en/language.types.array.php>`_


() != Funktion
==============

Zu mir sagte mal ein Professor in Funktionentheorie: Nicht alles was Klammern hat
ist eine Funktion.

So ist es in PHP auch. array() ist keine Funktion! Genausowenig ist print() oder
echo() eine.


.. code-block :: php

	<?php $a = 'array'; $a(); ?>


Fazit?
======
Ich habe nur wenige rausgegriffen. Es gibt noch einige mehr zu finden und 
ich bin ueber Tipps immer sehr Dankbar.
PHP ist so ueberfuellt, dass man garnicht weiss, wo man zuerst hinschauen soll

Wer sich dafuer interessiert lege ich:  `PHP Fractal of Bad Design <http://me.veekun.com/blog/2012/04/09/php-a-fractal-of-bad-design/>`_ ans Herz

so long
