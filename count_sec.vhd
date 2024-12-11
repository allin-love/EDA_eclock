LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- 秒计时器

entity count_sec is
	port(
		clk, rst, en: in std_logic;				
		q0, q1: buffer std_logic_vector(3 downto 0); 
		cout: out std_logic
	);
end count_sec;

architecture a of count_sec is
	signal m_clk: std_logic;
	signal num0, num1: std_logic_vector(3 downto 0);
begin
	process (rst, clk)
	begin
		m_clk <= clk;
		if (rst = '0') then
			num0 <= "0000";
			num1 <= "0000";
		elsif (m_clk'event and m_clk = '0') then
			if (en = '1') then
				if (num0 = "1001") then
					num0 <= "0000";
					if (num1 = "0101") then
						num1 <= "0000";
					else
						num1 <= num1 + 1;
					end if;
				else
					num0 <= num0 + 1;
				end if;
			end if;
		end if;
	end process;
	cout <= '1' when (num0 = "1001" and num1 = "0101" and en = '1') else '0';
	q0 <= num0;
	q1 <= num1;
end a;
