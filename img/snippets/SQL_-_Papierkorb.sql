/*
  @author:  Markus Pesch
  @date:    29.11.2015
  @email:   peschm@fh-trier.de
*/

/* Gel�schte Tabellen sind bin BIN$ gekennzeichnet */
SELECT TNAME
FROM tab;

/* Papierkorb l�schen */
PURGE RECYCLEBIN;

/* Papierkorb Inhalt anzeigen */
SELECT *
FROM RECYLEBIN;

/* Papierkorb beschreibung */
desc recyclebin;

/* Tabelle l�schen trotz Constraint */
DROP TABLE <TABELLENNAME> CASCADE CONSTRAINTS;

/* Tabelle endg�ltig l�schen */
DROP TABLE <TABELLENNAME> PURGE;

/* Alle Tabellen l�schen */
-- Generiert SQL-Statements
SELECT 'DROP TABLE ' ||table_name|| ' CASCADE CONSTRAINTS;'
FROM USER_TABLES;

/* Wiederherstellen einer Tabelle */
FLASHBACK TABLE HUGO TO BEFORE DROP;
