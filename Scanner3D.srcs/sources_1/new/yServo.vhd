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
use IEEE.NUMERIC_STD.ALL;

entity yServo is
    Port (clk: in std_logic;
        runY: out std_logic:= '0';
        pwmY: out std_logic:= '0');
end yServo;

architecture Behavioral of yServo is
    
    component pwmGenerator is
        port(clk: in std_logic;
            desiredpwm: in integer;
            pwm_out: out std_logic);
    end component;

type stateType is(S0, S15, S30, S45, S60);-- states according to their angle
signal currentState, nextState: stateType;  -- state machine
signal Ypwm: integer := 50_000;     -- duty cycle received by the pwm generator
signal reset, nxt: std_logic := '0';
signal clk25: std_logic := '0';
signal cnt: integer range 0 to 100*479_000; -- sensor takes 38.3+- 9.6 ms to make a measure, so it takes 4,790,000 clock cycles to make a measure (4 times to make a pwm cycle at least)
begin

    nxt <= '1' when cnt = 100*479_000
        else '0';

	--Syncrhonous process (State FFs)
	syncProcess: process(reset, clk)
	begin
		if (reset = '1') then 
		  currentState <= S0;
		elsif (rising_edge(Clk)) then
		  currentState <= nextState; 
		  if(cnt = 100*479_000) then
            cnt <= 0;
          else
            cnt <= cnt + 1;
          end if;
		end if;
	end process syncProcess;
	
    --Combinatorial process (State and output decode)
	combProcess: process(currentState, nxt)
	begin
	case currentState is
		when S0 =>                    -- 0 degrees
	        runY <= '0';
            Ypwm <= 50_000;
			if (nxt = '1') then
				nextState <= S15;
			else
				nextState <= S0;
			end if;
		when S15 =>                     -- 15 degrees
		    Ypwm <= 66_667;
		    runY <= '0';
            if (nxt = '1') then
                nextState <= S30;
            else
                nextState <= S15;
            end if;
        when S30 =>                     --30 degrees
            Ypwm <= 83_333;
            runY <= '0';
            if(nxt = '1') then
                nextState <= S45;
            else
                nextState <= S30;
            end if;
        when S45 =>                     --45 degrees
            Ypwm <= 100_000;
            runY <= '0';
            if(nxt = '1') then 
                nextState <= S60;
            else
                nextState <= S45;
            end if;
        when S60 =>                    --60 degrees
            Ypwm <= 116_667;
            runY <= '0';
            if(nxt = '1') then
                nextState <= S0;
                runY <= '1';
            else 
                nextState <= S60;  
            end if;                        
		when others => 
		    runY <= '0';               
			nextState <= S0;
	end case;
	end process combProcess;

YS: pwmGenerator port map(clk => clk, desiredpwm => ypwm, pwm_out => pwmY);
end Behavioral;
