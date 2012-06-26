twitter und seine beziehungen
#############################
:date: 2011-11-29 02:36
:tags: cluster, de, nodejs, twitter

Vor einiger Zeit hab ich mich gefragt wie schwer es wohl ist
Beziehungsgraphen aus Twitter aufzubauen. Also hab ich mich hingesetzt
und einen Twitter Crawler geschrieben. An sich ist das nicht sonderlich
kompliziert, nachdem Twitter ja selber schon die Daten in json Form
liefert.

Profil
~~~~~~

::

    [{
        "profile_background_tile": false,
        "time_zone": "Greenland",
        "protected": false,
        "follow_request_sent": null,
        "profile_sidebar_fill_color": "DDEEF6",
        "name": "nuit",
        "default_profile_image": false,
        "created_at": "Fri May 06 18:50:41 +0000 2011",
        "friends_count": 109,
        "followers_count": 33,
        "profile_image_url": "http:\/\/a0.twimg.com\/profile_images\/1621062051\/121018444592_normal.jpg",
        "verified": false,
        "utc_offset": -10800,
        "profile_sidebar_border_color": "C0DEED",
        "description": "researching my way to happiness",
        "screen_name": "nv1t",
        "is_translator": false,
        "default_profile": true,
        "statuses_count": 782,
        "following": null,
        "profile_use_background_image": true,
        "profile_background_image_url_https": "https:\/\/si0.twimg.com\/images\/themes\/theme1\/bg.png",
        "favourites_count": 258,
        "status": {
            "place": null,
            "retweet_count": 0,
            "in_reply_to_screen_name": "Suizidkatze87",
            "geo": null,
            "coordinates": null,
            "retweeted": false,
            "created_at": "Thu Nov 24 02:02:36 +0000 2011",
            "in_reply_to_status_id_str": "139523474409525251",
            "in_reply_to_user_id_str": "355292723",
            "contributors": null,
            "in_reply_to_status_id": 139523474409525251,
            "id_str": "139524284619034624",
            "truncated": false,
            "source": "web",
            "in_reply_to_user_id": 355292723,
            "favorited": false,
            "id": 139524284619034624,
            "text": "@Suizidkatze87 ich auch :) haaaaaalllooooo :)"
        },
        "notifications": null,
        "profile_text_color": "333333",
        "contributors_enabled": false,
        "geo_enabled": true,
        "profile_background_image_url": "http:\/\/a0.twimg.com\/images\/themes\/theme1\/bg.png",
        "location": "",
        "id_str": "294216371",
        "profile_link_color": "0084B4",
        "profile_image_url_https": "https:\/\/si0.twimg.com\/profile_images\/1621062051\/121018444592_normal.jpg",
        "show_all_inline_media": false,
        "listed_count": 1,
        "url": "http:\/\/nuit.homeunix.net\/",
        "id": 294216371,
        "lang": "en",
        "profile_background_color": "C0DEED"
    }]

Friendslist
~~~~~~~~~~~

::

    {
        "next_cursor": 0,
        "previous_cursor": 0,
        "ids": [387615393, 249170143, ..., 49571362, 95750938],
        "next_cursor_str": "0",
        "previous_cursor_str": "0"
    }

Twitter macht nur 150 Zugriffe pro Stunde moeglich (basierend auf der
IP), wenn man nicht angemeldet ist. Leider kann man diese Sperre auch
nicht wirklich umgehen, nachdem sie basierend auf der IP ist. Wenn man
angemeldet ist,sind 350 Zugriffe moeglich, aber das geht auch nur pro
Loginnamen. Ich bin aber einen weiteren Weg gegangen. In nodejs hab ich
schnell einen kleinen Server gebastelt, der im Prinzip als Kopf eines
kleinen Clusters wirkt, dem man immer Clients hinzufuegen oder wegnehmen
kann und es hat keinen Einfluss auf die Ausfuehrung:

::

    var fs = require('fs');
    var net = require('net');

    function inArray(str,array) {
      for(i in array) {
        if(array[i] == str) return true
      }
      return false
    }

    var todo = []
    var hooks = {
        'get':function(data) {
          return (todo.length > 0 ? todo.pop(0).toString() : '')
        }
      , 'save': function(data) {
          try {
            stats = fs.lstatSync('data/'+data[1]);
          } catch(e) {
            fs.writeFile('data/'+data[1],data.slice(2).join(' '),function(err){});
          }
          return '';
        }
      , 'add': function(data) {
          try {
            stats = fs.lstatSync('data/'+data[1]);
          } catch(e) {
            if(typeof data[1] != 'undefined') {
              if(!inArray(data[1],todo)) todo.push(data[1])
            }
          }
          return '';
        }
      , 'clear': function(data) {
          todo = []
          return '';
        }
      , 'list': function(data) {
          return JSON.stringify(todo);
        }
    }

    fs.readFile('backup', function (err, data) {

      try{
        todo = JSON.parse(data.toString('utf8'))
      } catch(e) {
        todo = []
      }

      console.log('Server started')
      var server = net.createServer(function (socket) {
        socket.on("data",function(data) {
          str = data.toString('utf8').replace (/^\s+/, '').replace (/\s+$/, '').split(' ')
          if(str[0] in hooks) socket.end(hooks[str[0]](str)+'\n')
        });
      });

      setInterval(function(){
        fs.writeFile('backup',JSON.stringify(todo),function(err){});
      },5000)
      server.listen(8082,'127.0.0.1');
    })

Ja ich weiss, dass er Sicherheitsluecken enthaelt. Es war ein Proof of
Concept und horcht auch nur intern :) Das ist aber erst die halbe Miete.
Die Arbeit wird immer noch von den Clients erledigt. Diese kriegen bloss
eine ID des neuen Benutzers, die sie abarbeiten muessen. Die Ergebnisse
liefern sie wieder ab.

Aktuelle Probleme:
==================

-  Die Freundesliste wird voller und voller und voller. Eine
   Moeglichkeit waere das in eine Datenbank abzuspeichern und dann immer
   nur kurz einen rauszuholen, oder einfach 10 Leute im Speicher zu
   halten. Es geht aber auch die Dateien herzunehmen in denen ich die
   Freundesliste abspeicher, aber dann stellt sich die Frage, wie
   markier ich eine als schon benutzt, nachdem immer mal wieder welche
   dazwischenrutschen koennen?
-  Teilweise gibt es Probleme in der Uebertragung..Ich weiss noch nicht
   woran das liegt, ob es ein Zeichensatzproblem oder ein Gedankenfehler
   ist...ich konnte es auch noch nicht reproduzieren den Fehler
-  Ich habe nicht soviele unterschiedliche IPs, als dass sich so ein
   Projekt lohnen wuerde. Dazu muesste das Monatelang laufen.

Ich weiss noch nicht, was die naechsten Schritten sein werden.
Wahrscheinlich Server absichern und nach aussen Oeffnen. Hoffen, dass
moeglichst viele Leute mithelfen und mehrere Clients schreiben. Vorallem
keinen Aerger mit Twitter kriegen. so long edit: ich twitter wie ich
versuche twitter zu crawlen...ob das so eine gute idee ist...
