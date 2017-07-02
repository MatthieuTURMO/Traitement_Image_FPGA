----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:57:08 11/23/2015 
-- Design Name: 
-- Module Name:    Filtre_2D - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_acces_lena is
end test_acces_lena;

architecture test_acces_lena_arch of test_acces_lena is
signal CLK, CLK_EN : std_logic := '0';
signal I1, O1 : std_logic_vector( 7 downto 0);
constant CLK_period : time := 10 ns;

begin

CLK_process :process
begin
	CLK <= '0';
	wait for CLK_period/2;
	CLK <= CLK_EN;
	wait for CLK_period/2;
end process;

p1 : process

  FILE vectors : text;
  file results : text;
  variable Iline, OLine : line;
  variable I1_var, I2_var :std_logic_vector (7 downto 0);
  variable O1_var : std_logic_vector (7 downto 0);
begin

file_open (vectors,"Lena128x128g_8bits.dat",read_mode); --ouverture du fichier
file_open (results,"lena_modif.dat",write_mode); --écriture du nouveau fichier

CLK_EN <= '0';
wait for 40 ns;
CLK_EN <= '1';
wait for 40 ns;

wait until rising_edge(clk);
wait for 2 ns;

while not endfile(vectors) loop
	readline (vectors,Iline); --lecture d'une ligne 
	read (Iline,I1_var);
	I1 <= I1_var;
	O1 <= I1;
	wait for CLK_period;	
	write (Oline, O1, right, 2);
	writeline (results, Oline);
end loop;

file_close (vectors);	
file_close (results);

wait;	
		
end process p1;

end test_acces_lena_arch;



