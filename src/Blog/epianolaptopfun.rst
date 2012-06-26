epiano+laptop=fun
#################
:date: 2011-09-13 11:44
:tags: de, epiano, music, reverse engineering, visualization

Vor ungefaehr einem Jahr hatte ich die Idee ein Konzert zu schaffen,
welches Live Visualisierungen macht von Midi Input. Ich hab mich danach
nie wieder damit auseinandergesetzt, ausser versucht ueber wav/mp3
Dateien FFTs laufen zu lassen. Ein guter Freund hat mich gefragt, was
der USB-Port an meinem epiano soll und ob ich weiss, warum es einen hat.
Das hat mich nun selber interressiert, also Laptop angeschlossen und
angefangen Daten auszulesen. Zuerst hab ich vermutet, dass es Midi Daten
sind. Aber weit gefehlt. Es gibt sich zwar als Midi Device, aber die
Informationen sind nicht nach dem Midi Protokoll aufgebaut. Also hab ich
selber ein kleines Skript geschrieben, was mir die Noten ausliest (man
kriegt auch Lautstaerke der Note und noch eine Zahl, von der ich nicht
weiss, was sie tut, weil sie sich nicht aendert)

::

    #!/usr/bin/env python
    import os

    fh = os.open('/dev/midi1',os.O_RDONLY)
    i=1
    buff=[]
    noten=['C','C#','D','D#','E','F','F#','G','G#','A','A#','H'];
    while True:
        buff.append(ord(os.read(fh,1)))
        if i % 3 == 0:
            if buff[2] != 0:
                print(noten[buff[1]%12])
            buff=[]
            i=0
        i=i+1

soviel dazu. Gerade les ich mich in pygame ein um die Sachen auch noch
zu visualisieren. Man darf gespannt sein :) edit: ich moechte mich
entschuldigen...der obige code ist absolut haesslich und garnicht im
python stil...ich war an dem abend anscheinend muede:

::

    #!/usr/bin/env python2
    import os

    fh = os.open('/dev/midi1',os.O_RDONLY)
    while True:
        buff=[]
        for i in range(3): buff.append(`ord(os.read(fh,1))`)
        open('test', 'w').write(':'.join(buff)+'\n').close()

mir faellt grad keine schoenere loesung ein :)
