----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:35:45 12/08/2015 
-- Design Name: 
-- Module Name:    Basc_D_11b - Basc_D_11b 
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

entity Basc_D_11b is
 Port ( 	  RESET : in STD_LOGIC;
			  Q : out  STD_LOGIC_VECTOR (10 downto 0);
           CLK : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (10 downto 0)
			  );
end Basc_D_11b;

architecture Basc_D_11b_arch of Basc_D_11b is

begin

process(CLK)
begin

		if(CLK'event and CLK='1') then
			if(RESET = '0') then
					Q<=D;
			elsif(RESET = '1') then
					Q <= (others => '0');
			end if;
		end if;


end process;

end Basc_D_11b_arch;

