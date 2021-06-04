----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2021 12:56:44
-- Design Name: 
-- Module Name: IR_Sensor - Behavioral
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

entity IR_Sensor is
    Port(clk, vp, vn: in std_logic;
        dout: out std_logic_vector(15 downto 0));
end IR_Sensor;

architecture Behavioral of IR_Sensor is

    component sensorDriver is
        Port (clk, vp, vn: in std_logic;
          dout: out std_logic_vector(15 downto 0));
    end component;
begin

SD: sensorDriver port map(clk => clk, vp => vp, vn => vn, dout => dout);
end Behavioral;
