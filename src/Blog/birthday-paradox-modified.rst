birthday paradox modified
#########################
:date: 2011-03-24 15:18
:tags: en, mathematics, numerics, paradox, python

Not long ago, i wrote an article about the famous birthday paradox.
Basically, it says: take an amount of people and calculate the
possibility two of them have them same day as their birthday. The
possibility is crazy high. Now the basic idea: We calculate the total
amount of combination and the amount of different days to get the
possibility everybody parties on a different day. We can now subtract
from 1 to get the opposite. $m = 365^n$ is the number of all birthday
combinations, for $n$ persons. Now we can look at $u = 365 \\dotsm
(365-n+1) = \\frac{365!}{(365-n)!}$. It is the number of combinations
for all persons on different days. With Laplace: $\\frac{u}{m} =
\\frac{365!}{(365-n)! \\cdot 365^n}$ is the possibility everybodys
birthday is on a different day. So we get: $P = 1-\\frac{u}{m} =
1-\\frac{365!}{(365-n)! \\cdot 365^n}$ which is the possibility at
least 2 persons have on the same day. Because it's kinda frustrating to
calculate this fraction with a calculater i wrote a small python script
:)

::

    n=25 # number of persons
    ret=1
    for i in range(365-n+1,365+1): ret=ret*i
    print(1-ret/(365**n))

that helps a lot :) if you plot these data points you get an outcome
similar to this:

|image0| 

But that's just the base. A good friend of mine asked me, if we can modify this problem
to a larger scale. She wanted to take the year in comparison as well. So
i hacked something together to work with a different "year"-range. In
fact, it's pretty simple. You just have to apply the year into the
calculation. With $y$ as the number of years you get: $m = (365
\\cdot y)^n$ is the number of all birthday combinations, for n persons.
Now we can look at $u = (365y) \\dotsm (365y-n+1)] =
\\frac{(365y)!}{(365y-n)!}$. It is the number of combinations with all
persons on different days. With Laplace: $\\frac{u}{m} =
\\frac{(365y)!}{(365y-n)! \\cdot (365 \\cdot y)^n}$ is the possibility
everybody has on a different day. So we get: $P = 1-\\frac{u}{m} =
1-\\frac{(365y)!}{(365y-n)! \\cdot (365 \\cdot y)^n}$ which is the
possibility at least 2 persons have on the same day and same year.

::

    n=50 # number of persons
    y=25 # range of years
    ret=1
    for i in range(365*y-n+1,365*y+1): ret=ret*i
    print(1-ret/((365*y)**n))

I was stunned to see the outcome...it is incredible...with 50 persons
you already get around 12%, which is ridiculous high. 

|image1| 

around 120 you even get the 50% which is just....yeah...can't believe it. if you have
another basic approach i would love to hear about it :) different
outcome as well...i'm still a bit on the: "there has to be something
wrong"-side so long :)

.. |image0| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/03/birtday-paradox-e1300974060373.png
.. |image1| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/03/birthday-paradox2-e1300975268660-300x188.png
.. |image2| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/03/birtday-paradox-e1300974060373.png
.. |image3| image:: http://nuit.homeunix.net/blag/wp-content/uploads/2011/03/birthday-paradox2-e1300975268660-300x188.png
