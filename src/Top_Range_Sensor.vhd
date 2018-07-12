library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Top_Range_Sensor is 
	port(
		-- Pino para pulso de entrada
		pulse_pin: in std_logic;
		-- Pino para saida do Trigger
		trigger_pin: out std_logic;
		-- Pino do Clock FPGA
		clock: in std_logic;
		an: out std_logic_vector(2 downto 0);
		sseg: out std_logic_vector (7 downto 0)
 	);
end entity;

architecture Arch of Top_Range_Sensor is
component Range_sensor is
	port(
		fpgaclk, pulse: in std_logic;
		trigger_out: out std_logic;
		meters, centimeters, decimeters: out std_logic_vector(3 downto 0)
	);
end component;

component display_ctr is port
(
  clk: in std_logic;
  in2, in1, in0: in std_logic_vector(3 downto 0);
  an: out std_logic_vector(2 downto 0);
  sseg: out std_logic_vector (7 downto 0)
);
end component;

-- Sinais para unidades de medidas
signal Ai: std_logic_vector(3 downto 0);
signal Bi: std_logic_vector(3 downto 0);
signal Ci: std_logic_vector(3 downto 0);
begin
	range_sens : Range_sensor port map (clock, pulse_pin, trigger_pin, Ai, Bi, Ci);
	display: display_ctr port map(clock,	 Ai, 	Bi,	 Ci,	 an, 	sseg);
end Arch;