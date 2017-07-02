--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:54:34 11/27/2015
-- Design Name:   
-- Module Name:   D:/VHDL MATTHIEU/Basc_D/lena_textbench.vhd
-- Project Name:  Basc_D
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;
--use ieee.std_logic_unsigned.all;
use ieee.STD_LOGIC_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY lena_textbench IS
END lena_textbench;

 
ARCHITECTURE behavior OF lena_textbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         D_IN : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         READY : IN  std_logic;
         P1 : OUT  std_logic_vector(7 downto 0);
         P2 : OUT  std_logic_vector(7 downto 0);
         P3 : OUT  std_logic_vector(7 downto 0);
         P4 : OUT  std_logic_vector(7 downto 0);
         P5 : OUT  std_logic_vector(7 downto 0);
         P6 : OUT  std_logic_vector(7 downto 0);
         P7 : OUT  std_logic_vector(7 downto 0);
         P8 : OUT  std_logic_vector(7 downto 0);
         P9 : OUT  std_logic_vector(7 downto 0);
			Result_ready : out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK, CLK_EN : std_logic := '0';
   signal RESET : std_logic := '1';
   signal READY : std_logic := '1';

 	--Outputs
   signal P1 : std_logic_vector(7 downto 0);
   signal P2 : std_logic_vector(7 downto 0);
   signal P3 : std_logic_vector(7 downto 0);
   signal P4 : std_logic_vector(7 downto 0);
   signal P5 : std_logic_vector(7 downto 0);
   signal P6 : std_logic_vector(7 downto 0);
   signal P7 : std_logic_vector(7 downto 0);
   signal P8 : std_logic_vector(7 downto 0);
   signal P9 : std_logic_vector(7 downto 0);
	signal Result_ready : std_logic;
	
	--temporaire
	FILE vectors : text;
   file results : text;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          D_IN => D_IN,
          CLK => CLK,
          RESET => RESET,
          READY => READY,
          P1 => P1,
          P2 => P2,
          P3 => P3,
          P4 => P4,
          P5 => P5,
          P6 => P6,
          P7 => P7,
          P8 => P8,
          P9 => P9,
			 Result_ready => Result_ready
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= CLK_EN;
		wait for CLK_period/2;
   end process;
 

 
        --Process pour écrire et lire dans le fichier dat
Lect : process
                
                variable Iline: line;
					variable I1_var, I2_var :std_logic_vector (7 downto 0);
                
                
                begin
                READY <= '0';

                file_open (vectors,"Lena128x128g_8bits.dat",read_mode); --ouverture du fichier

                CLK_EN <= '0';
                wait for 40 ns;
                CLK_EN <= '1';	
                wait for 40 ns;
                wait for 100 ns;
                RESET<='0';
                wait for 100 ns;
                wait until (rising_edge(clk));
                wait for 2 ns;
                
                while not endfile(vectors) loop
                        readline (vectors,Iline); --lecture d'une ligne 
                        read (Iline,I1_var);
                        READY <= '1';
                        D_in <= I1_var;
								wait for CLK_period;
                        
                end loop;
                READY <= '0';

                file_close (vectors);        

               -- wait;        
                                
end process Lect;


ecriture : process
                
                variable OLine : line;
           variable O1_var : std_logic_vector (7 downto 0);
                
                
                begin

                file_open (results,"lena_modif.dat",write_mode); --écriture du nouveau fichier

                wait until (rising_edge(clk));
              --  wait for 2 ns;
                
               -- wait until (Result_ready='0');
                
                wait until (Result_ready='1');
                           
                while (Result_ready='1') loop
                        write (Oline, P1, right, 2);
                        writeline (results, Oline);								
                        wait for CLK_period;
                end loop;
        
                file_close (results);

                wait;        
end process ecriture;

END;


