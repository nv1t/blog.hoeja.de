[SQL] Left vs. Year
###################
:date: 2011-12-10 19:49
:tags: benchmark, de

Gestern ist das Thema aufgekommen, ob bei einem Date Field ein Left oder
ein Year schneller sei, um das jeweilige Jahr auszulesen. Nachdem heute
mein Rechner auf der Arbeit eh Leercycle hatte, hab ich ein paar mal ein
kleines Script durchlaufen lassen.

::

    use benchmark;
    DROP PROCEDURE IF EXISTS benchleft;
    DELIMITER //
    CREATE PROCEDURE benchleft()
    BEGIN

    DECLARE v2 INT DEFAULT 0;
    SET @secho = '';

    v1loop: WHILE v2 < 10000000 DO
      SELECT LEFT(NOW(),4) INTO @secho;
      SET v2=v2+1;
    END WHILE v1loop;
    END//
    DELIMITER ;


    DROP PROCEDURE IF EXISTS benchyear;
    DELIMITER //
    CREATE PROCEDURE benchyear()
    BEGIN

    DECLARE v2 INT DEFAULT 0;
    SET @secho = '';

    v1loop: WHILE v2 < 10000000 DO
      SELECT YEAR(NOW()) INTO @secho;
      SET v2=v2+1;
    END WHILE v1loop;
    END//
    DELIMITER ;

Das ganze definiert 2 Funktionen. Die Funktionen sind komplett Identisch
bis auf eben das Year. Ich betrachte auch nicht das Date Datenfeld,
sondern einfach den NOW() String. Wo er das ganze herkriegt ist auch
nicht entscheidend. Aufgerufen wird das ganze dann so:

::

    mysql> source test.sql;
    Database changed
    Query OK, 0 rows affected (0.00 sec)
    Query OK, 0 rows affected (0.00 sec)
    Query OK, 0 rows affected (0.00 sec)
    Query OK, 0 rows affected (0.00 sec)

    mysql> call benchleft(); call benchyear();
    Query OK, 1 row affected, 1 warning (2 min 10.53 sec)
    Query OK, 1 row affected, 1 warning (2 min 3.16 sec)

und hier seht ihr auch schon den Unterschied. Dies ist nur 1 Wert von
insgesamt 30 Messungen. Aber selbst nach den ersten beiden Zeichnet sich
ein klares Bild ab. Die restlichen Werte sind auch relativ klar. Wir
bewegen uns bei Left in einem Rahmen von 2min 8.5s bis 2min 7.0s. Bei
Date hingehen sind es 2min 0.5s bis 2min 0.2s. Das heisst wir haben bei
10 Millionen Durchlaeufen einen Geschwindigkeitsunterschied von
ungefaehr 7-8 Sekunden. Bei den wenigen Einsaetzen die es braucht, nicht
sonderlich entscheidend :) Ich wuerde trotzdem Year nehmen, weil es
einfach flexibler ist, und auch bei einem DATETIME Feld funktioniert :)
so long Und so ganz am Rande: Wie definier ich sinnvoll eine While
Schleife in MySQL :-/ Ich hab es ohne die Prozedur drumrum nicht zum
laufen gekriegt.
