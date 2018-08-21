library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_counter is
end entity;

architecture behavior of tb_counter is

  signal clock, enb, rst : std_logic;
  signal count_t : std_logic_vector(32 downto 0);

begin

  uut: entity work.counter port map( clk => clock, reset => rst, enable => enb,
					count_out => count_t);

  estimular: process
    begin
      clock <= '0';
      wait for 100000 ns;
      clock <= '1';
      wait for 100000 ns;
  end process;

  resetar: process
    begin
      rst <= '1';
      wait for 20 ns;
      rst <= '0';
      wait;
  end process;

  enable: process
    begin
      enb <= '1';
      wait for 50 ns;
  end process;  

end behavior;

