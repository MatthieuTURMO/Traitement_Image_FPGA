----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:35:45 12/04/2015 
-- Design Name: 
-- Module Name:    Filtre - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Traitement is
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
end Traitement;

architecture Traitement_arch of Traitement is


component Basc_D_12b
Port(      RESET: in STD_LOGIC;
			  CLK : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (11 downto 0);
			  Q : out  STD_LOGIC_VECTOR (11 downto 0)
	 );
end component;

component Basc_D_14b
Port(      RESET: in STD_LOGIC;
			  CLK : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (13 downto 0);
			  Q : out  STD_LOGIC_VECTOR (13 downto 0)
	 );
end component;

	--coefficients multiplication
	signal C1: STD_LOGIC_VECTOR (2 downto 0);
	signal C2: STD_LOGIC_VECTOR (2 downto 0);
	signal C3: STD_LOGIC_VECTOR (2 downto 0);
	signal C4: STD_LOGIC_VECTOR (2 downto 0);
	signal C5: STD_LOGIC_VECTOR (2 downto 0);
	signal C6: STD_LOGIC_VECTOR (2 downto 0);
	signal C7: STD_LOGIC_VECTOR (2 downto 0);
	signal C8: STD_LOGIC_VECTOR (2 downto 0);
	signal C9: STD_LOGIC_VECTOR (2 downto 0);
	
	
	--signauxintermediaires
	signal A1: STD_LOGIC_VECTOR (11 downto 0);
	signal A2: STD_LOGIC_VECTOR (11 downto 0);
	signal A3: STD_LOGIC_VECTOR (11 downto 0);
	signal A4: STD_LOGIC_VECTOR (11 downto 0);
	signal A5: STD_LOGIC_VECTOR (11 downto 0);
	signal A6: STD_LOGIC_VECTOR (11 downto 0);
	signal A7: STD_LOGIC_VECTOR (11 downto 0);
	signal A8: STD_LOGIC_VECTOR (11 downto 0);
	signal A9: STD_LOGIC_VECTOR (11 downto 0);
	
	signal B1: STD_LOGIC_VECTOR (11 downto 0);
	signal B2: STD_LOGIC_VECTOR (11 downto 0);
	signal B3: STD_LOGIC_VECTOR (11 downto 0);
	signal B4: STD_LOGIC_VECTOR (11 downto 0);
	signal B5: STD_LOGIC_VECTOR (11 downto 0);
	signal B6: STD_LOGIC_VECTOR (11 downto 0);
	signal B7: STD_LOGIC_VECTOR (11 downto 0);
	signal B8: STD_LOGIC_VECTOR (11 downto 0);
	signal B9: STD_LOGIC_VECTOR (11 downto 0);
	
	signal D1: STD_LOGIC_VECTOR (12 downto 0);
	signal D2: STD_LOGIC_VECTOR (12 downto 0);
	signal D3: STD_LOGIC_VECTOR (11 downto 0);
	signal D4: STD_LOGIC_VECTOR (12 downto 0);
	signal D5: STD_LOGIC_VECTOR (12 downto 0);
	
	signal E1: STD_LOGIC_VECTOR (13 downto 0);
	signal E2: STD_LOGIC_VECTOR (11 downto 0);
	signal E3: STD_LOGIC_VECTOR (13 downto 0);
	
	signal F1: STD_LOGIC_VECTOR (14 downto 0);
	signal F2: STD_LOGIC_VECTOR (13 downto 0);
	
	signal G: STD_LOGIC_VECTOR (15 downto 0);
	
	signal valAbsG : STD_LOGIC_VECTOR (15 downto 0);
	
--etats
Constant ETAT1:std_logic_vector(2 downto 0) := "001";
Constant ETAT2:std_logic_vector(2 downto 0) := "010";
signal ETAT_ACTUEL:std_logic_vector(2 downto 0) := ETAT1;
	
--compteur
signal cpt: std_logic_vector(2 downto 0) := "000";
	
	
	

begin

	 
	--pipeline premeir etage de bascules
	basc1:Basc_D_12b port map(RESET,CLK,a1,b1);
	basc2:Basc_D_12b port map(RESET,CLK,a2,b2);
	basc3:Basc_D_12b port map(RESET,CLK,a3,b3);
	basc4:Basc_D_12b port map(RESET,CLK,a4,b4);
	basc5:Basc_D_12b port map(RESET,CLK,a5,b5);
	basc6:Basc_D_12b port map(RESET,CLK,a6,b6);
	basc7:Basc_D_12b port map(RESET,CLK,a7,b7);
	basc8:Basc_D_12b port map(RESET,CLK,a8,b8);
	basc9:Basc_D_12b port map(RESET,CLK,a9,b9);
	
	basc10:Basc_D_12b port map(RESET,CLK,b5,d3);--premier etage addition
	
	basc11:Basc_D_12b port map(RESET,CLK,d3,e2); --deuxieme etage addition
	
	basc12:Basc_D_14b port map(RESET,CLK,e3,f2);--troisieme etage addition
	
	


--definit le type a faire en fonction de l'entree type
coefficient : process(Type_Traitement)
begin

case Type_Traitement is
	when "000"=> --cas du flou
		C1<="001";
		C2<="001";
		C3<="001";
		C4<="001";
		C5<="000";
		C6<="001";
		C7<="001";
		C8<="001";
		C9<="001";
	
	when "001"=> --contour horizontaux
		C1<="111";
		C2<="110";
		C3<="111";
		C4<="000";
		C5<="000";
		C6<="000";
		C7<="001";
		C8<="010";
		C9<="001";
	
	when"010"=> --contour verticaux
		C1<="111";
		C2<="000";
		C3<="001";
		C4<="110";
		C5<="000";
		C6<="010";
		C7<="111";
		C8<="000";
		C9<="001";
	when others=>
		NULL;
	
	
end case;
end process;


--process qui fait les calculs
calcul: process(CLK,READY)
begin
	

if(CLK'event and CLK='1') then
	if(READY = '1') then	
	
	--apres multiplication
	a1 <= std_logic_vector(signed('0'&P1)*signed(C1));
	a2 <= std_logic_vector(signed('0'&P2)*signed(C2));
	a3 <= std_logic_vector(signed('0'&P3)*signed(C3));
	a4 <= std_logic_vector(signed('0'&P4)*signed(C4));
	a5 <= std_logic_vector(signed('0'&P5)*signed(C5));
	a6 <= std_logic_vector(signed('0'&P6)*signed(C6));
	a7 <= std_logic_vector(signed('0'&P7)*signed(C7));
	a8 <= std_logic_vector(signed('0'&P8)*signed(C8));
	a9 <= std_logic_vector(signed('0'&P9)*signed(C9));
	
	
	--apres addition d3 est definit dans les bascules
	d1 <= std_logic_vector(signed(b1(10)&b1)+signed(b2(10)&b2));
	d2 <= std_logic_vector(signed(b3(10)&b3)+signed(b4(10)&b4));
	d4 <= std_logic_vector(signed(b6(10)&b6)+signed(b7(10)&b7));
	d5 <= std_logic_vector(signed(b8(10)&b8)+signed(b9(10)&b9));
	
	
	--deuxieme etage d'addition, e2 definit dans les bascules
	e1 <= std_logic_vector(signed(d1(11)&d1)+signed(d2(11)&d2));
	e3 <= std_logic_vector(signed(d4(11)&d4)+signed(d5(11)&d5));

	--troisieme etage addition
	f1 <= std_logic_vector(signed(e1(12)&e1)+signed(e2(10)&e2(10)&e2));
	
	g <= std_logic_vector(signed(f1(13)&f1)+signed(f2(12)&f2(12)&f2));
	
	if(g(15) = '1') then--si g est negatif 
		valAbsG <= not(g) + 1;
	else
		valAbsG <= g;
	end if;
	--etage division
	
	
	
	
	end if;
end if;
	
	--premier etage d'addition


end process;

--pour les contours
Q <= valAbsG(11 downto 4);

--pour le flou
--Q <= g(12 downto 3);

--met le result ready 6 coups dhorloge apres que ready = 1
machine_etat:process(CLK)
begin
if (CLK'event and CLK='1') then
        if(RESET='1') then
                ETAT_ACTUEL <= ETAT1;
					 Result_ready <= '0';
        else
                CASE ETAT_ACTUEL is
                        when ETAT1=>
                                if (Ready='1') then 
                                        cpt<=cpt+1;
                                        if (cpt="110") then
                                                ETAT_ACTUEL<=ETAT2;
                                                cpt<="000";
                                        end if;
										  elsif(READY = '0') then
												cpt <= "000";
											end if;
                        when ETAT2=>
                                Result_ready <= '1';
                       	when OTHERS=>
										NULL;										
								end case;
							end if;
			end if;
end process;

end Traitement_arch;

