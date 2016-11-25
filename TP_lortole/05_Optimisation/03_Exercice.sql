/*
Exercice 3
*/


/*
1. Exprimez la requête donnez le nom, la latitude et la longitude des communes qui se situent
dans les départements de l’Hérault et du Gard sous différentes formes (expression d’une semi-
jointure) :
-sous forme de jointure
-sous forme de requête imbriquée (test de vacuité (exists) et test d’appartenance (in)).
Quelle est l’écriture qui vous semble la moins coûteuse (utilisez settiming et explain ) ?
Quels sont les opérateurs physiques exploités respectivement pour exprimer la jointure ?
Exploiter les directives (hint) pour forcer le choix d’un opérateur (par exempleuse nl).

Construisez sur papier un arbre algébrique puis les plans physiques correspondant à chaque plan d’exécution choisi.

*/


/* sous forme de jointure */
select 	nom_com ,	longitude ,	latitude
from commune C , departement D
where C.dep = D.dep and (D.nom_dep='HERAULT' OR D.nom_dep='GARD')
;

explain plan for select 	nom_com ,	longitude ,	latitude
from commune C , departement D
where C.dep = D.dep and (D.nom_dep='HERAULT' OR D.nom_dep='GARD')
;

select plan_table_output from table(dbms_xplan.display()) ;

/*

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
Plan hash value: 174368243

--------------------------------------------------------------------------------
--

| Id  | Operation	   | Name	 | Rows  | Bytes | Cost (%CPU)| Time
 |

--------------------------------------------------------------------------------
--


PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |		 |   757 | 28766 |   584   (1)| 00:00:08
 |

|*  1 |  HASH JOIN	   |		 |   757 | 28766 |   584   (1)| 00:00:08
 |

|*  2 |   TABLE ACCESS FULL| DEPARTEMENT |     2 |    26 |     3   (0)| 00:00:01
 |

|   3 |   TABLE ACCESS FULL| COMMUNE	 | 36318 |   886K|   581   (1)| 00:00:07
 |

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--


Predicate Information (identified by operation id):
---------------------------------------------------

   1 - access("C"."DEP"="D"."DEP")
   2 - filter("D"."NOM_DEP"='GARD' OR "D"."NOM_DEP"='HERAULT')

16 rows selected.


*/

/* -sous forme de requête imbriquée (test de vacuité (exists) et test d’appartenance (in)).  */
select 	nom_com ,	longitude ,	latitude
from commune C
where C.dep in  ( select dep from departement D where D.nom_dep='HERAULT' OR D.nom_dep='GARD')
;

explain plan for select 	nom_com ,	longitude ,	latitude
from commune C
where C.dep in  ( select dep from departement D where D.nom_dep='HERAULT' OR D.nom_dep='GARD')
;
select plan_table_output from table(dbms_xplan.display()) ;


/*
PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
Plan hash value: 174368243

--------------------------------------------------------------------------------
--

| Id  | Operation	   | Name	 | Rows  | Bytes | Cost (%CPU)| Time
 |

--------------------------------------------------------------------------------
--


PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |		 |   757 | 28766 |   584   (1)| 00:00:08
 |

|*  1 |  HASH JOIN	   |		 |   757 | 28766 |   584   (1)| 00:00:08
 |

|*  2 |   TABLE ACCESS FULL| DEPARTEMENT |     2 |    26 |     3   (0)| 00:00:01
 |

|   3 |   TABLE ACCESS FULL| COMMUNE	 | 36318 |   886K|   581   (1)| 00:00:07
 |

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--


Predicate Information (identified by operation id):
---------------------------------------------------

   1 - access("C"."DEP"="DEP")
   2 - filter("D"."NOM_DEP"='GARD' OR "D"."NOM_DEP"='HERAULT')

16 rows selected.

*/


select 	nom_com ,	longitude ,	latitude
from commune C
where exists  ( select * from departement D where C.dep = D.dep and (D.nom_dep='HERAULT' OR D.nom_dep='GARD'))
;

explain plan for select 	nom_com ,	longitude ,	latitude
from commune C
where exists  ( select * from departement D where C.dep = D.dep and (D.nom_dep='HERAULT' OR D.nom_dep='GARD'))
;
select plan_table_output from table(dbms_xplan.display()) ;

/*

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
Plan hash value: 1911161922

--------------------------------------------------------------------------------
----

| Id  | Operation	     | Name	   | Rows  | Bytes | Cost (%CPU)| Time
   |

--------------------------------------------------------------------------------
----


PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |		   |   757 | 28766 |   584   (1)| 00:00:
08 |

|*  1 |  HASH JOIN RIGHT SEMI|		   |   757 | 28766 |   584   (1)| 00:00:
08 |

|*  2 |   TABLE ACCESS FULL  | DEPARTEMENT |	 2 |	26 |	 3   (0)| 00:00:
01 |

|   3 |   TABLE ACCESS FULL  | COMMUNE	   | 36318 |   886K|   581   (1)| 00:00:
07 |

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
----


Predicate Information (identified by operation id):
---------------------------------------------------

   1 - access("C"."DEP"="D"."DEP")
   2 - filter("D"."NOM_DEP"='GARD' OR "D"."NOM_DEP"='HERAULT')

16 rows selected.


*/

/*
2. Ecrivez la requête donnez le nom et la population 2010 des communes qui ont plus d’habitants
que le nombre moyen d’habitants par commune. Exploitez le plan d’exécution pour cette requête.
Quelles sont les opérations exploitées par l’optimiseur ?
*/


/*
3. Ecrivez la requête de différentes mani`eres : donnez le nom des communes, le nom de leur
département et de leur région respectifs lorsque ces communes sont situées dans les régions Midi-
Pyrénées, Languedoc-Roussillon et Provence-Alpes-Côte d’Azur. Commentez les plans d’exécution obtenus.
*/
