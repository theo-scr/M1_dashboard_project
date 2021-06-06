/*******************************
*********** PARTIE 1 ***********
*******************************/
-- Objectif = Déterminer les véhicules/types de moteurs/types de production, etc, les plus évoqués dans les articles portant sur l'hydrogène.  

-- Les véhicules les plus évoqués 
SELECT V.type_vehicule, COUNT(VE.id_vehicule)
FROM Vehicule V, Vehicule_Evoq VE
WHERE V.id_vehicule = VE.id_vehicule
GROUP BY V.type_vehicule
ORDER BY COUNT(VE.id_vehicule) DESC;

-- Les domaines les plus évoqués 
SELECT D.nom_domaine, COUNT(DE.id_domaine)
FROM Domaine D, Domaine_Evoq DE
WHERE D.id_domaine = DE.id_domaine
GROUP BY D.nom_domaine
ORDER BY COUNT(DE.id_domaine) DESC;

-- Les types de production les plus évoqués (à comparer avec le monde de l'industrie)
SELECT T.nom_tech, COUNT(TE.id_tech)
FROM Technologie T, Technologie_Evoq TE
WHERE T. id_tech = TE.id_tech AND T.categorie = 'Production'
GROUP BY T.nom_tech
ORDER BY COUNT(T.id_tech) DESC;

-- Les sources de production les plus évoquées
SELECT T.source, COUNT(TE.id_tech)
FROM Technologie T, Technologie_Evoq TE
WHERE T. id_tech = TE.id_tech AND T.categorie = 'Production'
GROUP BY T.source
ORDER BY COUNT(T.id_tech) DESC;

-- Les types de stockage les plus évoqués
SELECT T.nom_tech, COUNT(TE.id_tech)
FROM Technologie T, Technologie_Evoq TE
WHERE T. id_tech = TE.id_tech AND T.categorie = 'Stockage'
GROUP BY T.nom_tech
ORDER BY COUNT(T.id_tech) DESC;

-- Les types de moteur les plus évoqués
SELECT M.type_moteur, COUNT(ME.id_moteur)
FROM Moteur M, Moteur_Evoq  ME
WHERE M.id_moteur = ME.id_moteur 
GROUP BY M.type_moteur
ORDER BY COUNT(M.id_moteur) DESC;

-- Les 10 auteurs ayant écrits le plus d'articles
SELECT * FROM (
    SELECT A.nom_prenom, COUNT(AE.id_auteur)
    FROM Auteur A, Auteur_Evoq AE
    WHERE A.id_auteur = AE.id_auteur
    GROUP BY A.nom_prenom
    ORDER BY COUNT(AE.id_auteur) DESC
)
WHERE ROWNUM <= 10;

-- Les 10 marques les plus évoquées
SELECT * FROM (
    SELECT M.nom_marque, COUNT(ME.id_marque)
    FROM Marque M, Marque_Evoq ME
    WHERE M.id_marque = ME.id_marque
    GROUP BY M.nom_marque
    ORDER BY COUNT(ME.id_marque) DESC
)
WHERE ROWNUM <= 10;

-- Les langues d'écriture les plus courantes.
SELECT langue, COUNT(id_article)
FROM Article
WHERE langue IS NOT NULL
GROUP BY langue
ORDER BY COUNT(id_article) DESC;

-- Les 50 mots-clés les plus fréquents.
SELECT * FROM (
    SELECT M.mot, COUNT(ME.id_motcle)
    FROM MotCle M, MotsCle_Evoq ME
    WHERE M.id_motcle = ME.id_motcle
    GROUP BY M.mot
    ORDER BY COUNT(ME.id_motcle) DESC
)
WHERE ROWNUM <= 50;


/*******************************
*********** PARTIE 2 ***********
*******************************/
-- Objectif = Lier des technologies (stockage ou production), types de moteur et domaines aux véhicules. 

-- Les technologies de stockage par types de véhicule.
SELECT V.type_vehicule, T.nom_tech, COUNT(TE.id_article)
FROM Technologie T, Technologie_Evoq TE, Vehicule V, Vehicule_Evoq VE
WHERE   VE.id_article = TE.id_article AND T. id_tech = TE.id_tech AND V.id_vehicule = VE.id_vehicule AND T.categorie = 'Stockage'
AND (SELECT COUNT(*) FROM Vehicule_Evoq VE2 WHERE VE2.id_article = VE.id_article) = 1
AND (SELECT COUNT(*) FROM Technologie_Evoq TE2 WHERE TE2.id_article = TE.id_article) = 1
GROUP BY V.type_vehicule, T.nom_tech
ORDER BY V.type_vehicule, T.nom_tech;
-- (!) Pour faire la liaison, il ne faut qu'il n'y est qu'une seule technolgoie de stockage évoquée dans l'article et qu'un seul type de véhicule. 

-- Les types de sources par types de véhicule.
SELECT V.type_vehicule, T.source, COUNT(TE.id_article)
FROM Technologie T, Technologie_Evoq TE, Vehicule V, Vehicule_Evoq VE
WHERE   VE.id_article = TE.id_article AND T. id_tech = TE.id_tech AND V.id_vehicule = VE.id_vehicule AND T.categorie = 'Production'
AND (SELECT COUNT(*) FROM Vehicule_Evoq VE2 WHERE VE2.id_article = VE.id_article) = 1
AND (SELECT COUNT(*) FROM Technologie_Evoq TE2 WHERE TE2.id_article = TE.id_article) = 1
GROUP BY V.type_vehicule, T.source
ORDER BY V.type_vehicule, COUNT(TE.id_article) DESC;

-- Les types de moteurs par types de véhicule.
SELECT V.type_vehicule, M.type_moteur, COUNT(ME.id_article)
FROM Moteur M, Moteur_Evoq ME, Vehicule V, Vehicule_Evoq VE
WHERE   VE.id_article = ME.id_article AND M.id_moteur = ME.id_moteur AND V.id_vehicule = VE.id_vehicule
AND (SELECT COUNT(*) FROM Vehicule_Evoq VE2 WHERE VE2.id_article = VE.id_article) = 1
AND (SELECT COUNT(*) FROM Moteur_Evoq ME2 WHERE ME2.id_article = ME.id_article) = 1
GROUP BY V.type_vehicule, M.type_moteur
ORDER BY V.type_vehicule ASC, COUNT(ME.id_article) DESC;

-- Les technologies de production pour la voiture uniquement (sinon trop de combinaisons possibles).
SELECT T.nom_tech, COUNT(TE.id_article)
FROM Technologie T, Technologie_Evoq TE, Vehicule V, Vehicule_Evoq VE
WHERE   VE.id_article = TE.id_article AND T. id_tech = TE.id_tech AND V.id_vehicule = VE.id_vehicule AND T.categorie = 'Production' AND V.type_vehicule = 'Voiture'
AND (SELECT COUNT(*) FROM Vehicule_Evoq VE2 WHERE VE2.id_article = VE.id_article) = 1
AND (SELECT COUNT(*) FROM Technologie_Evoq TE2 WHERE TE2.id_article = TE.id_article) = 1
GROUP BY T.nom_tech
ORDER BY COUNT(TE.id_article) DESC;


/*******************************
*********** PARTIE 3 ***********
*******************************/
-- Obj = Analyser par année 

-- (1) Très classique : 

-- Evolution du nombre d'articles par année 
SELECT to_char(date_article,'YYYY'), COUNT(id_article)
FROM Article
WHERE to_char(date_article,'YYYY') IS NOT NULL AND to_char(date_article,'YYYY') < 2021
GROUP BY to_char(date_article,'YYYY')
ORDER BY to_char(date_article,'YYYY');

-- (2) Element les plus cités chaque année : 

-- Source d'hydrogène la plus citée chaque année 
SELECT to_char(A.date_article,'YYYY'), T.source, count(A.id_article) 
FROM Article A, Technologie T, Technologie_Evoq TE
WHERE A.id_article = TE.id_article AND T.id_tech = TE.id_tech AND T.categorie = 'Production' AND to_char(A.date_article,'YYYY') <2021 AND to_char(A.date_article,'YYYY') >1989 
HAVING count(A.id_article) = (
    SELECT MAX(COUNT(A2.id_article))
    FROM Article A2, Technologie T2, Technologie_Evoq TE2
    WHERE A2.id_article = TE2.id_article AND T2.id_tech = TE2.id_tech AND to_char(A2.date_article,'YYYY') = to_char(A.date_article,'YYYY') AND T2.categorie = 'Production' 
    GROUP BY T2.source
)
GROUP BY to_char(A.date_article,'YYYY'), T.source
ORDER BY to_char(A.date_article,'YYYY'), count(A.id_article);

-- Type de stockage le plus cité chaque année 
SELECT to_char(A.date_article,'YYYY'), T.nom_tech, count(A.id_article) 
FROM Article A, Technologie T, Technologie_Evoq TE
WHERE A.id_article = TE.id_article AND T.id_tech = TE.id_tech AND T.categorie = 'Stockage' AND to_char(A.date_article,'YYYY') <2021
HAVING count(A.id_article) = (
    SELECT MAX(COUNT(A2.id_article))
    FROM Article A2, Technologie T2, Technologie_Evoq TE2
    WHERE A2.id_article = TE2.id_article AND T2.id_tech = TE2.id_tech AND to_char(A2.date_article,'YYYY') = to_char(A.date_article,'YYYY') AND T2.categorie = 'Stockage'  AND to_char(A.date_article,'YYYY') >1990 
    GROUP BY T2.nom_tech
)
GROUP BY to_char(A.date_article,'YYYY'), T.nom_tech
ORDER BY to_char(A.date_article,'YYYY'), count(A.id_article);

-- Type de véhicule le plus cité chaque année 
SELECT to_char(A.date_article,'YYYY'), V.type_vehicule, count(A.id_article) 
FROM Article A, Vehicule V, Vehicule_Evoq VE
WHERE A.id_article = VE.id_article AND V.id_vehicule = VE.id_vehicule AND to_char(A.date_article,'YYYY') <2021 AND to_char(A.date_article,'YYYY') >1990 
HAVING COUNT(A.id_article) = (
    SELECT MAX(COUNT(A2.id_article))
    FROM Article A2, Vehicule V2, Vehicule_Evoq VE2
    WHERE A2.id_article = VE2.id_article AND V2.id_vehicule = VE2.id_vehicule AND to_char(A2.date_article,'YYYY') = to_char(A.date_article,'YYYY')
    GROUP BY V2.type_vehicule
)
GROUP BY to_char(A.date_article,'YYYY'), V.type_vehicule
ORDER BY to_char(A.date_article,'YYYY'), count(A.id_article);

-- Pays le plus cité chaque année 
SELECT to_char(A.date_article,'YYYY'), P.nom_pays, count(A.id_article) 
FROM Article A, Pays P, Pays_Evoq PE
WHERE A.id_article = PE.id_article AND P.id_pays = PE.id_pays AND to_char(A.date_article,'YYYY') <2021  AND to_char(A.date_article,'YYYY') >1990 
HAVING COUNT(A.id_article) = (
    SELECT MAX(COUNT(A2.id_article))
    FROM Article A2, Pays P2, Pays_Evoq PE2
    WHERE A2.id_article = PE2.id_article AND P2.id_pays = PE2.id_pays AND to_char(A2.date_article,'YYYY') = to_char(A.date_article,'YYYY')
    GROUP BY P2.nom_pays
)
GROUP BY to_char(A.date_article,'YYYY'), P.nom_pays
ORDER BY to_char(A.date_article,'YYYY'), count(A.id_article);

-- Marque la plus citée chaque année 
SELECT to_char(A.date_article,'YYYY'), M.nom_marque, count(A.id_article) 
FROM Article A, Marque M, Marque_Evoq ME
WHERE A.id_article = ME.id_article AND M.id_marque = ME.id_marque AND to_char(A.date_article,'YYYY') <2021 AND to_char(A.date_article,'YYYY') >1990 
HAVING COUNT(A.id_article) = (
    SELECT MAX(COUNT(A2.id_article))
    FROM Article A2, Marque M2, Marque_Evoq ME2
    WHERE A2.id_article = ME2.id_article AND M2.id_marque = ME2.id_marque AND to_char(A2.date_article,'YYYY') = to_char(A.date_article,'YYYY')
    GROUP BY M2.nom_marque
)
GROUP BY to_char(A.date_article,'YYYY'), M.nom_marque
ORDER BY to_char(A.date_article,'YYYY'), COUNT(A.id_article);


-- Requêtes éliminées par non-pertinentes :
/*
-- Domaine le plus cité chaque année 
SELECT to_char(A.date_article,'YYYY'), D.nom_domaine, count(A.id_article) 
FROM Article A, Domaine D, Domaine_Evoq DE
WHERE A.id_article = DE.id_article AND D.id_domaine = DE.id_domaine AND to_char(A.date_article,'YYYY') <2021 AND to_char(A.date_article,'YYYY') >1990 
HAVING COUNT(A.id_article) = (
    SELECT MAX(COUNT(A2.id_article))
    FROM Article A2, Domaine D2, Domaine_Evoq DE2
    WHERE A2.id_article = DE2.id_article AND D2.id_domaine = DE2.id_domaine AND to_char(A2.date_article,'YYYY') = to_char(A.date_article,'YYYY')
    GROUP BY D2.nom_domaine
)
GROUP BY to_char(A.date_article,'YYYY'), D.nom_domaine
ORDER BY to_char(A.date_article,'YYYY'), COUNT(A.id_article);

-- Type de moteur le plus cité chaque année 
SELECT to_char(A.date_article,'YYYY'), M.type_moteur, count(A.id_article) 
FROM Article A, Moteur M, Moteur_Evoq ME
WHERE A.id_article = ME.id_article AND M.id_moteur = ME.id_moteur AND to_char(A.date_article,'YYYY') <2021
HAVING COUNT(A.id_article) = (
    SELECT MAX(COUNT(A2.id_article))
    FROM Article A2, Moteur M2, Moteur_Evoq ME2
    WHERE A2.id_article = ME2.id_article AND M2.id_moteur = ME2.id_moteur AND to_char(A2.date_article,'YYYY') = to_char(A.date_article,'YYYY')
    GROUP BY M2.type_moteur
)
GROUP BY to_char(A.date_article,'YYYY'), M.type_moteur
ORDER BY to_char(A.date_article,'YYYY'), count(A.id_article);

-- La technologie la plus citée chaque année.
SELECT to_char(A.date_article,'YYYY'), T.nom_tech, count(A.id_article) 
FROM Article A, Technologie T, Technologie_Evoq TE
WHERE A.id_article = TE.id_article AND T.id_tech = TE.id_tech AND T.categorie = 'Production' AND to_char(A.date_article,'YYYY') <2021
HAVING count(A.id_article) = (
    SELECT MAX(COUNT(A2.id_article))
    FROM Article A2, Technologie T2, Technologie_Evoq TE2
    WHERE A2.id_article = TE2.id_article AND T2.id_tech = TE2.id_tech AND to_char(A2.date_article,'YYYY') = to_char(A.date_article,'YYYY') AND T2.categorie = 'Production' 
    GROUP BY T2.nom_tech
)
GROUP BY to_char(A.date_article,'YYYY'), T.nom_tech
ORDER BY to_char(A.date_article,'YYYY'), count(A.id_article);
*/


/*******************************
*********** PARTIE 4 ***********
*******************************/
-- Obj = Analyser par pays 

-- Les pays les plus évoqués dans les articles de véhicules hydrogènes (top 15).
SELECT * FROM (
    SELECT P.nom_pays, COUNT(PE.id_pays)
    FROM Pays_Evoq PE, Pays P
    WHERE P.id_pays = PE.id_pays
    GROUP BY P.nom_pays
    ORDER BY COUNT(PE.id_pays) DESC
)
WHERE ROWNUM <= 15;

-- Cas 1 : A quels types de véhicules s'intéressent le plus les 10 premiers pays les plus évoqués dans les articles. 
SELECT P2.nom_pays, V2.type_vehicule, COUNT(A2.id_article)
FROM Article A2, Vehicule V2, Vehicule_Evoq VE2, Pays P2, Pays_Evoq PE2
WHERE A2.id_article = VE2.id_article AND V2.id_vehicule = VE2.id_vehicule AND A2.id_article = PE2.id_article AND P2.id_pays = PE2.id_pays 
AND P2.nom_pays IN (
    SELECT * FROM (
        SELECT P.nom_pays
        FROM Pays_Evoq PE, Pays P
        WHERE P.id_pays = PE.id_pays
        GROUP BY P.nom_pays
        ORDER BY COUNT(PE.id_pays) DESC
    )
    WHERE ROWNUM <= 10)
AND V2.type_vehicule IN (
    SELECT * FROM (
        SELECT V.type_vehicule
        FROM Vehicule V, Vehicule_Evoq VE, Article A, Pays_Evoq PE
        WHERE V.id_vehicule = VE.id_vehicule AND A.id_article = PE.id_article AND A.id_article = VE.id_article AND PE.id_pays = PE2.id_pays
        GROUP BY V.type_vehicule
        ORDER BY COUNT(VE.id_vehicule) DESC
    )
    WHERE ROWNUM <= 3)
GROUP BY P2.nom_pays, V2.type_vehicule
ORDER BY P2.nom_pays, COUNT(A2.id_article) DESC;

-- Cas n°2 : Selon les types de véhicules, quels sont les pays qui s'y intéressent le plus. 
SELECT V2.type_vehicule, P2.nom_pays, COUNT(A2.id_article)
FROM Article A2, Vehicule V2, Vehicule_Evoq VE2, Pays P2, Pays_Evoq PE2
WHERE A2.id_article = VE2.id_article AND V2.id_vehicule = VE2.id_vehicule AND A2.id_article = PE2.id_article AND P2.id_pays = PE2.id_pays 
AND P2.nom_pays IN (
    SELECT * FROM (
        SELECT P.nom_pays
        FROM Pays_Evoq PE, Pays P
        WHERE P.id_pays = PE.id_pays
        GROUP BY P.nom_pays
        ORDER BY COUNT(PE.id_pays) DESC
    )
    WHERE ROWNUM <= 10)
AND V2.type_vehicule IN (
    SELECT * FROM (
        SELECT V.type_vehicule
        FROM Vehicule V, Vehicule_Evoq VE, Article A, Pays_Evoq PE
        WHERE V.id_vehicule = VE.id_vehicule AND A.id_article = PE.id_article AND A.id_article = VE.id_article AND PE.id_pays = PE2.id_pays
        GROUP BY V.type_vehicule
        ORDER BY COUNT(VE.id_vehicule) DESC
    )
    WHERE ROWNUM <= 3)
GROUP BY P2.nom_pays, V2.type_vehicule
ORDER BY V2.type_vehicule, COUNT(A2.id_article) DESC;

