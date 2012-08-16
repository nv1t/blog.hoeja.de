Wordpress-Theme Horror!
#######################
:date: 2012-08-16 13:04
:tags: de, php, wordpress

Vor ein paar Tagen ist auf einer Wordpress Seite einer Freundin etwas seltsames passiert.
Die Seite kam rueber als waere sie gehackt wurde, auch ist im Footer (genauer gesagt im Copyright)
ein iframe gewesen, welches die Weiterleitung klar verursachte.
Aber was genau war passiert...
Die Wordpress Version war/ist auf dem neusten Stand, also wurde erstmal ein 0-day Vermutet.
Bevor man sich aber darum kuemmern kann, sollte man erstmal die Seite wieder laeuffaehig machen.
Backup ist wohl der erste Gedanke. Doch auch ein einspielen des Themes brachte keiner Linderung
der Probleme. 

Also wird das Copyright wohl in der Datenbank abgespeichert (Ich kenne Wordpress vom Aufbau leider nicht so gut...)

Nachdem man nichts ueber dieses iframe gefunden hat (auch ein grep auf alle Dateien machte es nicht sichtbar) war guter Rat
teuer.

Dann entdeckte ich in einer Datei des Themes interessante Strukturen ala:

 .. code-block :: php

	eval(gzinflate(base64_decode(....));

Das machte mich stutzig und ich wunderte mich, dass jemand soweit gehen wuerde es direkt in das Theme zu schreiben.
Nachdem wir ja ein Backup des Themes aufgespielt haben, muss es wohl schon vorher drin gewesen sein. Aber wer bitte 
"verschluesselt" seine Sachen.
Noch Mysterioeser wurde es, als ich das nicht direkt decodieren koennte, sondern an die 20 Durchlaeufe brauchte.
Zum Glueck kann ich bashen, was mir das Leben ein wenig erleichterte

 .. code-block :: bash

	I=0
	TEMP=$(mktemp)
	while :; do
		FILE="output${I}"
		I=$(($I+1))
		NEWFILE="output${I}"
		echo '<?php' > $TEMP
		cat "${FILE}" | sed 's/eval/print/' >> $TEMP;
		php "$TEMP" > "${NEWFILE}"
		cat ${NEWFILE}
		read
	done;

Dadurch krieg ich alle Zwischenversionen und ich seh gleich, wenn es decodiert ist.

Interessanterweise hatten alle Verschluesselten Abschnitte mit dem Copyright zu tun.
Mal abgesehen von seltsamen Abschnitten die Zwingend das Copyright in der footer.php wollen:

 .. code-block :: php

	<?php
	function check_theme_footer() { 
		$uri = strtolower($_SERVER["REQUEST_URI"]); 
		if(is_admin() || substr_count($uri, "wp-admin") > 0 || substr_count($uri, "wp-login") > 0 ) { /* */ } 
		else { 
			$l = '<?php wp_copyrighted(); ?>'; 
			$f = dirname(__file__) . "/footer.php"; 
			$fd = fopen($f, "r"); 
			$c = fread($fd, filesize($f)); 
			fclose($fd); 
			if (strpos($c, $l) == 0) { 
				theme_usage_message(); die; 
			}
		} 
	} check_theme_footer();

sind die meisten Abschnitte relativ harmlos und waren auch "nur" ein eval(base64_decode(...));

Doch es gab einen Abschnitt der mich schon ein wenig stutzig gemacht hat.
Man muss dazu sagen, dass der Abschnitt ueber eine etliche Laenge geht, aber nur eine einzige Zeile enthaelt:

 .. code-block :: php

	<?php
	$template_id =622;
	include_once get_theme_root() . '/' . get_template() . '/wp_funcs.php';

Die wp_funcs.php ist nochmal nach dem gleichen Muster 20mal base64 + gzip gedingst.

Und dadrin sind seltsamte Sachen. Einerseits gibt es eine "Colorize" Klasse, die eine Art Verschluesselung darstellt.
Also definieren wir uns hier eine Verschluesselung innerhalb einer Verschluesselten Datei.

Aber das ist noch nichtmal das schlimme, sondern die paar Zeilen inklusive der Klasse "RemoteContent":

 .. code-block :: php

	<?php
	$call_url = $color->showstyle($key,base64_decode('hprlKsOyj7rDeAreG7wxsAAxeLe8rmPVyU4wkBWm+edKBk9Axb3eDk0='));
	$xmlfile  = $color->showstyle($key,base64_decode('nZr8dIHwzA=='));

Also phpsh angeworfen um mal zu sehen, was da ueberhaupt drin steht.
Es ist wirklich eine call url.

Zudem ist hier auch noch ein Cache implementiert, die die xml Datei cachen soll. Solangsam werd ich neugierig, was das fuer eine
XML Datei sein soll.

 .. code-block :: xml

	<?xml version="1.0"?>
	<data>
		<site url="base64 encodierte url" expire="20-08-2012 10:28:18">
			<link>PCFET0NUWVBFIGh0bWwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMDEgVHJhbnNpdGlvbmFsLy9FTiI+CjxodG1sPgo8aGVhZD4KPHRpdGxlPkNvbnRhY3QgU3VwcG9ydDwvdGl0bGU+CjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4KPC9oZWFkPgo8Ym9keSBtYXJnaW53aWR0aD0iMCIgbWFyZ2luaGVpZ2h0PSIwIiBsZWZ0bWFyZ2luPSIwIiB0b3BtYXJnaW49IjAiPgo8aWZyYW1lIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZyYW1lYm9yZGVyPSIwIiBTQ1JPTExJTkc9ImF1dG8iIG1hcmdpbndpZHRoPSIwIiBzcmM9Imh0dHA6Ly9zZWFyY2hkaXNjb3ZlcmVkLmNvbS8/ZG49cmVmZXJlcl9kZXRlY3QmcGlkPTVQT0w0RjJPNCI+PC9pZnJhbWU+CjwvYm9keT4KPC9odG1sPgo=</link>
		</site>
	</data>

Wow...ich habe meinen Iframe gefunden! Aber warum wird der gecached, wo kommt er her, und was passiert ueberhaupt alles.
Anscheinend macht das Theme einen RemoteCall zu einem Server und laedt sich eine XML Datei, bzw. einen Content, den er einbinden muss.

Es gibt auch lustigerweise noch einen "checkValid()" Funktion, die einen String zusammenbaut, der dann an einen RemoteServer geschickt wird.
Ich mache mir Sorgen, was da wohl alles rausgeschickt wurde, bzw. dass ich irgendwas uebersehe.

Also starte ich auf meinem Testserver ein tcpdump um die Meldungen exakt mitzuloggen, was eigentlich fuer Calls im Hintergrund durchgehen:

.. image:: http://images.hoeja.de/blog/wiresharkdump.png
	:width: 800px

Es wird also ein GET Request aufgerufen, der einen base64 Encodierten Datensatz uebertraegen. (wer haette es gedacht...)
Die Uebertragung geht an shayup.com. Ein whois loest auf, wer da wohl dahintersteht:

::

	Technical Contact:
	Forex Profit Land
	truong thanh luan (raphael.svery@gmx.com)
	+84.946299786
	Fax: +1.5555555555
	39 hong lac , phuong 10
	Tan Binh, P 70000
	VN

Es existiert von diesem svery nicht nur eine Adresse in China, sondern auch eien in Israel und sicher noch etliche andere.

Aber die Frage ist, was wohl wirklich uebertragen wird:

::

	template_id=622|callback=http://10.42.9.213/wordpress/|wpver=3.4.1|themename=PinkWind|php=5.3.3-7+squeeze13|email=xxx@xxx.com|uri=/wordpress/|url=10.42.9.213|status=2

D.h. shayup.com weiss, welches Theme von ihnen wo eingesetzt wird, inklusive dem Ansprechparter, bzw die Emailadresse des Benutzers.
Zum Glueck werden keine weiteren Daten uebertragen, so schaut es zumindest aus. 

Aber selbst das ist schon schlimm genug!

Und was bleibt mir dazu als Fazit zu sagen? Fremde Themes nehmen ist boese. Ich werde deutlich mehr aufpassen, was ich nehme und wo ich es einsetze. Es koennten auch Passwoerter uebertragen werden, oder andere Dateien. Man laedt fremden SourceCode auf seine Seite!

so long
