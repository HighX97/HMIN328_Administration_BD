/*
L'adresse de chaque enregistrement sur le disque (identifiant de ligne ou rowid) renferme diff ́erentes
informations `a l'exemple du num ́ero de l'enregistrement, du num ́ero de l'objet associ ́e (table ou index),
du bloc de donn ́ees qui contient cet enregistrement, ou de l'adresse relative du fichier qui contient les
blocs de donn ́ees. Le paquetage DBMS ROWID permet d'exploiter l'ensemble de cette information.
Des exemples vous sont donn ́es :
*/
DECLARE
object_no
integer;
row_no integer;
row_id ROWID;
BEGIN
SELECT ROWID INTO row_id FROM commune
WHERE codeInsee = '34172';
object_no := DBMS_ROWID.ROWID_OBJECT(row_id);
row_no := DBMS_ROWID.ROWID_ROW_NUMBER(row_id);
DBMS_OUTPUT.PUT_LINE('The obj. # is '||object_no||' '||row_no);
END;
/
SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid), DBMS_ROWID.ROWID_OBJECT(rowid), nom_com
FROM Commune where codeInsee = '34172';
-- nom de la structure de table ou d'index
select owner, object_name from dba_objects where data_object_id = ...

/*
Vous construirez une proc ́edure PL/SQL qui permet d'afficher tous les enregistrements (codeInsee,
nom com) contenus dans le mˆeme bloc de donn ́ees qu'un enregistrement donn ́e de la table Commune
(par exemple l'enregistrement dont le code INSEE est 34172). Le nombre de tuples list ́es par bloc est
t'il en accord avec les informations collect ́ees dans la vue user tables
*/

select blocks, avg_row_len from user_tables where table_name ='COMMUNE';
