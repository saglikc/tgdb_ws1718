# Tutorium - Grundlagen Datenbanken - Blatt 2

## Vorbereitungen
* Für dieses Aufgabenblatt wird die SQL-Dump-Datei `uebung02.sql` benötigt, die sich im Verzeichnis `sql` befindet.
* Die SQL-Dump-Datei wird in SQL-Plus mittels `start <Dateipfad/zur/sql-dump-datei.sql>` in die Datenbank importiert.
* Beispiele
  * Linux `start ~/Tutorium.sql`
  * Windows `start C:\Users\max.mustermann\Desktop\Tutorium.sql`

## Datenbankmodell
![Datenbankmodell](./img/datamodler_schema.png)

## Aufgaben

### Aufgabe 1
Schaue dir das Datenbankmodell an. Wofür steht hinter dem Datentyp `NUMBER` die Zahlen in den runden Klammern?

#### Lösung
> Dezimalzahl mit insgesamt n Stellen

### Aufgabe 2
Was bedeuten die durchgezogenen Linien die zwischen einigen Tabellen abgebildet sind?.

#### Lösung
Die durchgezogene Linie bildet eine Beziehung zwischen zwei Tabellen ab. Sie muss aufgefüllt werden. 

### Aufgabe 3
Was bedeutet die gestrichelte Linie die zwischen der Tabelle `ACC_VEHIC` und `GAS_STATION` abgebildet ist?

#### Lösung
> Sie beschreibt eine beziehung zwischen zwei Tabellen, die optional ausgefüllt werden kann.


### Aufgabe 3
Die folgende Abbildung beschreibt eine Beziehung zwischen Tabellen. Sie wird auch `n` zu `m` Beziehung genannt. Beschreibe kurz die Bedeutung dieser Beziehung.

![n-to-m-relationship](./img/n-to-m-relationship.png)

> Eine m zu n Beziehung beschreibt, dass n Datensätze mit m Datensätze verknüpft werden können. In diesem Beispiel haben n Personen im Hobby die in der Tabelle PERSON_HOBBY gespeichert werden.

### Aufgabe 4
Was bedeutet der Buchstabe `P` und `F` neben den Attributen von Tabellen?

#### Lösung
> P für Primärschlüssel (Primary Key) und F für Fremdschlüssel (Foreign Key)

### Aufgabe 5
Importiere die SQL-Dump-Datei in dein eigenes Schema. Wie lautet dazu der Befehl um dem import zu starten?

#### Lösung
```sql
start 'C:/Users/<username>/tutorium.sql'
```

### Aufgabe 6
Lasse dir alle vorhanden Fahrzeugklassen aus der Tabelle `VEHICLE_TYPE` ausgeben. Suche nun nach allen Benutzern (`SURNAME`, `FORNAME`), die ein Auto besitzen.

#### Lösung
```sql
SELECT SURNAME
FROM ACCOUT
INNER JOIN ACC_VEHIC
ON ACCOUNT.ACCOUNT_ID = ACC_VEHIC.ACCOUNT_ID;
```

### Aufgabe 7
Kombiniere aus Aufgabe 6 beide Abfrage zu einer Abfrage.

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 8
Modifizierde die Aufgabe 7 so, dass nur der Benutzer mit der `ACCOUNT_ID` = `7` angezeigt wird.

#### Lösung
```sql
SELECT SURNAME
FROM ACCOUNT
INNER JOIN ACC_VEHIC ON (aACCOUNT.ACCOUNT_ID = ACC_VEHIC.ACCOUNT_ID
WHERE ACCOUNT.ACCOUNT_ID = 7;
```

### Aufgabe 9
Erstelle für dich einen neuen Benutzer.
> Achtung, nutze für die Spalten `C_DATE` und `U_DATE` vorerst die Syntax `SYSDATE` - [Dokumentation](https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions172.htm)

#### Lösung
```sql
Deine Lösung
```

### Aufgabe 10
Erstelle für deinen neuen Benutzer ein neues Auto. Dieses Auto dient als Vorlage für die nächten Aufgabem.

#### Lösung
```sqld
Deine Lösung
```

### Aufgabe 11
Verknüpfe das aus Aufgabe 10 erstellte neue Auto mit deinem neuen Benutzer aus Aufgabe 9 in der Tabelle `ACC_VEHIC` und erstelle den ersten Rechnungsbeleg.

#### Lösung
```sql
Deine Lösung
```

