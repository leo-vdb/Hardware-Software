library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.all;

entity ServoIn_TB is
end ServoIn_TB;

architecture behavior  of ServoIn_TB is

	constant PERIOD : time := 20 ns;

	component ServoIn
		port (
			CLK							: in std_logic;
			RST							: in std_logic;
			LED_BUSY					: out std_logic; -- busy
			--LED_DRDY					: out std_logic; -- data ready 
			PULSE_from_GPIO_0_1_in		: in std_logic; -- peripheral input (RX)
			DATA_to_pio_reg_in_1			: out std_logic_vector(7 downto 0);
			DATA_to_pio_reg_in_2			: out std_logic_vector(7 downto 0);
			--ENABLE_IN		: in std_logic
		);
	end component;

	for DUT: ServoIn use entity work.ServoIn(RTL);
	
	signal sCLK	  : std_logic := '0';
	signal sRST	  : std_logic := '0';
	signal sPULSE_from_GPIO_0_1_in : std_logic;
	signal sDATA_to_pio_reg_in_1 : std_logic_vector(7 downto 0):= "00000000";
	signal sDATA_to_pio_reg_in_2 : std_logic_vector(7 downto 0);
	signal sENABLE_IN : std_logic:= '0'; 
	signal sLED_BUSY : std_logic := '0';
begin

	DUT: ServoIn
		port map (
			RST 	=> sRST,
			CLK 	=> sCLK,
			PULSE_from_GPIO_0_1_in		=> sPULSE_from_GPIO_0_1_in,
			DATA_to_pio_reg_in_1 => sDATA_to_pio_reg_in_1,
			DATA_to_pio_reg_in_2 => sDATA_to_pio_reg_in_2,
			ENABLE_IN => sENABLE_IN, 
			LED_BUSY => sLED_BUSY
		);
		
		
		
	P_sCLK: process
	begin -- 50MHz clock
		sCLK <= not sCLK;
		wait for PERIOD/2;
		sCLK <= '1';
		
	end process;

	
	
	P_sRST: process
	begin -- generate active 1 reset
		sRST <= '0';
		wait for PERIOD;
		sRST <= '1';
		wait;
	end process;

	
	stimulus: process
	begin
		sPULSE_from_GPIO_0_1_in <= '0';
		if sRST = '0' then
			wait until sRST = '1';
		end if;
		
		for i in 0 to 2 loop
			--sENABLE_IN <= '1';
			sPULSE_from_GPIO_0_1_in <= '1';
			wait for 1 ms; 
			--sENABLE_IN <= '0';
			sPULSE_from_GPIO_0_1_in <= '0';
			wait for 20 ms - 1 ms;
		end loop;
		
		for i in 0 to 2 loop
			--sENABLE_IN <= '1';
			sPULSE_from_GPIO_0_1_in <= '1';
			wait for 2 ms; 
			--sENABLE_IN <= '0';
			sPULSE_from_GPIO_0_1_in <= '0';
			wait for 20 ms - 2 ms;
		end loop;
		
		for i in 0 to 2 loop	
			--sENABLE_IN <= '1';
			sPULSE_from_GPIO_0_1_in <= '1';
			wait for (1 ms + (1 ms / sDATA_to_pio_reg_in_1));
			--sENABLE_IN <= '0';
			sPULSE_from_GPIO_0_1_in <= '0';
			wait for 20 ms - 1 ms + 1 ms / 255;
		end loop;
--		Contrôle de sLED_BUSY en fonction de sPULSE_from_GPIO_0_1_in
    if sPULSE_from_GPIO_0_1_in = '1' and (1 ms - 1 ms / 255) <= 1 ms and 1 ms <= (2 ms + 1 ms / 255) then
      sLED_BUSY <= '1';
    else
      sLED_BUSY <= '0';
    end if;
		
	end process;
	
end behavior ;