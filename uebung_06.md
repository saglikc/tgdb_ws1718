# Tutorium - Grundlagen Datenbanken - Blatt 6

## Vorbereitungen
* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `01_tutorium.sql` benötigt, die sich im Verzeichnis `sql` befindet.
* Die SQL-Dump-Datei wird in SQL-Plus mittels `start <Dateipfad/zur/sql-dump-datei.sql>` in die Datenbank importiert.
* Beispiele
  * Linux `start ~/Tutorium.sql`
  * Windows `start C:\Users\max.mustermann\Desktop\Tutorium.sql`

## Datenbankmodell
![Datenbankmodell](./img/datamodler_schema.png)

## Data-Dictionary-Views
![Data-Dictionary-Views](./img/constraint_schema.png)

## Aufgaben

### Aufgabe 1
Wie heißt der Primary Key Contraint der Tabelle `VEHICLE` und für welche Spalten wurde er angelegt?

#### Lösung
```sql
select constraint_name, constraint_type, search_condition, r_owner, r_constraint_name
from user_constraints
where table_name = 'VEHICLE' and constraint_type = 'P';
```

### Aufgabe 2
Für welche Spalte**n** der Tabelle `ACC_VEHIC` wurde ein Foreign Key angelegt und auf welche Spalte/n in welcher Tabelle wird er referenziert?

#### Lösung
```sql
select constraint_name, constraint_type, search_condition, r_owner, r_constraint_name
from user_constraints
where table_name = 'ACC_VEHIC' and constraint_type = 'R' ;
```

### Aufgabe 3
Erstelle einen Check Constraint für die Tabelle `ACCOUNT`, dass der Wert der Spalte `U_DATE` nicht älter sein kann als `C_DATE`.

#### Lösung
```sql
ALTER table account add constraint c_date
check (U_DATE < C_DATE);
```

### Aufgabe 4
Erstelle einen Check Constraint der überprüft, ob der erste Buchstabe der Spalte `GAS_NAME` der Tabelle `GAS` groß geschrieben ist.

#### Lösung
```sql
alter table gas add constraint c_gas_name
check (gas_name = UPPER(gas_name));
```

### Aufgabe 5
Erstelle einen Check Contraint der überprüft, ob der Wert der Spalte `IDENTICATOR` der Tabelle `ACC_VEHIC` eins von diesen möglichen Fahrzeugkennzeichenmustern entspricht. Nutze Reguläre Ausdrücke.

+ B:AB:5000
+ TR:MP:1
+ Y:123456
+ THW:98765
+ MZG:XZ:96

#### Lösung
```sql
alter table acc_vehic
add constraint c_kennzeichen_entspricht
check (regexp_like(identicator, '/[A-Z]\{1,3}[:][A-Z]\{1,2}[1-9][0-9]\{0,3}'));
```

### Aufgabe 6 - Wiederholung
Liste für alle Personen den Verbrauch an Kraftstoff auf (Missachte hier die unterschiedlichen Kraftstoffe). Dabei ist interessant, wie viel Liter die einzelne Person getankt hat und wie viel Euro sie für Kraftstoffe ausgegeben hat.

#### Lösung
```sql
select liter, surname, forename, price_L, kilometer, price_l*kilometer as preis_SUMME
from receipt
inner join account on (account.account_id = receipt.account_id);
```

### Aufgabe 7 - Wiederholung
Liste die Tankstellen absteigend sortiert nach der Kundenanzahl über alle Jahre.

#### Lösung
```sql
select gas_station_id
from gas_station
order by gas_station_id desc;
```

### Aufgabe 8 - Wiederholung
Erweitere das Datenbankmodell um ein Fahrtenbuch, sowie es Unternehmen für ihren Fuhrpark führen. Dabei ist relevant, welche Person an welchem Tag ab wie viel Uhr ein Fahrzeug für die Reise belegt, wie viele Kilometer zurück gelegt wurden und wann die Person das Fahrzeug wieder abgibt.

Berücksichtige bitte jegliche Constraints!

#### Lösung
```sql
create table fahrtenbuch (
	account_name number(38) not null,
	beginn_uhrzeit time('HH:MM:SS') not null,
	beginn_date date('YYYY-MM-DD') not null,
	ende_uhrzeit time('HH:MM:SS') not null,
	end_date date('YYYY-MM-DD') not null
);
```




CREATE TABLE Fahrtenbuch
(Account_name NUMBER(38) NOT NULL, 
BEGINN_UHRZEIT time('HH:MM:SS') NOT NULL,
BEGINN_DATE date('YYYY-MM-DD') NOT NULL,
ENDE_UHRZEIT time('HH:MM:SS') NOT NULL,
END_DATE date('YYYY-MM-DD') NOT NULL,
FOREIGN KEY(Account_name) REFERENCES ACCOUNT(ACCOUNT_ID));

