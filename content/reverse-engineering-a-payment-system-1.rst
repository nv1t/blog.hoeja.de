Reverse Engineering a Payment System #1
#######################################
:date: 2011-03-24 10:28
:tags: en, nfc, payment system, reverse engineering, rfid

I think nearly nearly everybody wrote about this beyond believe hack of
Ploetz and Nohl on the `25c3`_. In addition the Nethamba Team did a
tremendous work with mfoc. 

So i won't bother you with that...go and read it elsewhere. 

But what do i have to do with NFC. In fact, it's pretty
simple to explain. A few weeks ago i began to reverse engineer a payment
system. I discovered by my curiosity, they are using mifare classics,
which has a security breach in the crypto1 cipher. 
Because some of the infrastructural devices are not connected to the network, the data of
the amount of money had to be stored on card. It was pretty simple to
create first dumps of the card on my laptop. Sometimes mfoc freezes up,
which has to do with a timing problem in the communication to the
reader. mfoc disables and enables the field to start the authentication
again and again, so the random number generator will be useless, because
it is based on timing. `(read up about the security)`_. 

I patched this problem, coz it started getting onto my nervs. I had the first
dump...but what to do with it...i was to frightened to write it back
onto the card. I didn't know back then, what would happen, if the dump
ist corrupted or similar. In addition, i didn't have any blanko cards
around. 

So i got bored with the dump and forgot about it a few weeks,
until my blanko cards from HongKong arrived :) I was sitting in a train
to my parents and tried writing the dump i created earlier writing to
the blanko card. No error occured. I expected at least some difficulty
in writing the card. 
But nothing. I was stunned...wasn't sure if it
worked. 

So i decrpyted the sectors and matched them up with the dump
from the original...it was the same data...the uid differed, but
sector00 is not writable at all. But i wasn't sure, if it would work,
coz of the uid. I expected at least an error, that the uid wasn't in the
database or similar. I couldn't check that, for nearly 3 days. That were
the hardest days of my life. I was sitting at home. I couldn't hold it
anymore, got into a car and drove there. First i checked my real card.

It was working fine, was expected. I put the Blanko Card in...and it
showed me the same amount of money. I couldn't believe it. So i figured,
they still could be connected somehow. so i bought something from my
real card, and checked the blanko card afterwords. Nothing changed. That
was my first breakthrough. But i didn't want to leave it there. I
checked and was able to write the dump back onto the card every time. I
still had no idea, where the information was stored and I wasn't able to
change the amount of money. I needed more data. During the next few
weeks i gathered as much as possible. 

Friends were able to come by and
swipe there card, so i would get a dump with precise information about
the amount of money which should be at least stored somewhere. atm i
have around 10 different cards with minimum of 10 Datapoints. I thought
i would get the information after 2-3 days more...but in fact, i know
where the data should be stored, but i can't prove it...and i can't
change it. It seems there is some kind of checksum which fucks the whole
card up, if you change 1 inzy winzy tiny bit. For cryin' out loud...it's
frustrating to look at the card and know: you didn't get it this
time...try again, and again... 

so long

.. _25c3: http://events.ccc.de/congress/2008/Fahrplan/events/3032.en.html
.. _(read up about the security): http://eprint.iacr.org/2008/166
