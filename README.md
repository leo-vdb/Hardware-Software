# Servo Receiver with DE0-Nano-SoC
Projet du cours d'Hardware/Software à la Faculté Polytechnique de Mons, année académique 2022-2023. 

Membres du groupe : Tom LEROY (tom.LEROY@student.umons.ac.be), Maxime VANDENHENDE (maxime.VANDENHENDE@student.umons.ac.be) et Léo VANDER BEKEN (leo.VANDERBEKEN@student.umons.ac.be)

Dans le cadre du cours d'Hardware/Software, il nous est demandé de lire des données envoyées par un servo moteur à l'aide du kit de développement DE0_Nano_SoC. Ces données sont en fait la période signal envoyé par le servo moteur. Pour ce faire, nous allons proposer un tutoriel sur la méthodologie à adopter pour y arriver. 
Ce dernier va être diviser en 2 parties principales : l'Hardware et le Software. 

1) Partie Hardware :

Dans cette partie, le responsable Hardware va devoir choisir et implementer les I/O dans la fonctionnalité "Platform Designer" du logiciel "Quartus" tel que le démontre la figure suivante :

![Platform_Designer](Platform_Designer_System_Content.PNG)



De plus, il doit compléter le "FPGA_TOP" pour ajouter le bloc relatif à ce projet contenant les I/O, clk, rst, ... utilisés comme dans la figure suivante :

![FPGA_TOP](modif_FPGA_TOP.png)

Ensuite, il devra écrire un programme mettant en place un compteur et un lecteur de fréquence. Celui-ci est le lien entre les parties Hardware et Software. Le compteur relèvera le nombre de battements d'horloge entre 2 états permettant ensuite à la détermination de la fréquence. Voici le code commenté : 


begin
		if RST = '0' then --le reset est à zéro 
			count :=0; -- le conteur est à zéro lors que l'on débute le process 
			state <= s0; -- on se trouve alors dans l'état s0
		elsif rising_edge(CLK) then --on rencontre un front montant de la part de la clock 
			case state is -- l'état dans lequel le système se trouve sera le suivant : 
				when s0 =>
					count :=0; -- incrémenter deja à s0 si ok ; on est en s0 <-> le conteur est à 0 
					--if ENABLE_IN = '1' then
						if PULSE_from_GPIO_0_1_in='1'then --si le signal que l'on reçoit est "haut" alors on passe à l'état s1
							state <= s1;
						end if;
				
				when s1 => -- lorsque l'on est dans l'état s1 : S
					count := count + 1; --incrémentation du conteur 
						if PULSE_from_GPIO_0_1_in='0'then -- lorsque le signal reçu est ré instancié à zéro alors : 
							DATA_to_pio_reg_in_1 <= std_logic_vector(to_unsigned((count-min)*b/min,8)); -- on lit/sauvegarde la donnée (sur 8 bit) qui retranstrict la longueur du signal (normalement comprise entre 1ms et 2ms) 
							state <= s2; --on passe alors à l'état s2 (qui permettra de lire la valeur de la fréquence du signal) 
						
												
--						-- Vérification de la longueur du signal grâce à l'allumage de LED_BUSY
--							if ((count >= ((1-(1/b)) ms)) and (count <= ((2+(1/b)) ms))) then -- la led s'allume si on vérifie que la longueur du signal se trouve bien entre 1ms-1/255 (borne inf) et 2ms+1/255 (borne sup)
--                            sLED_BUSY <= '1';
--							else
--                            sLED_BUSY <= '0';
--							end if;
 						end if;
												
											
				
				when s2 => --on se trouve dans l'état 2 : 
					count := count + 1; --on continue à incrémenter le conteur 
						if PULSE_from_GPIO_0_1_in='1'then --le signal reçu de la part du servo sender se trouve à l'état "haut" 
							DATA_to_pio_reg_in_2 <= std_logic_vector(to_unsigned((k/count),8)); --on stocke dans une 2nd variable/registre la valeur de la fréquence lue (que l'on reçoit de la part du servo sender)  
							count :=0; --on ré initialise le conteur à zéro 
							if RST = '1' then --le reset se trouve dans l'état haut : 
								state <=s1; -- l'état du système repasse à l'état s1
							else
								state <= s0; --si le reset n'est pas à l'état haut lorsque l'on est sorti du process s2 alors on retourne à l'état s0 
							end if;
						end if;
						when others => -- dans les autres cas, on reste en l'état s0 et le compteur est à zéro 
					count :=0;
					state <= s0;
			end case;



Enfin, il devra créer un TestBench afin de simuler le comportement du programme cité ci-dessus.




2) Partie Software : 

Dans cette partie, le responsable Software va devoir modifier le programme main.c envoyé sur le processeur. Celui-ci permet d'afficher les informations reçues par la partie Hardware. En d'autres mots, afficher la fréquence determinée grâce au compteur et au lecteur de fréquence. De plus, le responsable devra connecter le processeur à l'ordinateur, d'y envoyer les programmes nécessaires et de le faire fonctionner. Pour finir, il faudra lire les signaux reçus via le processeur à partir de l'oscilloscope. 






 
