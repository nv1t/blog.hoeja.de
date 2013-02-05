Reverse Engineering a Payment System #4
#######################################
:date: 2011-04-13 13:00
:tags: en, nfc, payment system, reverse engineering, rfid

I finaly figured out, where the amount of money is stored. I got it down
to 8 bytes...but not further.. these 8 bytes even change if you put your
card into the machine and buy nothing. i made a list of all data i have
and which is displayable: keep in mind, some of these datapoints are
equal, coz i copied them for testing purposes

 .. code-block :: plain

    59163.6.11    45c21cecb985221b
    44045.0.37    43e75cec9b83fd3d
    64998.0.20    45d34dec19bea017
    59163.23.71   e5c618ecb9856a3b
    40550.6.00    c7d549ecbb9c223b
    40492.06.00   c7d249ecbb9c313b
    06.00         c7e74decbb94783b
    16.00         c7d14decbb9c2a0b
    21.00         c7d349ecbb9c302b
    06.00.2       c5810dec3a843233
    06.00.3       45900dec3a847313
    41952.06.00   47e64decbb9c613b
    41952.06.00   47e249ecbb94293b
    41952.06.00   47e04decbb94231b
    41952.06.00   47e04decbb94231b
    41952.06.00   47e64decbb9c613b
    39482.06.00   c7d04cecbabc2a1b
    0.30          c7d45dec98967b1f
    06.00         45d249ecba843d33
    11.50         455019ecbab62f06
    14.75         c3e45dec1aa77d6b
    17.75.2       43e05dec1aa5366a
    02.75         c1e059ec1bbd275f
    07.80         45504dec3a843612
    14.40         c3e65dec1aa73f4b
    12.30         2e78772e2e2a2e4b
    17.75         43e05dec1aa5366a
    11.90         45d609ec3a8c6d67
    17.35         c3e259ec1aa57c4a
    13.55         c3d659ec3bb5746e
    11.80         c55449ec3a867406
    14.35         43d019ec1b972d0b
    13.15         c3c019ec3bbd360e
    14.75         43d65dec1b9f676b
    16.55         43d459ec3bbd674b
    0.40          47b24dec3aa63f57
    16.95         c3665dec3a853d0b
    23.71         45c21cecb985221b
    real26.11     e5c618ecb9856a3b
    17.75         43e05dec1aa5366a
    16.95.2       c3e419ec1aa57e2a

the format should hopefully be clear. if there are 4 numbers in front of
the price, it is the cardnumber :) because the uid is not important you
can ignore that....anybody ANY idea?
