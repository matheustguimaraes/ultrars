library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Counter is
	generic(
		n: POSITIVE := 10
	);
	port(
		-- Clock
		clk: in std_logic;
		-- Comeca a contagem apenas quando "enable" esta ativo
		enable: in std_logic;
		-- Ativo em nivel baixo, devido a configuracao da placa FPGA
		reset: in std_logic;
		-- Saida do resultado da contagem 
		count_out: out std_logic_vector(n - 1 downto 0) 
	);
end Counter;

architecture Behavioral of Counter is
signal count: std_logic_vector(n - 1 downto 0);
begin
	process(clk, reset, enable)
	begin
		-- Determina os valores iniciais da contagem
		if (reset = '0') then
			count <= (others => '0');
		-- Ativa a contagem quando o clock estiver ativo E se enable estiver ativo
		elsif(clk'event and clk= '1') then
			if (enable = '1') then
				count <= count + 1;
			end if;
		end if;
	end process;	
	count_out <= count;	
end Behavioral;
