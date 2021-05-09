----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 16:42:54
-- Design Name: 
-- Module Name: pwmGenerator - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwmGenerator is
  Port (clk: in std_logic;
        desiredpwm: in integer;
        pwm_out: out std_logic );
end pwmGenerator;

architecture Behavioral of pwmGenerator is
subtype u20 is INTEGER range 0 to 2_000_000;	        -- Data type INTEGER only for range from 1 to 2,000,000
signal counter      : u20 := 0;

constant clk_freq   : integer := 100_000_000;           -- Clock frequency in Hz (10 ns)
constant pwm_freq   : integer := 50;                    -- PWM signal frequency in Hz (20 ms)
constant period     : integer := clk_freq/pwm_freq;     -- Clock cycle count per PWM period

signal duty_cycle : integer := 50_000;                -- Clock cycle count per PWM duty cycle
signal pwm_counter  : std_logic := '0';                 -- Internal PWM signal

begin

    duty_cycle <= desiredpwm;

    pwm_generator : process(clk) is
    variable cnt : integer range 0 to period := 0;      -- CLK pulse counter
    begin
        if (rising_edge(clk)) then
            counter <= cnt;                             -- SIGNAL that allows to see CLK pulse count on simulation
            cnt := cnt + 1;  
            if (cnt <= duty_cycle) then                 -- Duty cycle (PWM high)
                pwm_counter <= '1'; 
            elsif (cnt > duty_cycle) then               -- PWM low
                pwm_counter <= '0';
                if (cnt = period) then                  -- Counter reset when period reached
                    cnt := 0;
                end if;
            end if;  
        end if;
    end process pwm_generator;
    pwm_out <= pwm_counter;

end Behavioral;
