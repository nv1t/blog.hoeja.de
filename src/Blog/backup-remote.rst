Backups mit rsync
#################
:date: 2012-08-31 15:21
:tags: de, backup, rsync

Ich wollte unbedingt regelmaessige Backups meiner Laptop Festplatte
auf meinen Festrechner auf der Arbeit machen.

Nachdem mir das von Hand nach einer Zeit ziemlich auf die Nerven ging,
schrieb ich ein kleines Script um genau das zu erledigen.
Rausgekommen ist ein nettes kleines rsync script, welches ueber ssh
regelmaessige Backups macht (wenn man es ausfuehrt)


.. code-block :: bash

	date=`date "+%Y-%m-%d"` 
	HOME="/home/jan/" # Directory to be backed up
	REMOTEDIR="/home/jan/Backups/seda" # Remote Directory to be back in
	BACKUPHOST="jan@10.42.1.112" # Remote User and Host
	KEYFILE="-i $HOME/.ssh/keyfile" # if you want to set a keyfile

	rsync -azP \
	  --delete \
	  --delete-excluded \
	  --exclude-from=$HOME/.config/rsync/exclude \
	  --link-dest=../current \
	  -e "ssh $KEYFILE" \
	  $HOME $BACKUPHOST:$REMOTEDIR/incomplete_back-$date \
	&& ssh $KEYFILE $BACKUPHOST \
	  "mv ${REMOTEDIR}/incomplete_back-$date ${REMOTEDIR}/back-$date \
	    && rm -f ${REMOTEDIR}/current \
	    && ln -s back-$date ${REMOTEDIR}/current"

Das Script setzt, wenn die Datei schon im Backup existiert einen Hardlink.
Es betrachtet aber nur den letzten Backup.
Sollte etwas schiefgehen, bleibt immer noch der incomplete Ordner vorhanden

"seda" ist in dem Fall de Name meines Rechners. Ich speichere Backups fuer
mehrere Rechner in einem Backups Verzeichnis. 
Zudem wird nicht alles uebertragen, sondern aus dem current genommen.

so long
