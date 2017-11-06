# Tutorium - Grundlagen Datenbanken - Blatt 4

## Vorbereitungen
* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `tutorium.sql` benötigt, die sich im Verzeichnis `sql` befindet.
* Die SQL-Dump-Datei wird in SQL-Plus mittels `start <Dateipfad/zur/sql-dump-datei.sql>` in die Datenbank importiert.
* Beispiele
  * Linux `start ~/Tutorium.sql`
  * Windows `start C:\Users\max.mustermann\Desktop\Tutorium.sql`

## Datenbankmodell
![Datenbankmodell](./img/datamodler_schema.png)

## Aufgaben

### Aufgabe 1
Um genauere Informationen und Prognosen mit Data Mining Werkzeugen zu schöpfen, ist es notwendig mehr Informationen über die registrierten Benutzer zu sammeln und zu speichern. Die in Zukunft gesammelten Informationen sollen in neuen Tabellen des bestehenden Datenbankmodells gespeichert werden. Dazu soll jedem Benutzer einen Erst- und Zweitwohnsitz zugeordnet werden. Jeder Wohnsitz besitzt eine eigene Adresse. Integriere in das bestehende Datenbankmodell Tabellen die den genauen Erst- und Zweitwohnsitz abbilden können. Beachte dazu die Normalisierungsformen bis 3NF - [Dokumentation](https://de.wikipedia.org/wiki/Normalisierung_(Datenbank)). Wie lautet deine SQL-Syntax um deine Erweiterung des Datenbankmodells zu implementieren?

#### Lösung
```sql
create table acc_add
( acc_add_id number(38) not null,
 account_id number(38) not null,
 street varchar(32) not null,
 address_id number(38) not null,
 country_id number(38) not null;
```

### Aufgabe 2
Als App Entwickler/in für Android und iOS möchtest du dich nicht darauf verlassen, dass die Adresse exakt richtig ist und überlegst in dem Datenbankmodell noch zwei zusätzliche Attribute (X und Y Koordinate) zur genauen GPS Lokalisierung einer Tankstelle aufzunehmen. Wie lautet deine SQL-Syntax um das Datenbankmodell auf die zwei Attribute zu erweitern?

#### Lösung
```sql
ALTER TABLE GAS_STATION
   ADD (GPS_POS_X NUMBER(10,5),
        GPS_POS_Y NUMBER(10,5));
```

### Aufgabe 3
Welche Kunden haben im Jahr 2017 mehr als den Durchschnitt getank?

#### Lösung
```sql
select a.account_id
from receipt p
group by r.account_id
having avg( (r.price_l * r.liter) * r.duty_amount) > (
		Select avg (price_l * liter) * duty_amount ) 
		from receipt
		where to_char(receipt_date, 'yyyy') = '2017'
		;
```

### Aufgabe 4
Ermittle, warum du INSERT-Rechte auf die Tabelle `SCOTT.EMP` und UPDATE-Rechte auf die Tabelle `SCOTT.DEPT` besitzt. Beantworte dazu schrittweise die Aufgaben von 4.1 bis 4.4.

#### Aufgabe 4.1
Wurden die Tabellen-Rechte direkt an dich bzw. an `PUBLIC` vergeben?

##### Lösung
```sql
SELECT table_schema, privilege, grantee
FROM all_tab_privs
WHERE table_schema = 'SCOTT'
and table_name in ('dept', 'emp')
and grantee in (
	(select user from dual),
	'public');
```

#### Aufgabe 4.2
Welche Rollen besitzt du direkt?

##### Lösung
```sql
SELECT  granted_role, default_role
FROM user_role_privs;
```

#### Aufgabe 4.3
Welche Rollen haben die Rollen?

##### Lösung
```sql
SELECT granted_role, role
FROM role_role_privs 
WHERE role in(
	select granted_role
	from user_role_privs); ---abfrage der rollen(wi_student, fh_trier)

fh_trier hat wi_student als rolle
bw_student hat student als rolle	
	
	
	```

#### Aufgabe 4.4
Haben die Rollen Rechte an `SCOTT.EMP` oder `SCOTT.DEPT`?

##### Lösung
```sql
SELECT *
FROM role_tab_privs
where table_name in ('emp', 'dept')
and role in ('FH_TRIER', 'STUDENT', 'BASTUDENT' , 'BW_STUDENT')
and owner = 'SCOTT';
```

### Aufgabe 5
Es soll für jede Tankstelle der Umsatz einzelner Jahre aufgelistet werden auf Basis der Daten, die Benutzer durch ihre Quittungen eingegeben haben. Sortiere erst nach Jahr und anschließend nach der Tankstelle. Beispiel:

| Jahr  | Anbieter  | Straße            | PLZ   | Stadt | Land          | Umsatz    |
| ----- | --------- | ----------------- | ----- | ----- | --------------| --------- |
| 2017  | Esso      | Triererstraße 15  | 54292 | Trier | Deutschland   | 54784.14  |
| 2017  | Shell     | Zurmainerstraße 1 | 54292 | Trier | Deutschland   | 67874.78  |
| 2016  | Esso      | Triererstraße 15  | 54292 | Trier | Deutschland   | 57412.66  |
| 2016  | Shell     | Zurmainerstraße 1 | 54292 | Trier | Deutschland   | 72478.42  |

#### Lösung
```sql
SELECT to_char(r.receipt_date, 'yyyy') "Jahr",
	   p.provider_name "Anbieter",
	   gs.street "Straße",
	   a.plz "PLZ",
	   a.city "Stadt",
	   a.country_name "Land",
	   SUM(r.price_l * r.liter * (1 + r.duty_amount)) "Umsatz"
	   
FROM receipt r
	inner join gas_station gs on (r.gas_station_id = gs.gas_station_id)
	inner join provider p on (p.provider_id = gs.provider_id)
	inner join country c on (c.country_id = gs.country_id)
	inner join address a on (a.address_id = gs.address_id)
	
GROUP BY r.receipt_date,
	   p.provider_name,
	   gs.street,
	   a.plz,
	   a.city, 
	   a.country_name
	   
ORDER BY "Jahr", "Anbieter", "Straße", "PLZ", "Stadt", "Land";
	   
	  
```


