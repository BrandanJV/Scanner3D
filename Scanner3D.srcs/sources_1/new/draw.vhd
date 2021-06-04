----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 18:54:38
-- Design Name: 
-- Module Name: draw - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use ieee.Numeric_Std.all;

entity draw is
    Port(clk, reset : in std_logic;
        image: in std_logic_vector(11 downto 0);
        VS, HS: out std_logic;
        red, green, blue: out std_logic_vector(3 downto 0));
end draw;

architecture Behavioral of draw is

    component VGA_Driver is
        Port(clk, reset : in std_logic;
            HS, VS, video_on: out std_logic;
            column, row: out std_logic_vector(9 downto 0));
    end component;
    
signal column, row: integer:= 0;
signal enable: std_logic;
signal col, r: std_logic_vector(9 downto 0);

begin

column <=  to_integer(unsigned(col));
row <= to_integer(unsigned(r));

process(enable, column, row, image)
begin
    if(enable = '1') then
       if(image > "011111111111") then
           blue <= (OTHERS => '0');
           red <= (OTHERS => '1');
           green <= (OTHERS => '0');
       elsif(image <= "011111111111" AND image > "001111111111") then
           blue <= (OTHERS => '0');
           red <= (OTHERS => '1');
           green <= (OTHERS => '1');
       else
           blue <= (OTHERS => '0');
           red <= (OTHERS => '0');
           green <= (OTHERS => '1'); 
       end if;
    else
           blue <= (OTHERS => '0');
           red <= (OTHERS => '0');
           green <= (OTHERS => '0');
    end if;
end process;    

driver: VGA_driver port map(clk => clk, reset => reset, hs => hs, vs => vs, video_on => enable, column => col, row => r);
end Behavioral;
