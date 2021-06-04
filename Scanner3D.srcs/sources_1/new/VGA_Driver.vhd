----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2021 18:42:10
-- Design Name: 
-- Module Name: VGA_Driver - Behavioral
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

entity VGA_Driver is
    Port (clk, reset : in std_logic;
        HS, VS, video_on: out std_logic;
        column, row: out std_logic_vector(9 downto 0));
end VGA_Driver;

 architecture Behavioral of VGA_Driver is

    component clk_wiz_0
        port
         (clk25:out std_logic; -- Clock out ports
          clk:  in  std_logic -- Status and control signals
         );
         
    end component;
    
constant h_pulse  : integer := 96;    --horiztonal sync pulse width in pixels
constant h_bp     : integer := 48;    --horiztonal back porch width in pixels
constant h_pixels : integer := 640;   --horiztonal display width in pixels
constant h_fp     : integer := 16;    --horiztonal front porch width in pixels
constant v_pulse  : integer := 2;      --vertical sync pulse width in rows
constant v_bp     : integer := 33;     --vertical back porch width in rows
constant v_pixels : integer := 480;   --vertical display width in rows
constant v_fp     : integer := 10;      --vertical front porch width in rows
constant h_period : integer := h_pulse + h_bp + h_pixels + h_fp; --total number of pixel clocks in a row
constant v_period : integer := v_pulse + v_bp + v_pixels + v_fp; --total number of rows in column
signal hcount_reg,vcount_reg : integer range 0 to 799;
signal clk25: std_logic := '0';

begin

    vs_and_hs_generator: process(clk25, reset)
    variable h_count : integer range 0 to h_period - 1 := 0;  --horizontal counter (counts the columns)
    variable v_count : integer range 0 to v_period - 1 := 0;  --vertical counter (counts the rows)
    begin
        if(reset= '1') then    --reset asserted
          h_count := 0;             --reset horizontal counter
          v_count := 0;             --reset vertical counter
          hs <= '1';      --deassert horizontal sync
          vs <= '1';      --deassert vertical sync
          video_on <= '0';          --disable display
          column <= (others => '0');              --reset column pixel coordinate
          row <= (others => '0');                 --reset row pixel coordinate
        
        elsif(clk25'event and clk25 = '1') then
            if(h_count < h_period - 1) then
                h_count := h_count + 1;
            else
                h_count := 0;
                if(v_count < v_period - 1) then
                    v_count := v_count + 1;
                else
                    v_count := 0;
                end if;    
            end if;
           
            if(h_count >= h_pulse AND h_count <= h_period - 1) then
                HS <= '1';
            else
                HS <= '0';
            end if;
            
            if(v_count >= v_pulse AND v_count <= v_period-1) then
                VS <= '1';
            else
                VS <= '0';
            end if;                
            
            --if(h_count < h_pixels) then
                column <= std_logic_vector(to_unsigned(h_count, 10));
            --end if;
            
            --if(v_count < v_pixels) then
                row <= std_logic_vector(to_unsigned(v_count, 10));
            --end if;

            if(h_count < h_pixels AND v_count < v_pixels) then
                video_on <= '1';
            else            
                video_on <= '0';
            end if;
        end if; 
    end process;

clk25MHZ : clk_wiz_0 port map (clk25 => clk25, clk => clk);

end Behavioral;
