library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_trigger_generator is
end entity;

architecture behavior of tb_trigger_generator is
  signal clock, trigger_out : std_logic;

begin

  uut: entity work.trigger_generator port map( 	clk => clock,
						trigger => trigger_out);

  estimular: process
    begin
      clock <= '0';
      wait for 15 ns;
      clock <= '1';
      wait for 15 ns;
  end process; 

end architecture;

