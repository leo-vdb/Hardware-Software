# Servo Receiver with DE0-Nano-SoC
Projet du cours d'Hardware/Software à la Faculté Polytechnique de Mons, année académique 2022-2023. 

Membres du groupe : Tom LEROY (tom.LEROY@student.umons.ac.be), Maxime VANDENHENDE (maxime.VANDENHENDE@student.umons.ac.be) et Léo VANDER BEKEN (leo.VANDERBEKEN@student.umons.ac.be)

Dans le cadre du cours d'Hardware/Software, il nous est demandé de lire des données envoyées par un servo moteur à l'aide du kit de développement DE0_Nano_SoC. Ces données sont en fait la période signal envoyé par le servo moteur. Pour ce faire, nous allons proposer un tutoriel sur la méthodologie à adopter pour y arriver. 
Ce dernier va être diviser en 2 parties principales : l'Hardware et le Software. 

1) Partie Hardware :

Dans cette partie, le responsable Hardware va devoir choisir et implementer les I/O dans la fonctionnalité "Platform Designer" du logiciel "Quartus" tel que le démontre la figure suivante :

![Platform_Designer](Platform_Designer_System_Content.PNG)



De plus, il doit compléter le "FPGA_TOP.v" pour ajouter le bloc relatif à ce projet contenant les I/O, clk, rst, ... utilisés comme dans la figure suivante :

![FPGA_TOP](modif_FPGA_TOP.png)

Ensuite, il devra écrire un programme mettant en place un compteur et un lecteur de fréquence. Celui-ci est le lien entre les parties Hardware et Software. Le compteur relèvera le nombre de battements d'horloge entre 2 états permettant ensuite à la détermination de la fréquence. Cela est démontré dans le fichier "ServoIn.vhd" dont voici le code commenté :  

![Driver1](driver1.png)

![Driver2](driver2.png)


On peut d'ailleurs observer sur RTL view, une représentation de la connexion entre le wrapper et le driver :

![RTLview](RTL_VIEW_DRIVER.png)



Enfin, il devra créer un TestBench à partir du fichier "ServoIn_TB.vhd" afin de simuler le comportement du programme cité ci-dessus.

Le signal à une période 20 ms comme on peut voir à l'image suivante : 
![période](rtlview_période20ms.png)

Ensuite, les pulsations doivent durer entre 1 et 2 ms, ce qui est confirmé dans les images suivantes : 

![1ms](RTL_Simu_sPulsefromGPIO_1ms.PNG)
![1,5ms](RTL_Simu_sPulsefromGPIO_15ms.PNG)
![2ms](RTL_Simu_sPulsefromGPIO_2ms.PNG)

Et donc grâce au compteur de 8 bits, on retrouve la valeur de notre angle : 

![angle](RTL_Simu_Longueur_signal_Data_to_pin_reg_1_angle.PNG)

Ainsi on peut observer la valeur de l'angle. 



2) Partie Software : 

Dans cette partie, le responsable Software va devoir créer la foction permettant de lire les données envoyées par la partie Hardware et de transformer ces données en valeur d'angle dans le fichier "driver.c". Cette fonction s'appelle "servo_robert()" et se définit comme suit : 

![fonction](servo_robert.png)

Ensuite, il va falloir modifier le fichier main.c, afin de permettre d'afficher les informations reçues par la partie Hardware. En d'autres mots, afficher la valeur de l'angle determinée grâce au compteur. De plus, le responsable devra connecter le processeur à l'ordinateur, d'y envoyer les programmes nécessaires et de le faire fonctionner. 









 
