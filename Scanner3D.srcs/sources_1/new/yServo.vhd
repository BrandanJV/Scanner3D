----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 18:18:38
-- Design Name: 
-- Module Name: yServo - Behavioral
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

entity yServo is
    Port (clk: in std_logic;
        pwmY: out std_logic);
end yServo;

architecture Behavioral of yServo is
    
    component pwmGenerator is
        port(clk: in std_logic;
            desiredpwm: in integer;
            pwm_out: out std_logic);
    end component;

signal ypwm: integer:= 100_000;

begin

YS: pwmGenerator port map(clk => clk, desiredpwm => ypwm, pwm_out => pwmY);

end Behavioral;
