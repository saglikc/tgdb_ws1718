# Tutorium - Grundlagen Datenbanken - Blatt 9

## Vorbereitungen
* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `tutorium.sql` benötigt, die sich im Verzeichnis `sql` befindet.
* Die SQL-Dump-Datei wird in SQL-Plus mittels `start <Dateipfad/zur/sql-dump-datei.sql>` in die Datenbank importiert.
* Beispiele
  * Linux `start ~/Tutorium.sql`
  * Windows `start C:\Users\max.mustermann\Desktop\Tutorium.sql`

## Datenbankmodell
![Datenbankmodell](./img/datamodler_schema.png)

### Aufgabe 1
Wo liegen die Vor- und Nachteile eines Trigger in Vergleich zu einer Prozedur?

#### Lösung
**Vorteil**
+ Eine TRigger löst automatisch vor oder nach einem Event aus. Er muss nicht explizit gestartet werden.
+ Keine Benutzer kann einen aktiven TRigger umgehen.
+ Es sind keine zusätzlichen Berechtigungen notwendig.

**Nachteil**
+ Kann keine Parameter übergeben bekommen.
+ Kann keinen Rückgabewert liefern.
+ Kann nur ausgeführt werden, wenn ein INSERT, UPDATE oder DELETE Befehl auf eine Tabelle ausgeführt wird.

### Aufgabe 2
Wo drin unterscheidet sich der `Row Level Trigger` von einem `Statement Trigger`?

#### Lösung
**Row Level TRIGGER**
Der Row level trigger wird immer dann ausgeführt, wenn eine zeile durch den sql- befehl INSERT, UPDATE oder delete beeinflusst wird.
wenn eine anweisung keine zeilen trifft, wird keine Triggeraktion ausgeführt.

**Statement TRIGGER**
Dieser trigger wird ausgelöst, wenn eine sql- anweisung eine tabelle betrifft unabhängig deren anzahl der datensätze

### Aufgabe 3
Schaue dir den folgenden PL/SQL-Code an. Was macht er?

```sql
CREATE SEQUENCE seq_account_id
START WITH 1000
INCREMENT BY 1 --zuwachs um 1
MAXVALUE 99999999
CYCLE
CACHE 20;

CREATE OR REPLACE TRIGGER BIU_ACCOUNT
BEFORE INSERT OR UPDATE OF account_id ON account
FOR EACH ROW
DECLARE

BEGIN
  IF UPDATING('account_id') THEN
    RAISE_APPLICATION_ERROR(-20001, 'Die Account-ID darf nicht verändert oder frei gewählt werden!');
  END IF;

  IF INSERTING THEN -- bei insert gibt es kein :old, da keins davor eingefügt wurde. und beim trigger kann man nur eine zeile inserten, updaten oder deleten. siehe bild handy
		NEW.account_id := seq_account_id.NEXTVAL;
	-- mit currvall sieht man den stand welcher cache es ist, also wievielter.
  END IF;
END;
/
```

#### Lösung


### Aufgabe 4
Verbessere den Trigger aus Aufgabe 3 so, dass
+ wenn versucht wird einen Datensatz mit `NULL` Werten zu füllen, die alten Wert für alle Spalten, die als `NOT NULL` gekennzeichnet sind, behalten bleiben.
+ es nicht möglich ist, das die Werte für `C_DATE` und `U_DATE` in der Zukunkt liegen
+ `U_DATE` >= `C_DATE` sein muss
+ der erste Buchstabe jedes Wortes im Vor- und Nachnamen groß geschrieben wird
+ die Account-ID aus einer `SEQUENCE` entnommen wird

Nutze die Lösung der Aufgabe 2, Aufgabenblatt 8 um die Aufgabe zu lösen. Dort solltest du einige Hilfestellungen finden.

#### Lösung
```sql
-- initcap = alle wörter groß schreiben, zum beispiel einer hat 2 nachnamen und dann werden beide groß geschrieben, statt wenn man den 1. buchstaben groß macht und beim 2. nachnamen alles klein.

```

### Aufgabe 5
Angenommen der Steuersatz in Deutschland sinkt von 19% auf 17%.
+ Aktualisiere den Steuersatz von Deutschland und
+ alle Quittungen die nach dem `01.10.2017` gespeichert wurden.

#### Lösung
```sql
update country
set duty_amount = 0.17
where upper(country_name) = 'DEUTSCHLAND'

--tabelle receipt
update receipt r
set r_duty_amount ( 
		select c.duty_amount
		from country c
		inner join  gas_station gs  on (gs.country_id = c.country_id)
		where gs.gas_station_id = r.gas_station_id)
		
where r.gas_station_id in()
 (
		select gs.gas_station_id
		from gas_station gs
		inner join country c on (gs.country_id = c.country_id)
		where c.country_name like 'DEUTSCHLAND'
)

and c_date >= to_date('01.10.2017' , 'dd.mm.yyyy');
```

### Aufgabe 6
Liste alle Hersteller auf, die LKWs produzieren und verknüpfe diese ggfl. mit den Eigentümern.

#### Lösung
```sql

```


























