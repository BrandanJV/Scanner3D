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

    Port(clk, reset, vauxp10, vauxn10: in std_logic;
        VS, HS, xpwm, ypwm: out std_logic;
        red, green, blue: out std_logic_vector(3 downto 0)
        --dd : out std_logic_vector(11 downto 0)
        );
        
end Main;

architecture Behavioral of Main is

    component sensorDriver is
        Port (clk, vp, vn, vauxp10, vauxn10: in std_logic;
          dout: out std_logic_vector(11 downto 0));
    end component;
    
    component xServo is
        Port(clk: in std_logic;
            runX: in std_logic;
            pwmX: out std_logic);
    end component;
    
    component yServo is
        Port(clk: in std_logic;
            RunY: out std_logic;
            pwmY: out std_logic);
    end component;
    
    component Draw is
        Port(clk, reset : in std_logic;
        image: in std_logic_vector(11 downto 0);
        VS, HS: out std_logic;
        red, green, blue:  out std_logic_vector(3 downto 0));
    end component;
    
signal vp, vn: std_logic;
signal run: std_logic:= '0';
signal d_out: std_logic_vector(11 downto 0);

begin

--dd <= d_out(15 downto 4);

ServoX: xServo port map(clk => clk, Runx => run, pwmX => xpwm);
ServoY: yServo port map(clk => clk, Runy => run, pwmY => ypwm);
Sensor: sensorDriver port map(clk => clk, vp => vp, vn => vn, vauxp10 => vauxp10, vauxn10 => vauxn10, dout => d_out);
DisplayVGA: Draw port map(clk => clk, reset => reset, image => d_out, VS => VS, HS => HS, red => red, green => green, blue => blue);

end Behavioral;
