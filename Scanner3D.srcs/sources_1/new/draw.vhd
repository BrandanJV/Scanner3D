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

entity draw is
    Port(clk, reset : in std_logic;
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


driver: VGA_driver port map(clk => clk, reset => reset, hs => hs, vs => vs, video_on => enable, column => col, row => r);
end Behavioral;
