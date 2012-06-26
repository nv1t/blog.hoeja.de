Sudoku Solver
#############
:date: 2011-10-05 00:55
:tags: de, php

Vor ungefaehr ewig hab ich einen Sudoku Solver geschrieben. Aufgrund von
einem Post von Hoohead hab ich ihn wieder ausgegraben. Ich denke das
Projekt liegt nun gut 5 Jahre zurueck. Ich bin damals vor einem 16x16
Sudoku mit einem Hexadezimalen Charset gesessen und kam nichtmehr
weiter. Ich kam einfach nichtmehr weiter, also waehlte ich die Feigling
Variante. Laptop ausgepackt und einen allgemeinen Solver geschrieben.
Leider war ich zu der Zeit sehr vernarrt in php und deshalb ist das hier
entstanden:

::

    #!/usr/bin/env php
    solve();
    $sud->printSudoku();

    class Sudoku {
        public $charset = array(1,2,3,4,5,6,7,8,9); # = range(0,9);
        public $sudoku = array(
            'x' => 9,
            'y' => 9,
            'boxX' => 3,
            'boxY' => 3
        );
        private $sud;
        private $holes = array();
        public  $emptyHole = '.';

        function __construct($sud) {
            $this->sud = $sud;
            
            for($i = 0; $i < strlen($sud); $i++) 
                if($sud{$i} == $this->emptyHole) $this->holes[] = $i;
        }

        private function _getHoles() {
            $this->holes = array();
            for($i = 0; $i < strlen($this->sud); $i++)
                if($this->sud{$i} == $this->emptyHole) $this->holes[] = $i;
        }

        public function solve($layer=0) {
            $possibleChars = $this->_getChars($this->holes[$layer]+1);

            foreach($possibleChars as $char) {
                $this->sud{$this->holes[$layer]} = $char;
                if($layer != count($this->holes)-1) {
                    if($this->solve($layer+1)) return $this->sud;
                } else return $this->sud; 
            }

            $this->sud{$this->holes[$layer]} = $this->emptyHole; 
            return false;
        }
        
        private function _getChars($position) {
            return array_intersect($this->_checkBox(ceil((ceil($position/$this->sudoku['x']))/$this->sudoku['boxX']),ceil(($this->_checkColumn($position-(ceil($position/$this->sudoku['x']))*$this->sudoku['x']+$this->sudoku['x'])/$this->sudoku['boxY'])),$this->_checkRow(ceil($position/$this->sudoku['x'])),$this->_checkColumn($position-(ceil($position/$this->sudoku['x']))*$this->sudoku['x']+$this->sudoku['x']));
        }
        
        private function _checkRow($row) {
            $vorkommen = array();
            for($i = $row*$this->sudoku['x']-$this->sudoku['x']; $i < $row*$this->sudoku['x']; $i++)
                if($this->sud{$i} != '.')
                    $vorkommen[] = $this->sud{$i};

            return array_diff($this->charset,$vorkommen);
        }

        private function _checkColumn($column) {
            $vorkommen = array();
            for($i = $column-1; $i < $this->sudoku['x']*$this->sudoku['y']; $i += $this->sudoku['x'])
                if($this->sud{$i} != '.')
                    $vorkommen[] = $this->sud{$i};

            return array_diff($this->charset,$vorkommen);
        }

        private function _checkBox($boxrow,$boxcolumn) {
            $vorkommen = array();
            $startbox = ($boxrow*$this->sudoku['boxY']*$this->sudoku['x'])-$this->sudoku['boxY']*$this->sudoku['x']+$this->sudoku['boxY']*$boxcolumn-$this->sudoku['boxY'];
            
            for($a = 0; $a < $this->sudoku['boxY']; $a++) {
                for($i = 0; $i < $this->sudoku['boxX']; $i++) {
                    if($this->sud{$i+$startbox} != '.')
                        $vorkommen[] = $this->sud{$i+$startbox};
                    if($startbox+$this->sudoku['boxX'] === $startbox+$i+1)
                        $startbox += $this->sudoku['x'];
                }
            }
            
            return array_diff($this->charset,$vorkommen);
        }
        
        public function printSudoku($inline=false) {
            if($inline) {
                print implode('',$this->sud);
            } else {
                print "\n"; 
                $a = 0;
                for($i = 0; $i < strlen($this->sud); $i++) {
                    print str_replace('.',$this->emptyHole,$this->sud{$i})." ";
                    if(($i+1) % $this->sudoku['boxX'] === 0) print "  ";
        
                    if(($i+1) % $this->sudoku['x'] === 0) {
                        print "\n";
                        if(($a+1) % $this->sudoku['boxY'] === 0) print "\n";
        
                        $a++;
                    }
                }
            }
        }
    }
    ?>

Es ist nicht sehr schoen geworden und ich habe damals lange an der Logik
gesessen, aufgrund der Allgemeinheit. Der Solver geht fuer JEDES Sudoku,
egal welches Charset, egal welcher Groesse. Es muss nur Rechteckig sein.
Achtung er macht zwar Annahme, aber er Bruteforced noch. Theoretisch
koennte man noch Schleifen einbauen um in intelligent zu machen, aber
dazu hatte ich nie du Lust und 9x9 loest er ohne mit der Wimper zu
zucken :) Ich habe keine Ahnung mehr, wie ich auf diese \_getChars
Methode damals gekommen bin. Sie ist absolut haesslich, aber sie
funktioniert tadellos Wenn jemand dazu fragen hat, soll sie gerne
stellen :) so long
