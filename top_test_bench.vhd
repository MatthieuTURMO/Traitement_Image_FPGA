--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:35:08 11/16/2015
-- Design Name:   
-- Module Name:   D:/VHDL MATTHIEU/Basc_D/top_test_bench.vhd
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_test_bench IS
END top_test_bench;
 
ARCHITECTURE behavior OF top_test_bench IS 
 
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
         P9 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal D_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal READY : std_logic := '0';

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
          P9 => P9
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
