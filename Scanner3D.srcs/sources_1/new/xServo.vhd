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
        runX: in std_logic; -- signal sent by Yservo. 1 when finish rotation, 0 else;
        pwmX: out std_logic:='0');
end xServo;

architecture Behavioral of xServo is

    component pwmGenerator is
        port(clk: in std_logic;
            desiredpwm: in integer;
            pwm_out: out std_logic);
    end component;
    
type stateType is(S0, S45, S90, S135, S180);-- states according to their angle
signal currentState, nextState: stateType;  -- state machine
signal xpwm: integer := 50_000;     -- duty cycle received by the pwm generator
signal reset: std_logic := '0';


begin

	--Syncrhonous process (State FFs)
	syncProcess: process(reset, clk)
	begin
		if (reset = '1') then 
			currentState <= S0;
		elsif (rising_edge(Clk)) then
			currentState <= nextState;
		end if;
	end process syncProcess;
	
	--Combinatorial process (State and output decode)
	combProcess: process(currentState, runX)
	begin
	case currentState is
		when S0 =>                --0 degrees
			xpwm <= 50_000;
			if (RunX = '1') then
				nextState <= S45;
			else
				nextState <= S0;
			end if;
		when S45 =>               -- 45 degrees
		  xpwm <= 100_000;
            if (RunX = '1') then
				nextState <= S90;
			else
				nextState <= S45;
			end if;
        when S90 =>                 --90 degrees
            xpwm <= 150_000;
                if(RunX = '1') then
                    nextState <= S135;
                else
                    nextState <= S90;
                end if;
        when S135 =>
            xpwm <= 200_000;
            if(RunX = '1') then 
                nextState <= S180;
            else
                nextState <= S135;
            end if;
        when S180 =>                    --180 degrees
            xpwm <= 250_000;
            if(RunX = '1') then
                nextState <= S0;
            else 
                nextState <= S180;  
            end if;                        
		when others =>                
			nextState <= S0;
	end case;
	end process combProcess;
	
XS: pwmGenerator port map(clk => clk, desiredpwm =>xpwm, pwm_out => pwmX);
end Behavioral;