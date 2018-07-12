library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Range_sensor is
	port(
		-- Clock da placa, pulso de entrada
		fpgaclk, pulse : in std_logic; 
		-- Saida do Trigger
		trigger_out : out std_logic; 
		-- Conversao da distancia em unidades de medida de base 10
		meters, centimeters, decimeters : out std_logic_vector(3 downto 0)
	);
end Range_sensor;

architecture Behavioral of Range_sensor is 
component trigger_generator is 
	port(
		clk: in std_logic;
		trigger: out std_logic
	);
end component; 
	
component Distance_calculator is
	port(
		clk: in std_logic;
		Calculation_Reset: in std_logic;
		pulse :in std_logic;
		Distance: out std_logic_vector(8 downto 0)
	);
end component;
	
component BCD_converter is
  port(
	Distance : in std_logic_vector(8 downto 0);
	hundreds, tens, unit: out std_logic_vector(3 downto 0)
  );
end component;

	-- Sinal de saida do calculo da distancia para medida em metros 
	signal distance_out: std_logic_vector(8 downto 0);
	-- Sinal de saida do Trigger
	signal trigg_out: std_logic;
	
begin
	trigger_out <= trigg_out;

	trig: trigger_generator port map(fpgaclk,	trigg_out);
	dist: Distance_calculator port map(fpgaclk, 	trigg_out, 	pulse, 		distance_out);
	BCD_conv: BCD_converter port map(distance_out, 	meters, 	centimeters,	 decimeters);
end Behavioral;