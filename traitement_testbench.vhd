--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:22:41 12/04/2015
-- Design Name:   
-- Module Name:   D:/VHDL MATTHIEU/Basc_D/traitement_testbench.vhd
-- Project Name:  Basc_D
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Traitement
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY traitement_testbench IS
END traitement_testbench;
 
ARCHITECTURE behavior OF traitement_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Traitement
    PORT(
         P1 : IN  std_logic_vector(7 downto 0);
         P2 : IN  std_logic_vector(7 downto 0);
         P3 : IN  std_logic_vector(7 downto 0);
         P4 : IN  std_logic_vector(7 downto 0);
         P5 : IN  std_logic_vector(7 downto 0);
         P6 : IN  std_logic_vector(7 downto 0);
         P7 : IN  std_logic_vector(7 downto 0);
         P8 : IN  std_logic_vector(7 downto 0);
         P9 : IN  std_logic_vector(7 downto 0);
         RESET : IN  std_logic;
         CLK : IN  std_logic;
         Result_Ready : IN  std_logic;
         Type_Traitement : IN  std_logic_vector(2 downto 0);
         Q : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal P1 : std_logic_vector(7 downto 0) := (others => '0');
   signal P2 : std_logic_vector(7 downto 0) := (others => '0');
   signal P3 : std_logic_vector(7 downto 0) := (others => '0');
   signal P4 : std_logic_vector(7 downto 0) := (others => '0');
   signal P5 : std_logic_vector(7 downto 0) := (others => '0');
   signal P6 : std_logic_vector(7 downto 0) := (others => '0');
   signal P7 : std_logic_vector(7 downto 0) := (others => '0');
   signal P8 : std_logic_vector(7 downto 0) := (others => '0');
   signal P9 : std_logic_vector(7 downto 0) := (others => '0');
   signal RESET : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Result_Ready : std_logic := '0';
   signal Type_Traitement : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal Q : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Traitement PORT MAP (
          P1 => P1,
          P2 => P2,
          P3 => P3,
          P4 => P4,
          P5 => P5,
          P6 => P6,
          P7 => P7,
          P8 => P8,
          P9 => P9,
          RESET => RESET,
          CLK => CLK,
          Result_Ready => Result_Ready,
          Type_Traitement => Type_Traitement,
          Q => Q
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
