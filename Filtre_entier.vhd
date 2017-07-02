----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:54:18 12/04/2015 
-- Design Name: 
-- Module Name:    Filtre_entier - Filtre_entier_arch 
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
use std.textio.all;
use ieee.std_logic_textio.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Filtre_entier is
    Port ( D_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           RESET : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           READY : in  STD_LOGIC;
           D_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
			  Result_ready : out STD_LOGIC;
           TYPE_TRAITEMENT : in  STD_LOGIC_VECTOR (2 downto 0));
end Filtre_entier;

architecture Filtre_entier_arch of Filtre_entier is

component Basc_D_1b is
    Port ( RESET : in STD_LOGIC;
           CLK : in  STD_LOGIC;
			  D : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end component;


component Traitement is
   Port ( P1 : in  STD_LOGIC_VECTOR (7 downto 0);
           P2 : in  STD_LOGIC_VECTOR (7 downto 0);
           P3 : in  STD_LOGIC_VECTOR (7 downto 0);
           P4 : in  STD_LOGIC_VECTOR (7 downto 0);
           P5 : in  STD_LOGIC_VECTOR (7 downto 0);
           P6 : in  STD_LOGIC_VECTOR (7 downto 0);
           P7 : in  STD_LOGIC_VECTOR (7 downto 0);
           P8 : in  STD_LOGIC_VECTOR (7 downto 0);
           P9 : in  STD_LOGIC_VECTOR (7 downto 0);
			  RESET : in STD_LOGIC;
			  CLK : in STD_LOGIC;
			  READY : in STD_LOGIC;
			  Result_Ready : out STD_LOGIC;
			  Type_Traitement : in STD_LOGIC_VECTOR (2 downto 0); --definit le type de traitement (flou, etc)
           Q : out  STD_LOGIC_VECTOR (7 downto 0));
end component;


component top is
    Port ( D_IN : in  STD_LOGIC_VECTOR (7 downto 0);         
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC := '1';
           READY : in  STD_LOGIC := '0';
			  P1 : out  STD_LOGIC_VECTOR (7 downto 0);
           P2 : out  STD_LOGIC_VECTOR (7 downto 0);
           P3 : out  STD_LOGIC_VECTOR (7 downto 0);
           P4 : out  STD_LOGIC_VECTOR (7 downto 0);
           P5 : out  STD_LOGIC_VECTOR (7 downto 0);
           P6 : out  STD_LOGIC_VECTOR (7 downto 0);
           P7 : out  STD_LOGIC_VECTOR (7 downto 0);
           P8 : out  STD_LOGIC_VECTOR (7 downto 0);
           P9 : out  STD_LOGIC_VECTOR (7 downto 0);
			  Result_ready : out std_logic 
			  );
end component;

component Basc_D 
Port(      RST: in STD_LOGIC;
			  CLK : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (7 downto 0);
			  Q : out  STD_LOGIC_VECTOR (7 downto 0)
	 );
end component;

--relier les composants et c'est fini !!!
--mettre bascules d entre pour 

	--signaux intermediaires pour chaque P
	signal A1: STD_LOGIC_VECTOR (7 downto 0);
	signal A2: STD_LOGIC_VECTOR (7 downto 0);
	signal A3: STD_LOGIC_VECTOR (7 downto 0);
	signal A4: STD_LOGIC_VECTOR (7 downto 0);
	signal A5: STD_LOGIC_VECTOR (7 downto 0);
	signal A6: STD_LOGIC_VECTOR (7 downto 0);
	signal A7: STD_LOGIC_VECTOR (7 downto 0);
	signal A8: STD_LOGIC_VECTOR (7 downto 0);
	signal A9: STD_LOGIC_VECTOR (7 downto 0);
	
	--signal avant et apres bascule pip
	signal rdy1: STD_LOGIC;
	signal rdy2: STD_LOGIC;
	
		--signaux intermediaires pour chaque P
	signal B1: STD_LOGIC_VECTOR (7 downto 0);
	signal B2: STD_LOGIC_VECTOR (7 downto 0);
	signal B3: STD_LOGIC_VECTOR (7 downto 0);
	signal B4: STD_LOGIC_VECTOR (7 downto 0);
	signal B5: STD_LOGIC_VECTOR (7 downto 0);
	signal B6: STD_LOGIC_VECTOR (7 downto 0);
	signal B7: STD_LOGIC_VECTOR (7 downto 0);
	signal B8: STD_LOGIC_VECTOR (7 downto 0);
	signal B9: STD_LOGIC_VECTOR (7 downto 0);
	
	


begin
--ligne a retard
top1:top port map(D_IN,CLK,RESET,READY,A1,A2,A3,A4,A5,A6,A7,A8,A9,rdy1);

--bascule entre les P1 et P1 entrées sorties
basc1:Basc_D port map(RESET,CLK,a1,b1);
basc2:Basc_D port map(RESET,CLK,a2,b2);
basc3:Basc_D port map(RESET,CLK,a3,b3);
basc4:Basc_D port map(RESET,CLK,a4,b4);
basc5:Basc_D port map(RESET,CLK,a5,b5);
basc6:Basc_D port map(RESET,CLK,a6,b6);
basc7:Basc_D port map(RESET,CLK,a7,b7);
basc8:Basc_D port map(RESET,CLK,a8,b8);
basc9:Basc_D port map(RESET,CLK,a9,b9);

--basule D 1 bit pour result ready de top relié à ready de traitement
basc10:Basc_D_1b port map(RESET,CLK,rdy1,rdy2);

--traitement
traitement1:Traitement port map(B1,B2,B3,B4,B5,B6,B7,B8,B9,RESET,CLK,rdy2,RESULT_READY,TYPE_TRAITEMENT,D_OUT);



end Filtre_entier_arch;

