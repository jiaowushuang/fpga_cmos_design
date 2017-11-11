-------------------------------------------------------------------------------
-- Copyright (c) 2017 Xilinx, Inc.
-- All Rights Reserved
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor     : Xilinx
-- \   \   \/     Version    : 14.7
--  \   \         Application: XILINX CORE Generator
--  /   /         Filename   : icon_pro.vhd
-- /___/   /\     Timestamp  : Sat Nov 04 13:22:18 China Standard Time 2017
-- \   \  /  \
--  \___\/\___\
--
-- Design Name: VHDL Synthesis Wrapper
-------------------------------------------------------------------------------
-- This wrapper is used to integrate with Project Navigator and PlanAhead

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY icon_pro IS
  port (
    CONTROL0: inout std_logic_vector(35 downto 0));
END icon_pro;

ARCHITECTURE icon_pro_a OF icon_pro IS
BEGIN

END icon_pro_a;
