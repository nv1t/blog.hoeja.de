Folge der Primzahlwurzeln
#########################
:date: 2011-08-16 23:00
:tags: de, mathematics, prime, prove

In meinem ersten Semester an der Uni forderte mich mein Korrektor zu
einer Aufgabe herraus. Ich sollte sie loesen und 1 Uebungsblatt erlassen
kriegen. Hier moechte ich eine Loesung zu dem Problem vorstellen:

**Problem:** Die Folge $(\\sqrt{p\_i})\_{i \\in \\mathbb{N}}$ der
Primzahlenwurzeln ist linear unabhaengig ueber dem Koerper der
rationalen Zahlen. 

Die Folge $(p\_i)\_{i \\in \\mathbb{N}}$ sei die
Folge der Primzahlen, also: $p\_1 = 2$, und $p\_{n+1} := \\min\\{ p
\\in \\mathbb{Z}\\quad \|\\quad p \\text{ Primzahl, } p > p\_n\\}$
Damit die Definition der $p\_i$'s ueberhaupt sinnvoll ist, muessten
wir wissen, dass es zu jeder Primzahl eine groessere Primzahl gibt. Mit
anderen Worten muessten wir wissen, dass es unendlich viele Primzahlen
gibt. Wir setzen dies fuer den Moment als bekannt vorraus. Desweiteren
akzeptieren wir, dass jede nichtleere Teilmenge der Menge der
natuerlichen Zahlen ein eindeutig bestimmtes Minimum besitzt, denn auch
dies ist zur Definition der $p\_i$'s von Noeten. Wir schreiben
$P(M)$ fuer die Potenzmenge einer Menge $M$. Die Potenzmenge einer
Menge $M$ hat als Elemente gerade saemtliche Teilmengen von $M$. Es
gilt beispielsweise:  $$P(\\{1,2,3\\}) =
\\{\\emptyset,\\{1\\},\\{2\\},\\{3\\},\\{1,2\\},\\{1,3\\},\\{2,3\\},\\{1,2,3\\}\\}$$
Zur Abkuerzung setzen wir $P := \\{I \\in P(\\mathbb{N}) \\quad \|
\\quad I \\text{ endlich }\\}$, fuer alle $n \\in \\mathbb{N}$ $P\_n
:= P(\\{1,..,n\\})$ und $P\_0 := P(\\emptyset) = \\{\\emptyset\\}$

Wir bemerken, dass mit diesen Bezeichnungen fuer alle $n \\in
\\mathbb{N}\_0$ gilt $P\_n \\subset P\_{n+1} \\subset P$. Ist $I$
eine nichtleere endliche Menge und $(x\_i)\_{i \\in I}$ ein
$I$-Tupel reeller Zahlen, so schreiben wir $\\prod\\limits\_{i \\in
I} x\_i$ fuer das Produkt der $x\_i$'s. 

Falls $I = \\emptyset$, so
setzen wir $\\prod\\limits\_{i \\in I} x\_i := 1$. 

Sei $f: P \\rightarrow \\mathbb{R}$ die Abbildung, die durch die Vorschrift
$f(I) = \\sqrt{\\prod\\limits\_{i \\in I} P\_i}$ gegeben ist. 

Um die Abbildung $f$ vertrauter zu machen, halten wir fest, dass zum Beispiel
$f(\\emptyset) = \\sqrt{1} = 1$ und $f(\\{i\\}) = \\sqrt{p\_i}$ fuer
alle $i \\in \\mathbb{N}$. Des weiteren gilt etwa $f(\\{2,3,5,7\\}) =
\\sqrt{p\_2p\_3p\_5p\_7} = \\sqrt{2 \\cdot 3 \\cdot 5 \\cdot 7}$ 

Jetzt geht es an den eigentlichen Beweis. Das vorher war nur Vorarbeit um
darauf vorzubereiten und alles zu definieren. 

**Satz:** Das Tupel $f$ ist linear unabhaengig im $\\mathbb{Q}$-Vektorraum der reellen Zahlen

Fuer alle $n \\in \\mathbb{N}\_0$ setzen wir $f\_n := f\|\_{P\_n}$
und $S\_n := span(f\_n) = \\{ x \\in \\mathbb{R} \| \\exists
(\\lambda\_I) \\in \\mathbb{R}^{P\_n}: x = \\sum\\limits\_I
\\lambda\_If\_n(I)\\}$, wobei $span(f\_n)$ den hier von $f\_n$
aufgespannten Untervektorraum im $\\mathbb{Q}$-Vektorraum der reellen
Zahlen meint. Wir bezeichen ausserdem mit $A\_n$ die folgenden
Aussage:

#. $f\_n$ ist linear unabhaengig im $\\mathbb{Q}$-Vektorraum der
   reellen Zahlen
#. $S\_n$ ist ein Unterkoerper des Koerpers der reellen Zahlen
#. fuer alle $I \\in P \\setminus P\_n$ ist $f(I) \\not\\in S\_n$

Als Vorstufe zum Beweis zeigen wir mittels vollstaendiger Induktion,
dass $A\_n$ fuer alle $n \\in \\mathbb{N}\_0$ gilt. Induktionsanfang
($A\_0$ gilt): $P\_0$ enthaelt genau ein Element, naemlich die leere
Menge. $f\_0(\\emptyset) = f(\\emptyset) = 1 \\in \\mathbb{R}$.
$f\_0$ ist also offensichtlich linear unabhaengig, da eine
ein-elementige Indexmenge genau dann linear unabhaengige ist, wenn sein
einziges Element von Null verschieden ist. $S\_0$ ist gleich der Menge
der rationalen Zahlen. Insbesondere ist $S\_0$ ein Unterkoerper des
Koerpers der reellen Zahlen. 

Sei $I = P \\setminus P\_0$. Dann ist
$f(I)$ offensichtlich irrational, das heisst $f(I) \\not\\in S\_0$.
Induktionsschritt: Sei $n$ eine nichtnegative ganze Zahl mit der
Eigenschaft dass $A\_n$ gilt. Wir zeigen, dass dann auch $A\_{n+1}$
gilt. 

Sei $(\\lambda\_I)$ ein $P\_{n+1}$-Tupel rationaler Zahlen, so
dass $\\sum\_{I \\in P\_{n+1}}\\lambda\_If\_{n+1}(I) = 0$. Setzen wir
$a := \\sum\_{I \\in P\_n}\\lambda\_If(I)$ und $b := \\sum\_{I \\in
P\_n}\\lambda\_{I \\cup \\{n+1\\}}f(I)$, dann gilt $\\sum\_{I \\in
P\_{n+1}}\\lambda\_If\_{n+1}(I) = a+b\\sqrt{p\_{n+1}}$. Das heisst,
$a+b\\sqrt{p\_{n+1}} = 0$. Nun sind $a,b \\in S\_n$. Angenommen $b
\\not= 0$. Dann besitzt $b$ ein multiplikatives Inverses $b^\*$ im
Koerper der reellen Zahlen. Da $S\_n$ nach Induktionsannahme ein
Unterkoerper des Koerpers der reellen Zahlen ist, gilt $b^\* \\in
S\_n$. Damit ist aber auch $\\sqrt{p\_{n+1}} = -b^\*a \\in S\_n$.
Dies steht im Widerspruch zur Induktionsannahme. Folglich ist $b = 0$.
Aber damit ist auch $a=0$. 

Aus der linearen Unabhaengigkeit von
$f\_n$ folgt $\\lambda\_I = 0$ fuer alle $I \\in P\_{n+1}$
$S\_{n+1}$ ist in jedem Fall eine Untergruppe der reellen Zahlen
bezueglich der Verknuepfung der Addition. Ausserdem ist $S\_{n+1}$
unter der Multiplikation reeller Zahlen abgeschlossen, das heisst fuer
alle reellen Zahlen $x$ und $y$ gilt: $x,y \\in S\_{n+1}$ impliziert $xy \\in S\_{n+1}$
Damit nachgewiesen ist, dass es sich
bei $S\_{n+1}$ um einen Unterkoerper des Koerpers der reellen Zahlen
handelt, bleibt zu zeigen, dass fuer alle $x \\in \\mathbb{R}$, $x
\\not= 0$, mit $x$ auch das multiplikative Inverse $x^\*$ von $x$
Element von $S\_{n+1}$ ist. 

Sei also $x \\in S\_{n+1}$, $x \\not=
0$. Dann gibt es, nach Definition von $S\_{n+1}$, ein
$P\_{n+1}$-Tupel $(\\lambda\_I)$ rationaler Zahlen, so dass $x =
\\sum\\lambda\_If(I)$. 

Wir definieren $a$ und $b$ wie oben und
halten fest, dass $x = a + b\\sqrt{p\_{n+1}}$. Es gilt
$a-b\\sqrt{p\_{n+1}} \\not= 0$, denn andernfalls waeren $a$ und
$b$ gleich Null, was im Widerspruch zu $x \\not= 0$ stuende.
Folglich haben wir auch $0 \\not= (a+b\\sqrt{p\_{n+1}})(a-b\\sqrt{p\_{n+1}})$ $ = a^2 -b^2p\_{n+1} =:
d$.

Daraus folgt, dass $x^{-1} = d^{-1}(a-b\\sqrt{p\_{n+1}}) =
(d^{-1}a)-(d^{-1}b)\\sqrt{p\_{n+1}}$. Da $a,b \\in S\_n$ und $S\_n$
nach Induktionsannahme ein Unterkoerper des Koerpers der reellen
Zahlenist, sind $d$ und damit auch $d^{-1}$,$d^{-1}a$ und
$d^{-1}b$ Elememte von $S\_n$. Letzte Darstellung von $x^{-1}$
impliziert daher, dass $x^{-1} \\in S\_{n+1}$. Sei $I \\in P
\\setminus P\_{n+1}$. 

Angenommen $f(I) \\in S\_{n+1}$. Dann gaebe es
$a,b \\in S\_n$,so dass $f(I) = a+b\\sqrt{p\_{n+1}}$. Quadrieren
liefert nach Definition von $f(I)$ $\\prod\_{i \\in I} p\_i = a^2 +
b^2p\_{n+1} + 2ab\\sqrt{p\_{n+1}}$. Folglich ist $\\prod\_{i \\in I}
p\_i = a^2 + b^2p\_{n+1}$ und $2ab = 0$. Das heisst, es gilt $a=0$
oder $b=0$. Angenommen $b=0$. Dann haetten wir $\\prod\_{i \\in I}
p\_i = a^2$, sprich $f(I) = a$, sprich $f(I) \\in S\_n$, da $a
\\in S\_n$. Dies steht jedoch im Widerspruch zum dritten Punkt von
$A\_n$, da $I \\in P \\setminus P\_n$ (offenbar ist ja $P\_n
\\subset P\_{n+1}$). Es gilt also $a=0$. 

Damit ergibt sich
$\\prod\_{i \\in I} p\_i = b^2p\_{n+1}$. 

Wir unterscheiden nun zwei Faelle:

1. $n+1 \\in I$: 
   mit $I^\* := I \\setminus \\{n+1\\}$ gilt
   dann $\\prod\_{i \\in I^\*} p\_i = b^2$, also $f(I^\*) = b$, also
   $f(I^\*) \\in S\_n$. Dies steht jedoch erneut im Widerspruch zum
   dritten Teil von $A\_n$, da $I^\* \\in P \\setminus P\_n$.

2. $n+1 \\not\\in I$: 
   Dann gilt mit $I^+ := I \\cup
   \\{n+1\\}$, dass $f(I^+)= bp\_{n+1}$, was einen weiteren Widerspruch
   zum dritten Teil der Aussage $A\_n$ darstelle.


**Fazit**: Wir halten fest, dass $f(I) \\not\\in S\_{n+1}$. Damit ist
$A\_{n+1}$ gezeigt und die Unduktion beschlossen; es gilt $A\_n$
fuer alle $n \\in \\mathbb{N}\_0$. Insbesondere wissen wir, dass fuer
alle $n \\in \\mathbb{N}\_0$ das Tupel $f\_n = f\|\_{P\_n}$ im
$\\mathbb{Q}$-Vektorraum der reellen Zahlen linear unabhaengig ist.
Wir folgern die lineare Unabhaengigkeit von $f$. Sei dazu
$(\\lambda\_I)$ ein $P$-Tupel rationaler Zahlen, so dass nur endlich
viele Eintraege des Tupels von Null verschieden sind und
$\\sum\\lambda\_If(I) = 0$. Sei $n \\in \\mathbb{N}$ so gross, dass
$\\lambda\_I = 0$ fuer alle $I \\in P \\setminus P\_n$ (ein solches
$n$ existiert). Dann gilt $\\sum\\limits\_{I \\in P} \\lambda\_If(I)
= \\sum\\limits\_{I \\in P\_n} \\lambda\_If(I) = \\sum\\limits\_{I \\in
P\_n} \\lambda\_If\_n(I)$. 

Da $f\_n$ linear unabhaengig ist, folgt
$\\lambda\_I = 0$ fuer alle $I \\in P\_n$. $(\\lambda\_I)$ ist
demzufolge das Nulltupel. 

Dies beweist die lineare Unabhaengigkeit von
$f$. 

so long
