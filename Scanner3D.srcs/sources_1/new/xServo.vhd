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


entity xServo is
    Port(clk: in std_logic;
        pwmX: out std_logic);
end xServo;

architecture Behavioral of xServo is

    component pwmGenerator is
        port(clk: in std_logic;
            desiredpwm: in integer;
            pwm_out: out std_logic);
    end component;
    
signal xpwm: integer := 200_000;

begin

XS: pwmGenerator port map(clk => clk, desiredpwm =>xpwm, pwm_out => pwmX);
end Behavioral;