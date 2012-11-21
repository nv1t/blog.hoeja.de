Funktionsname ist das wichtigste
################################
:date: 2011-11-08 21:55
:tags: de, java, pastebin, source code, wtf

Man sollte seine Funktionen immer "sinnvoll" benennen. Es gibt aber
Leute, die uebertreiben mit dem Name ein wenig:

 .. code-block :: java

    public void testItDoesntRequestNextBondWhenMaximumDepthReached()
    {
      walker.setMaximumDepth(2);
      when(path.size()).thenReturn(2);
      doStep();
      verify(step, never()).nextBond();
    }

Wer braucht schon einen Kommentar, wenn man alles in den Funktionsnamen
packen kann. so long
