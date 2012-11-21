Wo ist der Brunnen?
###################
:date: 2011-09-23 14:52
:tags: de, mathematics, python

Vor einiger Zeit hab ich im Lehrbuch einer Freundin die Lehramtsmathe
studiert eine Aufgabe gesehen, die sich fuer Bildgenerierung
praedistiniert hat.

    Auf einer Wiese sind $$n$$ Brunnen verteilt. Ein armer Schafhirte
    will nun immer den kuerzesten Weg zu jedem Brunnen wissen, um seine
    Schafe nicht zu weit treiben zu muesse. Hilf ihm und erstelle eine
    Karte auf der die Bereiche farbig ausgemalt sind. Erklaere
    anschliessend, wie dieses Muster zustande kommt.

Ich hab die Haudrauf Methode gewaehlt :) Ich pruefe einfach alle Pixel
und waehle den naehsten Brunnen aus. Man kann das ganze noch optimieren,
wenn man bei einem Nachbarpixel nurdie naehsten Brunnen ausprobiert,d.h.
sich eine Liste speichert und dadurch immer nur die ersten 3-4 Brunnen
probiert, aber das macht bei 10 Brunnen und einer Bildgroesse von 500px
auf 500px nicht viel aus. Hier ist also der Code:

 .. code-block :: python

    #!/usr/bin/env python2
    import math,random,sys
    import Image, ImageDraw # I'm using PIL :)

    dimensions = (500,500)
    points = []
    color = []

    # ten random points are chosen and random colours are applied
    for x in range(10):
        p = tuple(random.randint(0,500) for i in range(2))
        points.append(p)
        color.append(tuple(random.randint(0,255) for i in range(3)))

    out = Image.new('RGB',(dimensions),None)
    pix = out.load()

    # go through every pixel out there
    for x in range(dimensions[0]):
        for y in range(dimensions[1]):

            # just to set the distance long enough
            shortestDistance=500*1.5
            for i in range(len(points)):

                # calculates the distance from the pixel to one  well
                d = math.sqrt((x-points[i][0])**2+(y-points[i][1])**2)

                # if the new distance is shorter then the last, save it and colour the pixel
                if d < shortestDistance:
                    shortestDistance=d
                    pix[x,y] = color[i]

    out.save(sys.stdout, "PNG")

Nicht wundern ich zeichne die Brunnen nicht mit ein. Liese sich aber ja
noch leicht unterbringen :) Er gibt das direkt auf der Konsole aus, kann
aber einfach umgeleitet werden mit:

 .. code-block :: bash

    $ ./brunnen.py > image.png

Ich hab das ganze auch noch mit pygame gemacht, aber lassen wir es bei
PIL ;) achja...und so sieht das dann aus: 

|Brunnenproblem| 

so long


.. |Brunnenproblem| image:: http://images.hoeja.de/blog/image-300x300.png
