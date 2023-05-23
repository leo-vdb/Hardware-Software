-- driver_in_example_3

	-- uses a counter to measure the width in clock cycles 
	-- of the GPIO input port
	-- The multiplication factor is used to resize the result to 255 max value
	-- The resulting measured width is sent to the software PIO register
	-- DATA_RDY_to_pio_reg_inout_4	1 = pulse width
	-- DATA_to_pio_reg_in -- pulse width  
	-- BUSY_to_pio_reg_inout_3 inpt  busy 
	-- OVERFLOW_to_pio_reg_inout_5 s_overflow 

	
library ieee;
use IEEE.STD_LOGIC_1164.ALL;

entity ServoIn is
	generic (
		DATA_WIDTH: natural := 8;
		MULTIPLIER: natural := 1		
	);
	port (		-- initialisation des différents ports / éléments utilisée pour le servo receiver 
		CLK							: in std_logic;
		RST							: in std_logic;
		LED_BUSY					: out std_logic; -- busy
		LED_DRDY					: out std_logic; -- data ready 
		PULSE_from_GPIO_0_1_in		: in std_logic; -- peripheral input (RX)
		DATA_to_pio_reg_in_1			: out std_logic_vector(7 downto 0);
		DATA_to_pio_reg_in_2			: out std_logic_vector(7 downto 0)
		--ENABLE_IN		: in std_logic
		
		
	);
end ServoIn;

library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


architecture RTL of ServoIn is	-- Instanciation de l'architecture (RTL view) du Servo Receiver 
type state_type is (s0,s1,s2,s3);
	 signal state : state_type; 
	 signal sLED_BUSY : std_logic :='0';
begin 
	process (CLK,RST,PULSE_from_GPIO_0_1_in)
		
		variable count : natural :=0;
		constant k : natural :=50000000;
		constant min : natural :=50000;
		constant b : natural :=255;
				
		
	begin
		if RST = '1' then --le reset est à un 
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
							DATA_to_pio_reg_in_1 <= std_logic_vector(to_unsigned((count-min)*b/min,8)); -- on lit/sauvegarde la donnée (sur 8 bit)
							--qui retranstrict la longueur du signal (normalement comprise entre 1ms et 2ms)
							state <= s2; --on passe alors à l'état s2 (qui permettra de lire la valeur de la fréquence du signal) 
						
												
--						-- Vérification de la longueur du signal grâce à l'allumage de LED_BUSY
--							if ((count >= ((1-(1/b)) ms)) and (count <= ((2+(1/b)) ms))) then -- la led s'allume si on vérifie 
--							--que la longueur du signal se trouve bien entre 1ms-1/255 (borne inf) et 2ms+1/255 (borne sup)
--                            sLED_BUSY <= '1';
--							else
--                            sLED_BUSY <= '0';
--							end if;
 						end if;
												
											
				
				when s2 => --on se trouve dans l'état 2 : 
					count := count + 1; --on continue à incrémenter le conteur 
						if PULSE_from_GPIO_0_1_in='1'then --le signal reçu de la part du servo sender se trouve à l'état "haut" 
							DATA_to_pio_reg_in_2 <= std_logic_vector(to_unsigned((k/count),8)); --on stocke dans une 2nd variable/registre 
							--la valeur de la fréquence lue (que l'on reçoit de la part du servo sender)
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
		end if;
	end process;

end RTL;
