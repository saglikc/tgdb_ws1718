# Tutorium - Grundlagen Datenbanken - Blatt 5

## Vorbereitungen
* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `01_tutorium.sql` benötigt, die sich im Verzeichnis `sql` befindet.
* Die SQL-Dump-Datei wird in SQL-Plus mittels `start <Dateipfad/zur/sql-dump-datei.sql>` in die Datenbank importiert.
* Beispiele
  * Linux `start ~/Tutorium.sql`
  * Windows `start C:\Users\max.mustermann\Desktop\Tutorium.sql`

## Datenbankmodell
![Datenbankmodell](./img/datamodler_schema.png)

## Aufgaben

### Aufgabe 1
Erstelle mit Dia oder einem anderen Werkzeug eine Abbilung der Mengen, die durch `INNER JOIN`, `RIGHT JOIN`, `LEFT JOIN` und `OUTER JOIN` gemeint sind.

#### Lösung
Inner join: Liefert Ergebnisse aus beiden Tabellen, deren Werte in beide Tabellen vorliegen.
Left join : Liefert die Schnittmenge aus zwei Tabellen inkl. der Menge A(left)
Right join : Liefert die Schnittmenge aus zwei Tabellen inkl. der Menge B(right)
Outer join : Liefert die Mengen A (left) und A(right)

### Aufgabe 2
Welche Personen haben kein Fahrzeug? Löse dies einmal mit `LEFT JOIN` und `RIGHT JOIN`.

#### Lösung
```sql
--Left join
select forename, surname
from account account
left join acc_vehic accv on (acc.account_id = accv.account_id)
where accv.vehicle_id is null;

--right join
select forename, surname, vehicle_id
from acc_vehic accv
right join account acc on (accv.account_id = acc.account_id)
where accv.vehicle_id is null;
```
