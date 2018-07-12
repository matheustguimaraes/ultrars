library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Distance_calculator is
	port(
		-- Clock
		clk: in std_logic; 
		-- Reset sera ativo em nivel baixo
		Calculation_Reset: in std_logic; 
		-- Entrada do pulso do Trigger
		pulse :in std_logic; 
		-- Saida do calculo da distancia
		Distance: out std_logic_vector(8 downto 0) 
	);
end Distance_calculator;

architecture Behavioral of Distance_calculator is
-- Instanciar componente Counter
component Counter is
	generic(
		n: POSITIVE := 10
	);
	port(
		clk: in std_logic;
		enable: in std_logic;
		reset: in std_logic;
		count_out: out std_logic_vector(n-1 downto 0)
	);
end component;

-- Sinal de saida do Pulse
signal Pulse_width : STD_LOGIC_VECTOR(21 downto 0);
begin
	Counter_pulse : Counter generic map(22) port map(clk, pulse, not Calculation_reset, Pulse_width);
	Distance_calculator : process(pulse)
		-- Utiliza o metodo shift and subtract para dividir Pulse por 58, o que transforma
		-- numeros de nanosegundos para segundos, segundo o Data Sheet do sensor
		variable Result : integer; -- Valor inteiro de base 10
		 -- Vetor temporario para ser multiplicado
		variable Multiplier : STD_LOGIC_VECTOR(23 downto 0);
		begin
			if(pulse = '0') then
				-- Multiplica o vetor por 3
				Multiplier := Pulse_width * "11";
				-- Multiplica os bits mais significativos por 3, e coloca-os em Result
				Result := to_integer(unsigned(Multiplier(23 downto 13)));
				-- Se Result atingir o valor maximo, Distance sera "111111111" 
				if(Result > 458) then
					Distance <= "111111111";
				-- Se nao, Distance sera o valor de Result colocado em um vetor de 9 posicoes
				else
					Distance <= STD_LOGIC_VECTOR(to_unsigned(Result,9));
				end if;
			end if;
		end process;
end architecture;
