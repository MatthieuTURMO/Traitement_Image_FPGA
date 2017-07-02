----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:51:47 11/16/2015 
-- Design Name: 
-- Module Name:    top - top_arch 
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
use ieee.STD_LOGIC_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
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
end top;

architecture top_arch of top is

component Basc_D 
Port(      RST: in STD_LOGIC;
			  CLK : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (7 downto 0);
			  Q : out  STD_LOGIC_VECTOR (7 downto 0)
	 );
end component;

component Basc_D_1b
Port(      CLK : in  STD_LOGIC;
           D : in  STD_LOGIC;
			  Q : out  STD_LOGIC
	 );
end component;

component fifo_traitement
Port(     rst : IN STD_LOGIC;
			 wr_clk : IN STD_LOGIC;
			 rd_clk : IN STD_LOGIC;
			 din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			 wr_en : IN STD_LOGIC;
			 rd_en : IN STD_LOGIC;
			 prog_full_thresh : IN STD_LOGIC_VECTOR(9 DOWNTO 0) := "0001111100"; --124 par defaut
			 dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			 full : OUT STD_LOGIC;
			 empty : OUT STD_LOGIC;
			 prog_full : OUT STD_LOGIC
	 );			  
end component;

--signaux intermédiaires internes au systèmes.
signal i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11 : std_logic_vector(7 downto 0) := (others =>'0');
signal i12,i13,wr_en2 : std_logic; -- signal pour wr_en de la fifo 2
signal irdy1,irdy2 : std_logic; --etage pour entree READY
signal rdy1,rdy2: std_logic; --etage pour le reasult_rdy (sortie)
signal rst,wr_en,full,empty,prog_full, full2, empty2, prog_full2 : std_logic;
signal prog_full_thresh : std_logic_vector(9 downto 0) :="0001111100";
signal cpt: std_logic_vector(2 downto 0) := "000";

--etats
Constant ETAT1:std_logic_vector(2 downto 0) := "001";
Constant ETAT2:std_logic_vector(2 downto 0) := "010";
Constant ETAT3:std_logic_vector(2 downto 0) := "011";
Constant ETAT4:std_logic_vector(2 downto 0) := "100";
signal ETAT_ACTUEL:std_logic_vector(2 downto 0) := ETAT1;



begin

----signal ready decale de 3 pour par qu'il y a ait de valeur pour le ready
--Drdy1: Basc_D_1b port map(CLK, READY,irdy1);
--Drdy2: Basc_D_1b port map(CLK, irdy1, irdy2);
--Drdy3: Basc_D_1b port map(CLK, irdy2, wr_en);

--premier etage
D1: Basc_D port map(RESET,CLK, D_IN, i1);
D2: Basc_D port map(RESET,CLK, i1, i2);
D3: Basc_D port map(RESET,CLK, i2, i3);
FIFO1 : fifo_traitement port map(rst, CLK, CLK, i3, wr_en, prog_full, prog_full_thresh, i4, full, empty, prog_full);

----apres cet étage il faut 3 bascules en sortie du rd_en connecté au wr_en2, car il faut attendre 3 coup avant que
----la deuxieme fifo commence a ecrire
--D10: Basc_D_1b port map(CLK, prog_full,i12);
--D11: Basc_D_1b port map(CLK, i12, i13);
--D12: Basc_D_1b port map(CLK, i13, i14); --i14 correspond a wr_en de la deuxieme fifo



--i14 c'est le wr_en2
--second etage
D4: Basc_D port map(RESET,CLK, i4, i5);
D5: Basc_D port map(RESET,CLK, i5, i6);
D6: Basc_D port map(RESET,CLK, i6, i7);
FIFO2 : fifo_traitement port map(rst, CLK, CLK, i7, wr_en2, prog_full2, prog_full_thresh, i8, full2, empty2, prog_full2);

--troisieme etage
D7: Basc_D port map(RESET,CLK, i8, i9);
D8: Basc_D port map(RESET,CLK, i9, i10);
D9: Basc_D port map(RESET,CLK, i10, i11);
--
----etage pour le result_ready
--Dresult_rdy1: Basc_D_1b port map(CLK, prog_full2,rdy1);
--Dresult_rdy2: Basc_D_1b port map(CLK, rdy1, rdy2);
--Dresult_rdy3: Basc_D_1b port map(CLK, rdy2, Result_ready); 



P9 <= i1;
P8 <= i2;
P7 <= i3;

P6 <= i5;
P5 <= i6;
P4 <= i7;

P3 <= i9;
P2 <= i10;
P1 <= i11;


rst <= RESET;

--machine a etat qui remplace les 3 etages de 3 bascules mis en place.
machine_etat:process(CLK)
begin
if (CLK'event and CLK='1') then
        if(RESET='1') then
                ETAT_ACTUEL <= ETAT1;
					 wr_en <= '0';
					 wr_en2 <= '0';
					 Result_ready <= '0';
        else
                CASE ETAT_ACTUEL is
                        when ETAT1=>
                                if (Ready='1') then 
                                        cpt<=cpt+1;
                                        if (cpt="011") then
                                                ETAT_ACTUEL<=ETAT2;
                                                wr_en<='1';
                                                cpt<="000";
                                        end if;
                                end if;
                        when ETAT2=>
                                if(prog_full='1') then
                                        cpt<=cpt+1;
                                        if (cpt="011") then
                                                ETAT_ACTUEL<=ETAT3;
                                                wr_en2<='1';
                                                cpt<="000";
                                        end if;
                                end if;
                        when ETAT3=>
                                if (prog_full2='1') then
                                        cpt<=cpt+1;
                                        if(cpt="011") then
                                                ETAT_ACTUEL<=ETAT4;                                                
                                                cpt<="000";
                                        end if;
                                end if;
										  
								when ETAT4=>
										Result_ready<='1';
								when OTHERS=>
										NULL;
										
								end case;
							end if;
			end if;
end process;

end top_arch;
