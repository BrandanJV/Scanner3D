----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 16:41:54
-- Design Name: 
-- Module Name: Main - Behavioral
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

entity Main is

    Port(clk, sensor, reset: in std_logic;
        VS, HS, xpwm, ypwm: out std_logic;
        red, green, blue: out std_logic_vector(3 downto 0));
        
end Main;

architecture Behavioral of Main is
    
    component xServo is
        Port(clk: in std_logic;
            pwmX: out std_logic);
    end component;
    
    component yServo is
        Port(clk: in std_logic;
            pwmY: out std_logic);
    end component;
    
    component Draw is
        Port(clk, reset : in std_logic;
        VS, HS: out std_logic;
        red, green, blue:  out std_logic_vector(3 downto 0));
    end component;
    
begin


ServoX: xServo port map(clk => clk, pwmX => xpwm);
ServoY: yServo port map(clk => clk, pwmY => ypwm);
DisplayVGA: Draw port map(clk => clk, reset => reset, VS => VS, HS => HS, red => red, green => green, blue => blue);

end Behavioral;
