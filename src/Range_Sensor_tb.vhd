library ieee;
use ieee.std_logic_1164.all;

entity range_sensor_tb is
end range_sensor_tb;



architecture tb of range_sensor_tb is

signal led: std_logic_vector(3 downto 0);
signal clk: std_logic := '0';
signal rst,echo: std_logic;
signal trigger: std_logic;
signal an :  std_logic_vector ( 3 downto 0);
signal sseg :  std_logic_vector ( 7 downto 0);

component top_range_sensor is
port(
		led:out std_logic_vector(3 downto 0);
		clk,rst,echo:in std_logic;
		trigger:out std_logic;
		an : out std_logic_vector ( 3 downto 0);
		sseg : out std_logic_vector ( 7 downto 0)
	);
end component;


begin
clk<= not clk after 20ns;
toprange: top_range_sensor port map(led,clk,rst,echo,trigger,an,sseg);

process
begin
rst<='0';
wait for 40ns;
rst<='1';
wait;
end process;

process
begin
wait until trigger ='1';
wait for 20us;
echo<='1';
wait for 10us;
echo<='0';
wait;
end process;

end tb;