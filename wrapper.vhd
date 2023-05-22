-- wrapper

-- architectures:
-- RTL_test: example testing HPS inout register used as control signals
-- structure_driver_out_example_3: example using a driver output to generate variable width pulses
-- structure_driver_in_example_3: example using a driver input to read the width of an input pulse
-- structure_driver_example_3: example using both drivers in/out 

-- configuration:
-- use the configuration at the end of the file to select the architecture to implement.
-- Just change the architecture name.

library ieee;
use ieee.std_logic_1164.all;

entity wrapper is
	port (		
		CLK					: in std_logic;
		RST					: in std_logic;
		LED					: out std_logic_vector(7 downto 0);
		--SW					: in std_logic_vector(3 downto 0);
		--KEY					: in std_logic_vector(1 downto 0);
		from_GPIO_0_1_in	: in std_logic; -- peripheral input (RX)
		--from_GPIO_0_0_inout	: in std_logic;	-- bidirectional peripheral input (S2C data)
		--to_GPIO_0_0_inout	: out std_logic; -- bidirectional peripheral output (S2C data) 
		--to_gpio_1_0_out		: out std_logic; -- peripheral output (TX)
		--from_pio_reg_out	: in std_logic_vector(7 downto 0);
		--from_pio_reg_inout	: in std_logic_vector(7 downto 0);
		to_pio_reg_in		: out std_logic_vector(7 downto 0);
		to_pio_reg_inout	: out std_logic_vector(7 downto 0) 
	);
end wrapper;

architecture structure_ServoIn of wrapper is


	component ServoIn is
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
			DATA_to_pio_reg_in_1		: out std_logic_vector(7 downto 0);
			DATA_to_pio_reg_in_2		: out std_logic_vector(7 downto 0)
			
			
			
		);
	end component;

	for I_Driver_In: ServoIn use entity work.ServoIn(RTL);
	

begin	
	--instantiate the driver_in module
	
	
	I_Driver_In: ServoIn	
		port map (	
			CLK							=> CLK,
			RST							=> RST,
			LED_BUSY						=> LED(0),
			LED_DRDY						=> LED(1),
			PULSE_from_GPIO_0_1_in	=> from_GPIO_0_1_in,
			DATA_to_pio_reg_in_1		=> to_pio_reg_in,
			DATA_to_pio_reg_in_2		=> to_pio_reg_inout
			
		);	
end structure_ServoIn;
