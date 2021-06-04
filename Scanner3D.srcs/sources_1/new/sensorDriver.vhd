----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2021 16:56:11
-- Design Name: 
-- Module Name: sensorDriver - Behavioral
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

entity sensorDriver is
    Port (clk, vp, vn, vauxp10, vauxn10: in std_logic;
          dout: out std_logic_vector(11 downto 0));
end sensorDriver;

architecture Behavioral of sensorDriver is
    --Xadc Wizard component
    COMPONENT xadc_wiz_0
      PORT (
        di_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        daddr_in : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
        den_in : IN STD_LOGIC;
        dwe_in : IN STD_LOGIC;
        drdy_out : OUT STD_LOGIC;
        do_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        dclk_in : IN STD_LOGIC;
        reset_in : IN STD_LOGIC;
        vp_in : IN STD_LOGIC;
        vn_in : IN STD_LOGIC;
        vauxp10 : IN STD_LOGIC;
        vauxn10 : IN STD_LOGIC;
        channel_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        eoc_out : OUT STD_LOGIC;
        alarm_out : OUT STD_LOGIC;
        eos_out : OUT STD_LOGIC;
        busy_out : OUT STD_LOGIC
      );
    END COMPONENT;

signal enable, write_enable, alarm, end_sequence, is_busy, data_ready: std_logic;
signal reset: std_logic := '0';
signal channel:  std_logic_vector( 4 downto 0);
signal daddr_aux: std_logic_vector(6 downto 0);
signal dx: std_logic_vector(15 downto 0);
begin

dout <= dx(15 downto 4);
daddr_aux <= "00" & channel; 

adc : xadc_wiz_0 port map(
    di_in => (others => '0'),
    daddr_in => daddr_aux,
    den_in => enable,
    dwe_in => data_ready,
    drdy_out => data_ready,
    do_out => dx,
    dclk_in => clk,
    reset_in => reset,
    vp_in => vp,
    vn_in => vn,
    vauxp10 => vauxp10,
    vauxn10 => vauxn10,
    channel_out => channel,
    eoc_out => enable,
    alarm_out => alarm,
    eos_out => open,
    busy_out => open
  );
end Behavioral;
