Reverse Engineering a Payment System #2
#######################################
:date: 2011-04-01 15:08
:tags: en, nfc, numerics, payment system, reverse engineering, rfid

i prepared two different card outputs (just excerpts) to compare them.
The first card is a guestcard, which you can buy without beeing registered in the system. The part i left out, is a not encrypted and empty sector which is totaly unimportant.
The card has the UID: aa257c3c which are the first bytes of the card.

 .. code-block :: plain

    0000000: aa25 7c3c cf88 0400 468e 6652 5d10 3306  .%|<....F.fR].3.
    0000010: 3202 0000 0138 0138 0138 0000 0000 0000  2....8.8.8......
    0000020: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    [...]
    0000070: a0a1 a2a3 a4a5 ff07 8069 b0b1 b2b3 b4b5  .........i......
    0000080: 0450 00ff 002b d500 0000 0000 0000 0000  .P...+..........
    0000090: 0003 0300 0000 0000 0000 0000 0000 3d9d  ..............=.
    00000a0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    00000b0: a0a1 a2a3 a4a5 7877 8869 eaed bbd5 9784  ......xw.i......
    00000c0: ff98 b79a be06 578b bd47 d545 51e7 fddd  ......W..G.EQ...
    00000d0: adcf 9667 5a0d 067d 0000 0000 0000 0000  ...gZ..}........
    00000e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    00000f0: 12b8 7714 a3b2 7f07 8869 5ea9 6bad 1ac6  ..w......i^.k...
    0000100: c7e7 4dec bb94 783b 14a0 4e8e e032 6b47  ..M...x;..N..2kG
    0000110: f149 b30c 3871 5bc8 260b 79be 2972 37c7  .I..8q[.&.y.)r7.
    0000120: c649 ed85 f4fc c130 0000 0000 0000 0000  .I.....0........
    0000130: 6151 e071 3c82 7f07 8869 483c 5321 e6f5  aQ.q<....iH

I want to explain the second card, and after that i'm going to talk about the structur of the backup files and their format.

 .. code-block :: plain

    0000000: 4dfb fd2b 6088 0400 46ba 1456 6150 1810  M..+`...F..VaP..
    0000010: 3202 0000 0138 0138 0138 0000 0000 0000  2....8.8.8......
    0000020: 0000 0000 0000 0000 0000 0000 0000 0000  ................ 
    [...]
    0000070: 3030 3020 2032 0000 0000 382e 382e 382e  000  2....8.8.8.
    0000080: 0450 00ff 0014 0701 0000 0000 0000 0000  .P..............
    0000090: 0000 0000 0000 0000 0000 0000 0000 784f  ..............xO
    00000a0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    00000b0: a0a1 a2a3 a4a5 7877 8869 eaed bbd5 9784  ......xw.i......
    00000c0: fd98 f79d 2616 768b bd47 d545 51e7 fddd  ....&.v..G.EQ...
    00000d0: 2ecf 9467 db0f 4d54 0000 0000 0000 0000  ...g..MT........
    00000e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    00000f0: 12b8 7714 a3b2 7f07 8869 5ea9 6bad 1ac6  ..w......i^.k...
    0000100: 45d2 49ec ba84 3d33 14a0 4e8e e032 6b47  E.I...=3..N..2kG
    0000110: 737d b70c 3961 0fe0 260b 79be 2972 37c7  s}..9a..&.y.)r7.
    0000120: c649 ed85 f4fc c130 0000 0000 0000 0000  .I.....0........
    0000130: 6151 e071 3c82 7f07 8869 483c 5321 e6f5  aQ.q<....iH

The second card is a normal user card. It has  the id: 4dfbfd2b.
it's one of my marked cards, so it has sector 2 [A] encrypted. The sector seams unimportant for the structur and usage of the card, despite of the data written in sector 02 [A]

I want to explain the binary file and what the hex-numbers mean. In fact, i can only guess, whats everything. I'm not quite sure yet.
The first sector, sector 00, is not encrypted, it is not writable by hardware and has therefore no encryption key. 
The first 4 bytes form the UID of the card. The rest i'm not quite sure about it myself. I would bet on some kind of: manufacturer, time, and so on.
The sector 01 is completly empty and not used on this type of system therefore i left it out.
A sector consists of 48 bytes. Each sector is divided into type [A] and [B]. Every type has 24 bytes to write in. Every sector and even every type has their own encryption key based on 6 bytes.
It is written as:

 .. code-block :: plain

    00000b0: keyA fourDividerBytes keyB
    00000c0: DataA                 DataB
    00000d0: DataA                 DataB
    00000e0: DataA                 DataB

hopefully you can grasp the idea of the backup files (i will call them
mfd files from now on). Both cards are exactly at an amount of 6 euro. I
looked at different cards with the same amount of money and everytime
there's another data on it. But there are some constant bytes throughout
the all files. As you can see [B] is in every sector identical on both
cards. In fact, it is exactly the same throughout all cards. Therefore,
the money has to be stored somewhere else. During my process of grasping
the storing process, i wrote 16 bytes in my little "thinkingbook" and
saw something pretty interesting. The 16 bytes were from sector 04 the
first 16 bytes of [A].

 .. code-block :: plain

    0000100: 45d2 49ec ba84 3d33 14a0 4e8e e032 6b47  E.I...=3..N..2kG
    0000110: 737d b70c 3961 0fe0 260b 79be 2972 37c7  s}..9a..&.y.)r7.

The two bytes 0xec and 0x0c are some kind of seperator. They are the
only constant values throughout ALL cards. I was kinda sure it is some
kind of bitwise operation. But i got nothing out of it, so far. i tried
to flip some bits, but totaly fucked up my first card and had to get a
new one. I believed the value has to be stored in an encrypted sector,
but during my lookup through other sectores, i discovered more of these
seperators.

 .. code-block :: plain

    00000c0: ff98 b79a be06 578b bd47 d545 51e7 fddd  ......W..G.EQ...
    00000d0: adcf 9667 5a0d 067d 0000 0000 0000 0000  ...gZ..}........

In sector 03 [A] the second byte of each 8 byte block (0x98, 0xcf) is
some kind of seperator. I didn't check this one through yet. The fourth
byte of the second 8 byte block (0x67) seems to appear in every mfd file
as well. **Which data has to be stored on card?** There has to be at
least the amount of money. In addition, they seperate between guest
cards, user cards and other cards as well. Therefore some byte sequence
has to make sure of that too. In addition i think, the data is encrypted
with some kind of different encryptionkey, which is stored on the card.
I just have to find the right algorithm. I can bring a card back into a
previously stored setup...but that's not what i want. I want to know
what is stored on the card. so long
