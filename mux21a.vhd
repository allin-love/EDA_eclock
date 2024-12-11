LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux21a IS
	PORT ( a, b, s: IN  STD_LOGIC;
			y : OUT STD_LOGIC  );
END ENTITY mux21a;

ARCHITECTURE one OF mux21a IS
BEGIN
	PROCESS (a,b,s)
	BEGIN
		IF s = '0'  THEN  y <= a ; ELSE y <= b ;
		END IF;
	END PROCESS;
END ARCHITECTURE one ;
