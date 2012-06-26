half root is not root at all!
#############################
:date: 2012-04-04 18:16
:tags: de, ssh, there i fixed it

Ich habe gestern ein neues Spielzeug in die Hand gekriegt. Mein
eigentliches Ziel war es, es nicht aufzuschrauben, bin aber gaenzlich an
der Vorgabe gescheitert. Diese Box hat mich die letzten 2 Tage fast zur
Weissglut getrieben und ich habe viel Ausprobiert und viel gescheitert.

|image0|

Um euch mal einen Ueberblick ueber das Geraet zu geben,
werde ich NICHT die ganzen Spezifikationen aufzaehlen, weil man diese
auch einfach nachlesen kann: `spinetix hmp130`_ Das Teil ist nicht
gerade billig. Man munkelt es bewegt sich um die 1200 Euro. Waehrend des
Updates konnte ich das Update Package rausfiltern, was mir einige
Insights in das Geraet gegeben hat, weil dieses naemlich so aussieht:

::

    --__===== SPINETIX INSTALLATION IMAGE =====__--
    --__===== HEADER START =====__--
    VERSION=2.2.3
    RELEASE=0.2.13448
    PRODUCT=HMP130
    SIGNATURE=-----BEGIN PGP SIGNATURE-----
    SIGNATURE=
    SIGNATURE=
    SIGNATURE=
    SIGNATURE=
    SIGNATURE=-----END PGP SIGNATURE-----
    --__===== HEADER END =====__--
      -
    --__===== SCRIPT START =====__--

    --__===== SCRIPT END =====__--
     -
    --__===== ARCHIVE =====__--

im tgz Archiv findet sich die komplette Root Struktur eines Unix
Systems...prickelnd denkt man sich, aber da wurde soviel gebastelt, dass
es nicht spass macht ein nicht lauffaehiges zu haben. Eine Root-Shell
musste her. Ich wusste ja, dass ein was Unixiges drauf laeuft (erste
Vermutung FreeBSD). Es gibt auch einen sshd

::

    root@spx-hmp-:/etc/init.d# ls
    README        hwwatchdog       ntp-drift-fixup    setserial
    apache        identify.sh      ntpdate        single
    avahi-autoip  ifupdown         ntpreset.sh        skeleton
    avahi-daemon  ifwatchdog       nviboot        snmpd
    bootclean.sh  init-functions       ppp            splash
    bootcount     ipv6.sh          proc.sh        spxdevs.sh
    bootlogd      klog-dump.sh     procps.sh          spxformat.sh
    bootmisc.sh   makedev          raperca        spxfschange.sh
    bootpause.sh  media-mount.sh       raperca-admin      spxtest
    checkfs.sh    module-init-tools    raperca-content-fixup  spxtest-watchdog
    checkroot.sh  mountall.sh      raperca-mdns       ssh
    config.sh     mountnfs.sh      raperca-watchdog   ssh-delayed
    cron          mountswap.sh     rc             syslog
    devpts.sh     mountvirtfs      rcS            udev
    devshm.sh     mountvirtfs-early    reboot         umountfs
    fc-cache.sh   msttcorefonts    resolver.sh        umountnfs.sh
    halt          mtab.sh          rmnologin          updater
    hostname.sh   networking       rootsize.sh        uploader
    hosts.sh      nfsroot-dhcpcd-hack  sendsigs       urandom
    hotplug       nscd         serconsole.sh      vidmode
    hwclock.sh    ntp          setdate.sh         watchdog

Ein "Pwn"-Package kann man nicht so einfach zusammenstellen, weil man es
signen muss, und dazu hab ich den Private-Key nicht, der von noeten
waere. Ich kann nur Pruefen, ob ein Paket auch wirklich von der Quelle
kommt, weil auf der Box der Public-Key hinterlegt ist :) Also das
Package Update faellt schonmal ins Wasser, bevor wir nicht mehr drueber
wissen. Von Kollegen habe ich gehoert, dass sich in der Karte eine
SD-Karte befinden soll,auf der das gesamte System zu finden ist. Das
deckt sich auch mit dem Installer-Bash-Script, der eine SD Karte
formatiert und in 3 Teile aufteilt.

::

    nrblocks="$(sfdisk -s /dev/mmcblk0)"

Nachdem die Moeglichkeit ueber Paket-Injection ausfaellt, muss ich wohl
in den sauren Apfel beissen und die Box aufschrauben: 

|image1| 

Im naechsten Bild, seht ihr auch den Angriffspunkt eingekreist. Darin
befindet sich eine 4gb SD Karte mit insgesamt 3 Partitionen 

|image2|

Die erste Partition ist die System Partition, natuerlich sehr
interessant. Auf der 2. Werden die Daten gespeichert und ist mit 3gb die
mit abstand groesste. Die letzte ist "nur" ein Backup eines alten
Systems und existiert auch nur, wenn das Backup aufgehoben werden soll.
Nun hiess es erstmal verstehen, was machen die einzelnen Prozesse...mir
viel auf, dass ssh-delayed als service selten aufgerufen wird. Es gibt
aber einen Fall, und zwar gibt es in einer Maintenance Klasse des
Frontends 2 Methoden:

::

        function checkSSH () {
            exec('/etc/init.d/ssh-delayed status', $dummy, $ret);
            return $ret==0;
        }

        function manageSSH( $start=true ) {
            if ( $start ) {
                exec('/etc/init.d/ssh-delayed start');
            } else {
               exec('/etc/init.d/ssh-delayed stop');
            }
        }

Ich war mir sicher, dass sowas existieren muss, irgendwie muessen die ja
den SSH Dienst starten. Nur haette ich das ueber ein signiertes Package
gemacht. Entweder man implementiert den Button nun selber, oder man
updated auf die neue Firmware, die das mit sich bringt versteckt
darunter: 

|image3|

Das startet auf Port 22 eine Shell. Das nuetzt uns
aber ziemlich wenig. Wir kennen weder das Root-Password, welches wir nur
verschluesselt besitzen, noch besitzen wir den Private-Key zu dem
eingetragenen Public-key des Supports. Wer sich berufen fuehlt, hier ist
mal das RootPasswort. Es ist ein FreeBSD md5 Hash:

::

    root:$1$U4.8u2Dh$UvJpU6AsN912qFZGBvUtN/:0:0:root:/root:/bin/bash

Wir koennen jetzt einfach das Root-Password natuerlich austauschen. Aber
das ueberschreibt sich bei einem Update wieder. Es gibt aber ein
Verzeichnis, das bleibt...und da werden ssh-keys eingetragen, was uns
die ganze Sache natuerlich erleichtert:

::

    root@spx-hmp-idderbox:/usr/share/resources/default/ssh# ls
    root-authorized_keys

unseren key da eingetragen, haben eine Root-Shell :) Please Keep in
Mind: Das Eintragen muss ich durch Modifikation der SD-Karte machen.
Demnach muss die Box aufgeschraubt werden, wodurch die Garantie
NATUERLICH erlischt. Aber ich werde mich in den naechsten Wochen mit
einer tieferen Analyse der Software beschaeftigen. Vielleicht findet
sich noch eine Backdoor in der Key-Verification :) und um zu Zeigen,
dass ich wirklich eine Root-Shell habe: 

|image4|

Jetzt ist die Frage,
ich habe mir MontaVista Linux Professional nicht angeschaut...d.h. keine
Ahnung worauf es direkt basiert. Leider ist es nur ein halber Hack und
der Hackvalue ist sehr gering. Er ist zurzeit nur zur Analyse der Box im
laufenden Betrieb gedacht und Versuchsweise Nachpatchen mit OpenVPN oder
aehnlichem :) Ich betrachte es erst als geknackt, wenn ich per Remote es
veraendern kann! Theoretisch kann ich den Public-Key austauschen, aber
dann muss ich jedes Update Package intercepten und neu signieren :-/
zudem muss ich jedes Geraet anfassen und die SD neu schreiben und bei
jedem Update aufpassen, dass es mir keine Configs ueberschreibt...viel
zu viel Arbeit! An den Private Key werde ich nicht kommen...der liegt
auf den Rechnern/Servern von Spinetix, demnach unerreichbar. so long

.. _spinetix hmp130: http://www.spinetix.com/hmp130/specifications

.. |image0| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/04/2012-04-04-192947_432x284_scrot-300x197.png
.. |image1| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/04/DSC_4089-300x199.jpg
.. |image2| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/04/DSC_4091-300x199.jpg
.. |image3| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/04/2012-04-04-191423_585x183_scrot-300x93.png
.. |image4| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/04/2012-04-04-164035_1024x768_scrot-300x208.png
.. |image5| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/04/2012-04-04-192947_432x284_scrot-300x197.png
.. |image6| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/04/DSC_4089-300x199.jpg
.. |image7| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/04/DSC_4091-300x199.jpg
.. |image8| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/04/2012-04-04-191423_585x183_scrot-300x93.png
.. |image9| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2012/04/2012-04-04-164035_1024x768_scrot-300x208.png
