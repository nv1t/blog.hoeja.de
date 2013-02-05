Reverse Engineering a Payment System #3
#######################################
:date: 2011-04-05 08:09
:tags: en, payment system, reverse engineering, rfid, wtf

I discovered something really strange a few minutes ago. I scanned a
friends card. I've never touched that card before and this guy hasn't
either. But the data pattern was really messed up. The parts with the
0x00 bytes were 0xff. Some standard encryption keys were changed and the
whole card was just strange to look at. This card was altered at some
point. I'm not surprised. The crypto1 cipher is really crap and was
broken a few years ago. But to find such a card, which was altered and
brought back into the system, was an interesting finding. it's
interresting, coz i can find out, which data was altered, how this is
affecting the card :) so long
