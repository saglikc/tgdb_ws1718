# Tutorium - Grundlagen Datenbanken - Blatt 10

## Vorbereitungen
* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `tutorium.sql` benötigt, die sich im Verzeichnis `sql` befindet.
* Die SQL-Dump-Datei wird in SQL-Plus mittels `start <Dateipfad/zur/sql-dump-datei.sql>` in die Datenbank importiert.
* Beispiele
  * Linux `start ~/Tutorium.sql`
  * Windows `start C:\Users\max.mustermann\Desktop\Tutorium.sql`

## Datenbankmodell
![Datenbankmodell](./img/datamodler_schema.png)

### Aufgabe 1
Was macht der folgende SQL-Code?

```sql
WITH vehicles AS (
    SELECT COUNT(*) Anzahl, accv.account_id
    FROM acc_vehic accv
    GROUP BY accv.account_id
)
SELECT CONCAT(a.forename, CONCAT(' ', a.surname)) AS "Benutzer" , v.Anzahl AS "Anzahl"
FROM vehicles v
    INNER JOIN account a ON (v.account_id = a.account_id)
WHERE v.Anzahl = (
    SELECT MAX(Anzahl)
    FROM vehicles
);
```

#### Lösung
Der SQL-code gibt die Anzahl sowie den Vor- und Nachname der Personen aus, welche die meisten vehicle_id`s in
der Tabelle acc_vehic besitzen. Dazu wird zunächst eine Abfrage nach der Anzahl und der entsprechenden account_id
unter dem Alias vehicles erstellt (gruppiert nach der account_id). Im zweiten Schritt werden der Vor- und Nachname(zusammengefasst unter dem Alias Benutzer)
und die Anzahl der account_id`s selektiert und ausgegeben. Dies erfolgt über die vorher definierte Abfrage vehicles mit Hilfe einer Inner Joins auf die Tabelle account.

### Aufgabe 2
Die folgende Aufgabe bezieht sich auf das Datenbankmodell der Vorlesung.
Geben Sie mit einem SQL Befehl alle Klausuren aus, zu denen sich Personen angemeldet haben, aber bei **ALLEN** angemeldeten Personen fehlt die Note.

#### Lösung
```sql
select klausurnr
from anmeldung a
where exists --mit not exists dsnn alle sachen die in der tabelle vorhaben sind wird false und umgekehr, und wenn es where exists ist dann wenn es vorhanden ist dann ist es true
( select *
  from anmeldung
  where a.klausurnr = klausurnr
  and note is null);
```

### Aufgabe 3
Finde mit der Option `EXISTS` herraus, wie viele Hersteller in der Datenbank hinterlegt sind ohne mit einem Auto verknüpft zu sein.

#### Lösung
```sql
select p.producer_id, producer_name
from producer p
where not exists
	(select *
	from vehicle v 
	where v.producer_id = p.producer_id);
	
--oder mit anzahl
select count (producer_id) as anzahl
from producer p
where not exists
	(select *
	from vehicle v
	where v.producer_id = p.producer_id);
```
