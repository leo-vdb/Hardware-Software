# Servo Receiver with DE0-Nano-SoC
Projet du cours d'Hardware/Software à la Faculté Polytechnique de Mons, année académique 2022-2023. 

Membres du groupe : Tom LEROY (tom.LEROY@student.umons.ac.be), Maxime VANDENHENDE (maxime.VANDENHENDE@student.umons.ac.be) et Léo VANDER BEKEN (leo.VANDERBEKEN@student.umons.ac.be)

Dans le cadre du cours d'Hardware/Software, il nous est demandé de lire des données envoyées par un servo moteur à l'aide du kit de développement DE0_Nano_SoC. Ces données sont en fait la période signal envoyé par le servo moteur. Pour ce faire, nous allons proposer un tutoriel sur la méthodologie à adopter pour y arriver. 
Ce dernier va être diviser en 2 parties principales : l'Hardware et le Software. 

1) Partie Hardware :

Dans cette partie, le responsable Hardware va devoir choisir et implementer les I/O dans la fonctionnalité "Platform Designer" du logiciel "Quartus". De plus, il doit compléter le "ghrd" pour ajouter le bloc relatif à ce projet contenant les I/O, clk, rst, ... utilisés. Ensuite, il devra écrire un programme mettant en place un compteur et un lecteur de fréquence. Celui-ci est le lien entre les parties Hardware et Software. Le compteur relèvera le nombre de battements d'horloge entre 2 états permettant ensuite à la détermination de la fréquence. Enfin, il devra créer un TestBench afin de simuler le comportement du programme cité ci-dessus. 

2) Partie Software : 

Dans cette partie, le responsable Software va devoir modifier le programme main.c envoyé sur le processeur. Celui-ci permet d'afficher les informations reçues par la partie Hardware. En d'autres mots, 



 
