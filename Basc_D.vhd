----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:53:54 11/16/2015 
-- Design Name: 
-- Module Name:    Basc_D - Basc_D_arch 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Basc_D is
    Port ( RST : in STD_LOGIC;
			  Q : out  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (7 downto 0)
			  );
end Basc_D;

architecture Basc_D_arch of Basc_D is

begin

process(CLK)
begin

		if(CLK'event and CLK='1') then
			if(RST = '0') then
					Q<=D;
			elsif(RST = '1') then
					Q <= "00000000";
			end if;
		end if;


end process;


end Basc_D_arch;

