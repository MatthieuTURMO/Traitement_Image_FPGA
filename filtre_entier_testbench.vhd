--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:59:47 12/07/2015
-- Design Name:   
-- Module Name:   D:/VHDL MATTHIEU/Basc_D/filtre_entier_testbench.vhd
-- Project Name:  Basc_D
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Filtre_entier
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY filtre_entier_testbench IS
END filtre_entier_testbench;
 
ARCHITECTURE behavior OF filtre_entier_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Filtre_entier
    PORT(
         D_IN : IN  std_logic_vector(7 downto 0);
         RESET : IN  std_logic := '1';
         CLK : IN  std_logic;
         READY : IN  std_logic := '0';
         D_OUT : OUT  std_logic_vector(7 downto 0);
         Result_ready : OUT  std_logic := '0';
         TYPE_TRAITEMENT : IN  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal D_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal RESET : std_logic := '0';
   signal CLK : std_logic := '0';
   signal READY : std_logic := '0';
   signal TYPE_TRAITEMENT : std_logic_vector(2 downto 0) := (others => '0');
	
	--temporaire
	signal CLK_EN : STD_LOGIC;
	
	--compteurs lecture / ecriture
	signal cpt_lect : std_logic_vector (14 downto 0) := "000000000000000";
	signal cpt_ecrit : std_logic_vector (14 downto 0) := "000000000000000";

 	--Outputs
   signal D_OUT : std_logic_vector(7 downto 0);
   signal Result_ready : std_logic := '0';

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
	
	--temporaire
	FILE vectors : text;
   file results : text;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Filtre_entier PORT MAP (
          D_IN => D_IN,
          RESET => RESET,
          CLK => CLK,
          READY => READY,
          D_OUT => D_OUT,
          Result_ready => Result_ready,
          TYPE_TRAITEMENT => TYPE_TRAITEMENT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= CLK_EN;
		wait for CLK_period/2;
   end process;
 

--   -- Stimulus process
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for CLK_period*10;
--
--      -- insert stimulus here 
--
--      wait;
--   end process;
--	
	
	
	        --Process pour écrire et lire dans le fichier dat
Lect : process
                
                variable Iline: line;
					variable I1_var, I2_var :std_logic_vector (7 downto 0);
                
                
					 
                begin
					 TYPE_TRAITEMENT <= "010";
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
                
                --while not endfile(vectors) loop
					 while (cpt_lect /= "100000000000000") loop
					 -- if (cpt_lect /= "100000000000000") then
                        readline (vectors,Iline); --lecture d'une ligne 
                        read (Iline,I1_var);
                        READY <= '1';
                        D_in <= I1_var;
								cpt_lect <= cpt_lect +1;
								wait for CLK_period;                      
               end loop;
					
                READY <= '0';					

                file_close (vectors);        
					
               wait;        
                                
end process Lect;


ecriture : process
                
                variable OLine : line;
           variable O1_var : std_logic_vector (7 downto 0);
                
                
                begin

                file_open (results,"lena_modif.dat",write_mode); --écriture du nouveau fichier

                wait until (rising_edge(clk));
              --  wait for 2 ns;
                --cpt_ecrit <= cpt_ecrit + 1;
               -- wait until (Result_ready='0');
                
                wait until (Result_ready='1');
                           
               -- while (Result_ready='1') loop	
					while (cpt_ecrit /= "100000000000000") loop
								cpt_ecrit <= cpt_ecrit + 1;
                        write (Oline, D_OUT, right, 2);		
								writeline (results, Oline);	
                        wait for CLK_period;
								
                end loop;
        
					
					
                file_close (results);
					 

                wait;        
end process ecriture;

END;
