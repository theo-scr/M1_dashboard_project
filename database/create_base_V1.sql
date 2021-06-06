/*
Script pour créer les tables de la base de données.
Création des tables : Article, MotCle, Vehicule, Technologie, Domaine, Marque, Pays, Auteur, Moteur, 
MotCle_Evoq, Vehicule_Evoq, Technologie_Evoq, Domaine_Evoq, Marque_Evoq, .Pays_Evoq, Auteur_Evoq et Moteur_Evoq.
*/

-- Suppression des tables (ordre inverse de création)
DROP TABLE Moteur_Evoq;
DROP TABLE Auteur_Evoq;
DROP TABLE Pays_Evoq;
DROP TABLE Marque_Evoq;
DROP TABLE Domaine_Evoq;
DROP TABLE Technologie_Evoq;
DROP TABLE Vehicule_Evoq;
DROP TABLE MotCle_Evoq;
DROP TABLE Moteur;
DROP TABLE Auteur;
DROP TABLE Marque;
DROP TABLE Pays;
DROP TABLE Domaine;
DROP TABLE Technologie;
DROP TABLE Vehicule;
DROP TABLE MotCle;
DROP TABLE Article;

-- Création des tables
CREATE TABLE Article (
    id_article NUMBER,
    titre VARCHAR(500), 
    langue VARCHAR(20),
	date_article DATE,
	
	CONSTRAINT pk_Article PRIMARY KEY(id_article)
);

CREATE TABLE MotCle (
    id_motcle NUMBER,
    mot VARCHAR(200),
	
	CONSTRAINT pk_MotCle PRIMARY KEY(id_motcle)
);

CREATE TABLE Vehicule (
    id_vehicule NUMBER,
    type_vehicule VARCHAR(20),
	
	CONSTRAINT pk_Vehicule PRIMARY KEY(id_vehicule)
);

CREATE TABLE Technologie (
    id_tech NUMBER,
    nom_tech VARCHAR(50),
    categorie VARCHAR(20),
    source VARCHAR(20),
	
	CONSTRAINT pk_Tech PRIMARY KEY(id_tech)
);

CREATE TABLE Domaine (
    id_domaine NUMBER,
    nom_domaine VARCHAR(25),
	
	CONSTRAINT pk_Domaine PRIMARY KEY(id_domaine)
);

CREATE TABLE Marque (
    id_marque NUMBER,
    nom_marque VARCHAR(50),
	
	CONSTRAINT pk_Marque PRIMARY KEY(id_marque)
);

CREATE TABLE Pays (
    id_pays NUMBER,
    nom_pays VARCHAR(50),
	
	CONSTRAINT pk_Pays PRIMARY KEY(id_pays)
);

CREATE TABLE Auteur (
    id_auteur NUMBER,
    nom_prenom VARCHAR(350),
	
	CONSTRAINT pk_Auteur PRIMARY KEY(id_auteur)
);

CREATE TABLE Moteur (
    id_moteur NUMBER,
    type_moteur VARCHAR(20),
	
	CONSTRAINT pk_Moteur PRIMARY KEY(id_moteur)
);

CREATE TABLE MotCle_Evoq (
    id_article NUMBER,
    id_motcle NUMBER,
	
	CONSTRAINT pk_MotCle_Evoq PRIMARY KEY(id_article, id_motcle),
    CONSTRAINT fk_articleMotCle_Evoq FOREIGN KEY (id_article) REFERENCES Article(id_article),
    CONSTRAINT fk_motcleMotCle_Evoq FOREIGN KEY (id_motcle) REFERENCES MotCle(id_motcle)
);

CREATE TABLE Vehicule_Evoq (
    id_article NUMBER,
    id_vehicule NUMBER,
	
	CONSTRAINT pk_Vehicule_Evoq PRIMARY KEY(id_article, id_vehicule),
    CONSTRAINT fk_articleVehicule_Evoq FOREIGN KEY (id_article) REFERENCES Article(id_article),
    CONSTRAINT fk_vehiculeVehicule_Evoq FOREIGN KEY (id_vehicule) REFERENCES Vehicule(id_vehicule)
);

CREATE TABLE Technologie_Evoq (
    id_article NUMBER,
    id_tech NUMBER,
	
	CONSTRAINT pk_Technologie_Evoq PRIMARY KEY(id_article, id_tech),
    CONSTRAINT fk_articleTechnologie_Evoq FOREIGN KEY (id_article) REFERENCES Article(id_article),
    CONSTRAINT fk_technologieTechnologie_Evoq FOREIGN KEY (id_tech) REFERENCES  Technologie(id_tech)
);

CREATE TABLE Domaine_Evoq (
    id_article NUMBER,
    id_domaine NUMBER,
	
	CONSTRAINT pk_Domaine_Evoq PRIMARY KEY(id_article, id_domaine),
    CONSTRAINT fk_articleDomaine_Evoq FOREIGN KEY (id_article) REFERENCES Article(id_article),
    CONSTRAINT fk_domaineDomaine_Evoq FOREIGN KEY (id_domaine) REFERENCES Domaine(id_domaine)
);

CREATE TABLE Marque_Evoq (
    id_article NUMBER,
    id_marque NUMBER,
	
	CONSTRAINT pk_Marque_Evoq PRIMARY KEY(id_article, id_marque),
    CONSTRAINT fk_articleMarque_Evoq FOREIGN KEY (id_article) REFERENCES Article(id_article),
    CONSTRAINT fk_marqueMarque_Evoq FOREIGN KEY (id_marque) REFERENCES Marque(id_marque)
);

CREATE TABLE Pays_Evoq (
    id_article NUMBER,
    id_pays NUMBER,
	
	CONSTRAINT pk_Pays_Evoq PRIMARY KEY(id_article, id_pays),
    CONSTRAINT fk_articlePays_Evoq FOREIGN KEY (id_article) REFERENCES Article(id_article),
    CONSTRAINT fk_paysPays_Evoq FOREIGN KEY (id_pays) REFERENCES Pays(id_pays)
);

CREATE TABLE Auteur_Evoq (
    id_article NUMBER,
    id_auteur NUMBER,
	
	CONSTRAINT pk_Auteur_Evoq PRIMARY KEY(id_article, id_auteur),
    CONSTRAINT fk_articleAuteur_Evoq FOREIGN KEY (id_article) REFERENCES Article(id_article),
    CONSTRAINT fk_auteurAuteur_Evoq FOREIGN KEY (id_auteur) REFERENCES Auteur(id_auteur)
);

CREATE TABLE Moteur_Evoq (
    id_article NUMBER,
    id_moteur NUMBER,
	
	CONSTRAINT pk_Moteur_Evoq PRIMARY KEY(id_article, id_moteur),
    CONSTRAINT fk_articleMoteur_Evoq FOREIGN KEY (id_article) REFERENCES Article(id_article),
    CONSTRAINT fk_moteurMoteur_Evoq FOREIGN KEY (id_moteur) REFERENCES Moteur(id_moteur)
);

/*
Remarque : Pas de contraintes de type not null ou de type check étant donné que l'on va insérer les données via 
Python. Nous allons faire en sorte que notre code soit suffisament propre pour qu'il n'y ait pas d'erreurs
lors de la manipulation de la base de données
*/
