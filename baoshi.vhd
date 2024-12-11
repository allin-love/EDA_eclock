LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity baoshi is
	port ( min0 ,min1 , sec0, sec1 :in std_logic_vector ( 3 downto 0 );
			speak: out std_logic );
end baoshi;

architecture cml of baoshi is
begin
	speak <= '1'	-- min1=5, min0=9, sec1=5  and  sec0=3, sec0=5, sec0=7, sec0=9
			when (min1="0101" and min0 ="1001" and sec1="0101")and ( sec0="0011" or sec0 ="0101" or sec0 ="0111" or sec0="1001") 
	else '0';
end cml;
