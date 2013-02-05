gps in bildern
##############
:date: 2011-11-23 20:18
:tags: de, gps

Ich weiss, dass dieses Problem nicht gerade neu ist und ich hab leider
auch kein Smartphone um dem ganzen ein wenig naeher auf den Grund zu
gehen. Mir ist vor einiger Zeit bewusst geworden, dass sich GPS
Informationen in jpges abspeichern lassen, aufgrund der EXIF
Informationen. Es gibt GPS Module fuer Kameras um eben genau das zu
erreichen, ein Bild laesst sich einem Ort zuordnen. Aber das ganze wirft
ein bisschen weitere Probleme auf: Betrachten wir das Aufkommen der
Smartphones. Smartphones haben fuer gewoehnlich einen GPS Empfaenger
integriert, auch eine Kamera gehoert inzwischen zur Standardausstattung.
Anscheinend speichern die heutigen Smartphones diese GPS Informationen
in den Bildern ab. Das ist an sich nicht schlimm. Schlimm wird es, wenn
dieses Bild hochgeladen wird. Facebook ist anscheinend schon relativ
frueh auf den Trichter gekommen und loescht jegliche Informationen aus
dem Bild. Dies bedeutet aber nicht, dass sie diese nicht selber
verwenden. Wie sieht das im Bild aber nun aus:

::

    19:18:14 seda:~/dev/twitter/twitpic/
    % exiftool data/tomhanks/16m8un.jpg
    ExifTool Version Number         : 8.70
    File Name                       : 16m8un.jpg
    Directory                       : data/tomhanks
    File Size                       : 95 kB
    File Modification Date/Time     : 2011:11:16 13:11:49+01:00
    File Permissions                : rw-r--r--
    File Type                       : JPEG
    MIME Type                       : image/jpeg
    JFIF Version                    : 1.01
    Exif Byte Order                 : Big-endian (Motorola, MM)
    Make                            : Apple
    Camera Model Name               : iPhone 3GS
    X Resolution                    : 72
    Y Resolution                    : 72
    Resolution Unit                 : inches
    Software                        : 3.1.2
    Modify Date                     : 2010:03:04 16:35:16
    Y Cb Cr Positioning             : Centered
    Exposure Time                   : 1/60
    F Number                        : 2.8
    Exposure Program                : Program AE
    ISO                             : 81
    Exif Version                    : 0221
    Date/Time Original              : 2010:03:04 16:35:16
    Create Date                     : 2010:03:04 16:35:16
    Shutter Speed Value             : 1/60
    Aperture Value                  : 2.8
    Metering Mode                   : Average
    Flash                           : No flash function
    Focal Length                    : 3.9 mm
    Flashpix Version                : 0100
    Color Space                     : sRGB
    Exif Image Width                : 600
    Exif Image Height               : 800
    Sensing Method                  : One-chip color area
    Exposure Mode                   : Auto
    White Balance                   : Auto
    Sharpness                       : Soft
    GPS Latitude Ref                : North
    GPS Longitude Ref               : West
    GPS Time Stamp                  : 16:35:12.4
    Image Width                     : 600
    Image Height                    : 800
    Encoding Process                : Baseline DCT, Huffman coding
    Bits Per Sample                 : 8
    Color Components                : 3
    Y Cb Cr Sub Sampling            : YCbCr4:2:0 (2 2)
    Aperture                        : 2.8
    GPS Latitude                    : 40 deg 45' 50.40" N
    GPS Longitude                   : 73 deg 59' 0.60" W
    GPS Position                    : 40 deg 45' 50.40" N, 73 deg 59' 0.60" W
    Image Size                      : 600x800
    Shutter Speed                   : 1/60
    Focal Length                    : 3.9 mm
    Light Value                     : 9.2

Wie ihr am Directory erkennen koennt, ist das ein Bild von tomhanks, wer
wissen will welches: `http://twitpic.com/16m8un`_ Wir wissen nun, er hat
ein iPhone 3GS und wir kennen nun den Ort wo das Bild gemacht wurde.
Diese Daten sind natuerlich auch dann enthalten, wenn eigentlich kein
Ort mit dem Bild assoziiert werden sollte. Ich schaue derzeit nur auf
twitpic, welche anscheinend die Informationen nicht loesche. (waere
Wuenschenswert) Es gibt noch etliche andere Beispiele und Personen. Wenn
ich mehr hab, schreibe ich natuerlich drueber. so long

.. _`http://twitpic.com/16m8un`: http://twitpic.com/16m8un
