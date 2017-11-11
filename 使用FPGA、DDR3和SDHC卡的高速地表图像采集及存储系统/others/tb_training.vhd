--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:50:54 08/15/2017
-- Design Name:   
-- Module Name:   D:/li/gesens/out/ddr2/full_ddr2_20170812_right_isim/tb_training.vhd
-- Project Name:  ddr_2_place
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IND_B
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_training IS
END tb_training;
 
ARCHITECTURE behavior OF tb_training IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IND_B
    PORT(
         Clk200m : IN  std_logic;
         CLK200M_Rst : IN  std_logic;
         Clk_DDR : IN  std_logic;
         Clk_DDR_Div : IN  std_logic;
         Cmd_Training : IN  std_logic;
         LVDS_IN_P : IN  std_logic_vector(31 downto 0);
         LVDS_IN_N : IN  std_logic_vector(31 downto 0);
         LVDS_OUT1 : OUT  std_logic_vector(191 downto 0);
         LVDS_OUT2 : OUT  std_logic_vector(191 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk200m : std_logic := '0';
   signal CLK200M_Rst : std_logic := '0';
   signal Clk_DDR : std_logic := '0';
   signal Clk_DDR_Div : std_logic := '0';
   signal Cmd_Training : std_logic := '0';
   signal LVDS_IN_P : std_logic_vector(31 downto 0) := (others => '0');
   signal LVDS_IN_N : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal LVDS_OUT1 : std_logic_vector(191 downto 0);
   signal LVDS_OUT2 : std_logic_vector(191 downto 0);

   -- Clock period definitions
   constant Clk200m_period : time := 5 ns;
   constant Clk_DDR_period : time := 4 ns;
   constant Clk_DDR_Div_period : time := 24 ns;
 
 	signal cnt12: integer range 0 to 15;
 
	signal Clk_DDR_mux : std_logic ;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IND_B PORT MAP (
          Clk200m => Clk200m,
          CLK200M_Rst => CLK200M_Rst,
          Clk_DDR => Clk_DDR,
          Clk_DDR_Div => Clk_DDR_Div,
          Cmd_Training => Cmd_Training,
          LVDS_IN_P => LVDS_IN_P,
          LVDS_IN_N => LVDS_IN_N,
          LVDS_OUT1 => LVDS_OUT1,
          LVDS_OUT2 => LVDS_OUT2
        );

   -- Clock process definitions
   Clk200m_process :process
   begin
		Clk200m <= '0';
		wait for Clk200m_period/2;
		Clk200m <= '1';
		wait for Clk200m_period/2;
   end process;
 
   CLK200M_Rst_process :process
   begin
		CLK200M_Rst <= '1';
		wait for 1 us;
		CLK200M_Rst <= '0';
		wait ;
   end process;
 
    process
   begin
		Cmd_Training <= '1';
		wait for 2 us;
		Cmd_Training <= '0';
		wait for 100 us;
		Cmd_Training <= '1';
		wait for 100 us;
		Cmd_Training <= '0';
		wait for 100 us;
		Cmd_Training <= '1';
		wait;
		
   end process;
 
 
 
   Clk_DDR_process :process
   begin
		Clk_DDR <= '0';
		wait for Clk_DDR_period/2;
		Clk_DDR <= '1';
		wait for Clk_DDR_period/2;
   end process;
 
   Clk_DDR_Div_process :process
   begin
		Clk_DDR_Div <= '0';
		wait for Clk_DDR_Div_period/2;
		Clk_DDR_Div <= '1';
		wait for Clk_DDR_Div_period/2;
   end process;

	process
   begin
		Clk_DDR_mux <= '0';
		wait for 1 ns;
		Clk_DDR_mux <= '1';
		wait for 1 ns;
   end process;

 
	process(Clk_DDR_mux) begin
		if rising_edge(Clk_DDR_mux) then
			if cnt12=11 then
				cnt12<=0;
			else
				cnt12<=cnt12+1;
			end if;
		end if;
	end process;		

	process(Clk_DDR_mux) begin
		if rising_edge(Clk_DDR_mux) then
			case cnt12 is 
				when 0 =>
					LVDS_IN_P<=x"ffffffff";
					LVDS_IN_N<=x"00000000";
				when 1 =>
					LVDS_IN_P<=x"00000000";
					LVDS_IN_N<=x"ffffffff";
				when 2 =>
					LVDS_IN_P<=x"00000000";
					LVDS_IN_N<=x"ffffffff";
				when 3 =>
					LVDS_IN_P<=x"ffffffff";
					LVDS_IN_N<=x"00000000";
				when 4 =>
					LVDS_IN_P<=x"ffffffff";
					LVDS_IN_N<=x"00000000";
				when 5 =>
					LVDS_IN_P<=x"00000000";
					LVDS_IN_N<=x"ffffffff";
				when 6 =>
					LVDS_IN_P<=x"00000000";
					LVDS_IN_N<=x"ffffffff";
				when 7 =>
					LVDS_IN_P<=x"00000000";
					LVDS_IN_N<=x"ffffffff";
				when 8 =>
					LVDS_IN_P<=x"ffffffff";
					LVDS_IN_N<=x"00000000";
				when 9 =>
					LVDS_IN_P<=x"ffffffff";
					LVDS_IN_N<=x"00000000";
				when 10 =>
					LVDS_IN_P<=x"ffffffff";
					LVDS_IN_N<=x"00000000";
				when 11 =>
					LVDS_IN_P<=x"00000000";
					LVDS_IN_N<=x"ffffffff";
				when others =>
					null;
			end case;
		end if;
	end process;



END;
