geometric progression modified
##############################
:date: 2011-03-24 19:21
:tags: en, limits, mathematics, paradox, python, statistics

During a night out, a friend brought up an interesting topic: if you
have a fixed length and you always walk the half which is left, you will
never get to the end, but it's trending towards it. In fact it is
written like this: $\\sum\\limits\_{i=1}^{\\infty} \\frac{1}{2^i} = 1$
We can change that to a wider approach: $\\sum\\limits\_{i=1}^{\\infty}
k^{-i}$. Where will you end up, if you walk: $\\frac{1}{k}$ If you
simulate that behaviour with a small python script you get different
outcomes.

::

    sum([ 1/k**i for i in range(1,1000)])

For $k=3 \\rightarrow \\sum = \\frac{1}{2}$, for $k=4 \\rightarrow
\\sum = \\frac{1}{3}$. Is it save to say: For $k \\rightarrow \\sum =
\\frac{1}{k-1}$? No it's not...but i can prove that this is the outcome
:) Bare with me during this prove, it will be short and painless. I
think a lot of people have heard about the basic prove by indication of
the geometric progression. If not...i shall repeat it!
$\\sum\\limits\_{i=0}^{N} x^i = \\frac{1-x^{N+1}}{1-x}$. For $N=0$
it should be trivial. But $N \\rightarrow N+1$:
$\\sum\\limits\_{i=0}^{N+1} x^i = \\frac{1-x^{N+2}}{1-x}$. It is save
to say $\\sum\\limits\_{i=0}^N x^i + x^{N+1} = \\frac{1-x^{N+1}}{1-x} +
x^{N+1}$ because $\\sum\\limits\_{i=0}^N x^i$ is already proofed
correct :) We get
$\\frac{1-x^{N+1}-(1-x)x^{N+1}}{1-x}=\\frac{1-x^{N+1}+x^{N+1}-x^{N+2}}{1-x}$
which leaves us with: $\\frac{1-x^{N+2}}{1-x}$ q.e.d. We proofed the
basic concept of this progression...but the main part is to show, that
$\|x\| = \\frac{1}{k}$ is just a special case. To proof it, we don't
want to go to $N$...no we want it all the way to infinity, so:
$\\lim\\limits\_{N \\rightarrow \\infty} \\frac{1-x^{N+1}}{1-x} =
\\frac{1}{1-x}$. We have to look at $\\frac{1}{1-x}-1$ now, because
we startet with $\\sum\\limits\_{i=0}^\\infty$. So we end up with
$\\frac{1}{1-x}-1 = \\frac{x}{1-x}$ If we think about, we wanted
$\|x\| < 1$, let's set $\|x\| = \\frac{1}{k}$, we get:
$\\frac{\\frac{1}{k}}{1-\\frac{1}{k}} = \\frac{1}{k-1}$ which is
exactly what we wanted to proof. we see:
$\\sum\\limits\_{i=1}^{\\infty} \\frac{1}{k^i} = \\frac{1}{k-1}$
q.e.d. What does this mean in real life: If you take a fixed length and
measure everytime the third of the remaining length, you will end up at
exactly half of the length. Or: if we walk $\\frac{1}{k}$ of the
remaining length we will end up at a fraction of $\\frac{1}{k-1}$ of
the original length. incredible isn't it? so long
