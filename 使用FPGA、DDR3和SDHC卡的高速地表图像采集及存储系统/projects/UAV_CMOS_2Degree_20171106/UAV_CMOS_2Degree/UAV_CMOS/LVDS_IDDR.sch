<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_5" />
        <signal name="XLXN_6" />
        <signal name="XLXN_7" />
        <signal name="XLXN_8" />
        <signal name="XLXN_9" />
        <signal name="XLXN_10" />
        <signal name="XLXN_11" />
        <signal name="XLXN_12" />
        <signal name="XLXN_13" />
        <signal name="XLXN_14" />
        <signal name="LVDS_Channel1" />
        <signal name="LVDS_Channel2" />
        <signal name="LVDS_Channel3" />
        <signal name="CMOS_CLK" />
        <signal name="CMOS_CLK_INV" />
        <signal name="XLXN_32" />
        <signal name="XLXN_34" />
        <signal name="XLXN_36" />
        <signal name="XLXN_38" />
        <signal name="XLXN_40" />
        <signal name="XLXN_43" />
        <signal name="Channel_0_P" />
        <signal name="Channel_0_N" />
        <signal name="Channel_1_P" />
        <signal name="Channel_1_N" />
        <signal name="Channel_2_P" />
        <signal name="Channel_2_N" />
        <signal name="Channel_3_P" />
        <signal name="Channel_3_N" />
        <signal name="Sync_P" />
        <signal name="Sync_N" />
        <signal name="XLXN_47" />
        <signal name="LVDS_Channel0" />
        <signal name="XLXN_49" />
        <signal name="LVDS_Sync" />
        <port polarity="Input" name="LVDS_Channel1" />
        <port polarity="Input" name="LVDS_Channel2" />
        <port polarity="Input" name="LVDS_Channel3" />
        <port polarity="Input" name="CMOS_CLK" />
        <port polarity="Input" name="CMOS_CLK_INV" />
        <port polarity="Output" name="Channel_0_P" />
        <port polarity="Output" name="Channel_0_N" />
        <port polarity="Output" name="Channel_1_P" />
        <port polarity="Output" name="Channel_1_N" />
        <port polarity="Output" name="Channel_2_P" />
        <port polarity="Output" name="Channel_2_N" />
        <port polarity="Output" name="Channel_3_P" />
        <port polarity="Output" name="Channel_3_N" />
        <port polarity="Output" name="Sync_P" />
        <port polarity="Output" name="Sync_N" />
        <port polarity="Input" name="LVDS_Channel0" />
        <port polarity="Input" name="LVDS_Sync" />
        <blockdef name="iddr2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <rect width="192" x="64" y="-304" height="392" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <line x2="0" y1="64" y2="64" x1="64" />
            <line x2="0" y1="0" y2="0" x1="64" />
            <line x2="0" y1="-192" y2="-192" x1="64" />
            <line x2="0" y1="-256" y2="-256" x1="64" />
            <line x2="320" y1="-192" y2="-192" x1="256" />
            <line x2="320" y1="-32" y2="-32" x1="256" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
        </blockdef>
        <blockdef name="fd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <rect width="256" x="64" y="-320" height="256" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
        </blockdef>
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <blockdef name="iodelay2">
            <timestamp>2009-3-13T20:26:47</timestamp>
            <rect width="256" x="64" y="-640" height="640" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-608" y2="-608" x1="320" />
            <line x2="384" y1="-464" y2="-464" x1="320" />
            <line x2="384" y1="-320" y2="-320" x1="320" />
            <line x2="384" y1="-176" y2="-176" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="fd" name="XLXI_180">
            <blockpin signalname="CMOS_CLK" name="C" />
            <blockpin signalname="XLXN_5" name="D" />
            <blockpin signalname="Channel_0_P" name="Q" />
        </block>
        <block symbolname="fd" name="XLXI_181">
            <blockpin signalname="CMOS_CLK" name="C" />
            <blockpin signalname="XLXN_6" name="D" />
            <blockpin signalname="Channel_0_N" name="Q" />
        </block>
        <block symbolname="fd" name="XLXI_182">
            <blockpin signalname="CMOS_CLK" name="C" />
            <blockpin signalname="XLXN_7" name="D" />
            <blockpin signalname="Channel_1_P" name="Q" />
        </block>
        <block symbolname="fd" name="XLXI_183">
            <blockpin signalname="CMOS_CLK" name="C" />
            <blockpin signalname="XLXN_8" name="D" />
            <blockpin signalname="Channel_1_N" name="Q" />
        </block>
        <block symbolname="fd" name="XLXI_184">
            <blockpin signalname="CMOS_CLK" name="C" />
            <blockpin signalname="XLXN_10" name="D" />
            <blockpin signalname="Channel_2_P" name="Q" />
        </block>
        <block symbolname="fd" name="XLXI_185">
            <blockpin signalname="CMOS_CLK" name="C" />
            <blockpin signalname="XLXN_9" name="D" />
            <blockpin signalname="Channel_2_N" name="Q" />
        </block>
        <block symbolname="fd" name="XLXI_186">
            <blockpin signalname="CMOS_CLK" name="C" />
            <blockpin signalname="XLXN_12" name="D" />
            <blockpin signalname="Channel_3_P" name="Q" />
        </block>
        <block symbolname="fd" name="XLXI_187">
            <blockpin signalname="CMOS_CLK" name="C" />
            <blockpin signalname="XLXN_11" name="D" />
            <blockpin signalname="Channel_3_N" name="Q" />
        </block>
        <block symbolname="fd" name="XLXI_188">
            <blockpin signalname="CMOS_CLK" name="C" />
            <blockpin signalname="XLXN_14" name="D" />
            <blockpin signalname="Sync_P" name="Q" />
        </block>
        <block symbolname="fd" name="XLXI_189">
            <blockpin signalname="CMOS_CLK" name="C" />
            <blockpin signalname="XLXN_13" name="D" />
            <blockpin signalname="Sync_N" name="Q" />
        </block>
        <block symbolname="iddr2" name="XLXI_200">
            <blockpin signalname="XLXN_47" name="D" />
            <blockpin signalname="CMOS_CLK" name="C0" />
            <blockpin signalname="CMOS_CLK_INV" name="C1" />
            <blockpin signalname="XLXN_43" name="CE" />
            <blockpin signalname="XLXN_32" name="R" />
            <blockpin signalname="XLXN_32" name="S" />
            <blockpin signalname="XLXN_5" name="Q0" />
            <blockpin signalname="XLXN_6" name="Q1" />
        </block>
        <block symbolname="iddr2" name="XLXI_201">
            <blockpin signalname="LVDS_Channel1" name="D" />
            <blockpin signalname="CMOS_CLK" name="C0" />
            <blockpin signalname="CMOS_CLK_INV" name="C1" />
            <blockpin signalname="XLXN_43" name="CE" />
            <blockpin signalname="XLXN_34" name="R" />
            <blockpin signalname="XLXN_34" name="S" />
            <blockpin signalname="XLXN_7" name="Q0" />
            <blockpin signalname="XLXN_8" name="Q1" />
        </block>
        <block symbolname="iddr2" name="XLXI_202">
            <blockpin signalname="LVDS_Channel2" name="D" />
            <blockpin signalname="CMOS_CLK" name="C0" />
            <blockpin signalname="CMOS_CLK_INV" name="C1" />
            <blockpin signalname="XLXN_43" name="CE" />
            <blockpin signalname="XLXN_36" name="R" />
            <blockpin signalname="XLXN_36" name="S" />
            <blockpin signalname="XLXN_10" name="Q0" />
            <blockpin signalname="XLXN_9" name="Q1" />
        </block>
        <block symbolname="iddr2" name="XLXI_203">
            <blockpin signalname="LVDS_Channel3" name="D" />
            <blockpin signalname="CMOS_CLK" name="C0" />
            <blockpin signalname="CMOS_CLK_INV" name="C1" />
            <blockpin signalname="XLXN_43" name="CE" />
            <blockpin signalname="XLXN_38" name="R" />
            <blockpin signalname="XLXN_38" name="S" />
            <blockpin signalname="XLXN_12" name="Q0" />
            <blockpin signalname="XLXN_11" name="Q1" />
        </block>
        <block symbolname="iddr2" name="XLXI_204">
            <blockpin signalname="XLXN_49" name="D" />
            <blockpin signalname="CMOS_CLK" name="C0" />
            <blockpin signalname="CMOS_CLK_INV" name="C1" />
            <blockpin signalname="XLXN_43" name="CE" />
            <blockpin signalname="XLXN_40" name="R" />
            <blockpin signalname="XLXN_40" name="S" />
            <blockpin signalname="XLXN_14" name="Q0" />
            <blockpin signalname="XLXN_13" name="Q1" />
        </block>
        <block symbolname="gnd" name="XLXI_205">
            <blockpin signalname="XLXN_32" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_206">
            <blockpin signalname="XLXN_34" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_207">
            <blockpin signalname="XLXN_36" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_208">
            <blockpin signalname="XLXN_38" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_209">
            <blockpin signalname="XLXN_40" name="G" />
        </block>
        <block symbolname="vcc" name="XLXI_210">
            <blockpin signalname="XLXN_43" name="P" />
        </block>
        <block symbolname="iodelay2" name="XLXI_213">
            <attr value="FIXED" name="IDELAY_TYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList DEFAULT DIFF_PHASE_DETECTOR FIXED VARIABLE_FROM_HALF_MAX VARIABLE_FROM_ZERO" />
            </attr>
            <attr value="IDATAIN" name="DELAY_SRC">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList IO IDATAIN ODATAIN" />
            </attr>
            <attr value="10" name="IDELAY_VALUE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Integer 0 255" />
            </attr>
            <attr value="DDR" name="DATA_RATE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SDR DDR" />
            </attr>
            <blockpin name="CAL" />
            <blockpin name="CE" />
            <blockpin name="CLK" />
            <blockpin signalname="LVDS_Channel0" name="IDATAIN" />
            <blockpin name="INC" />
            <blockpin name="IOCLK0" />
            <blockpin name="IOCLK1" />
            <blockpin name="ODATAIN" />
            <blockpin name="RST" />
            <blockpin name="T" />
            <blockpin name="BUSY" />
            <blockpin signalname="XLXN_47" name="DATAOUT" />
            <blockpin name="DATAOUT2" />
            <blockpin name="DOUT" />
            <blockpin name="TOUT" />
        </block>
        <block symbolname="iodelay2" name="XLXI_214">
            <attr value="FIXED" name="IDELAY_TYPE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList DEFAULT DIFF_PHASE_DETECTOR FIXED VARIABLE_FROM_HALF_MAX VARIABLE_FROM_ZERO" />
            </attr>
            <attr value="IDATAIN" name="DELAY_SRC">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList IO IDATAIN ODATAIN" />
            </attr>
            <attr value="10" name="IDELAY_VALUE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="Integer 0 255" />
            </attr>
            <attr value="DDR" name="DATA_RATE">
                <trait editname="all:1 sch:0" />
                <trait edittrait="all:1 sch:0" />
                <trait verilog="all:0 dp:1nosynth wsynop:1 wsynth:1" />
                <trait vhdl="all:0 gm:1nosynth wa:1 wd:1" />
                <trait valuetype="StringValList SDR DDR" />
            </attr>
            <blockpin name="CAL" />
            <blockpin name="CE" />
            <blockpin name="CLK" />
            <blockpin signalname="LVDS_Sync" name="IDATAIN" />
            <blockpin name="INC" />
            <blockpin name="IOCLK0" />
            <blockpin name="IOCLK1" />
            <blockpin name="ODATAIN" />
            <blockpin name="RST" />
            <blockpin name="T" />
            <blockpin name="BUSY" />
            <blockpin signalname="XLXN_49" name="DATAOUT" />
            <blockpin name="DATAOUT2" />
            <blockpin name="DOUT" />
            <blockpin name="TOUT" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="2176" y="400" name="XLXI_180" orien="R0" />
        <instance x="2176" y="656" name="XLXI_181" orien="R0" />
        <instance x="2176" y="912" name="XLXI_182" orien="R0" />
        <instance x="2176" y="1424" name="XLXI_184" orien="R0" />
        <instance x="2176" y="1936" name="XLXI_186" orien="R0" />
        <instance x="2176" y="2192" name="XLXI_187" orien="R0" />
        <instance x="2176" y="2448" name="XLXI_188" orien="R0" />
        <instance x="2176" y="2704" name="XLXI_189" orien="R0" />
        <instance x="2176" y="1680" name="XLXI_185" orien="R0" />
        <instance x="2176" y="1168" name="XLXI_183" orien="R0" />
        <instance x="1280" y="432" name="XLXI_200" orien="R0" />
        <instance x="1280" y="944" name="XLXI_201" orien="R0" />
        <instance x="1296" y="1968" name="XLXI_203" orien="R0" />
        <instance x="1296" y="2480" name="XLXI_204" orien="R0" />
        <branch name="XLXN_5">
            <wire x2="1888" y1="240" y2="240" x1="1600" />
            <wire x2="1888" y1="144" y2="240" x1="1888" />
            <wire x2="2176" y1="144" y2="144" x1="1888" />
        </branch>
        <branch name="XLXN_6">
            <wire x2="2176" y1="400" y2="400" x1="1600" />
        </branch>
        <branch name="XLXN_7">
            <wire x2="1888" y1="752" y2="752" x1="1600" />
            <wire x2="1888" y1="656" y2="752" x1="1888" />
            <wire x2="2176" y1="656" y2="656" x1="1888" />
        </branch>
        <branch name="XLXN_8">
            <wire x2="2176" y1="912" y2="912" x1="1600" />
        </branch>
        <branch name="XLXN_9">
            <wire x2="2176" y1="1424" y2="1424" x1="1616" />
        </branch>
        <branch name="XLXN_10">
            <wire x2="1760" y1="1264" y2="1264" x1="1616" />
            <wire x2="1760" y1="1168" y2="1264" x1="1760" />
            <wire x2="2176" y1="1168" y2="1168" x1="1760" />
        </branch>
        <instance x="1296" y="1456" name="XLXI_202" orien="R0" />
        <branch name="XLXN_11">
            <wire x2="2176" y1="1936" y2="1936" x1="1616" />
        </branch>
        <branch name="XLXN_12">
            <wire x2="1888" y1="1776" y2="1776" x1="1616" />
            <wire x2="1888" y1="1680" y2="1776" x1="1888" />
            <wire x2="2176" y1="1680" y2="1680" x1="1888" />
        </branch>
        <branch name="XLXN_13">
            <wire x2="2176" y1="2448" y2="2448" x1="1616" />
        </branch>
        <branch name="XLXN_14">
            <wire x2="1888" y1="2288" y2="2288" x1="1616" />
            <wire x2="1888" y1="2192" y2="2288" x1="1888" />
            <wire x2="2176" y1="2192" y2="2192" x1="1888" />
        </branch>
        <branch name="CMOS_CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1968" y="272" type="branch" />
            <wire x2="2048" y1="272" y2="272" x1="1968" />
            <wire x2="2048" y1="272" y2="528" x1="2048" />
            <wire x2="2048" y1="528" y2="784" x1="2048" />
            <wire x2="2048" y1="784" y2="1040" x1="2048" />
            <wire x2="2048" y1="1040" y2="1296" x1="2048" />
            <wire x2="2048" y1="1296" y2="1552" x1="2048" />
            <wire x2="2048" y1="1552" y2="1808" x1="2048" />
            <wire x2="2048" y1="1808" y2="2064" x1="2048" />
            <wire x2="2048" y1="2064" y2="2320" x1="2048" />
            <wire x2="2048" y1="2320" y2="2576" x1="2048" />
            <wire x2="2176" y1="2576" y2="2576" x1="2048" />
            <wire x2="2176" y1="2320" y2="2320" x1="2048" />
            <wire x2="2176" y1="2064" y2="2064" x1="2048" />
            <wire x2="2176" y1="1808" y2="1808" x1="2048" />
            <wire x2="2176" y1="1552" y2="1552" x1="2048" />
            <wire x2="2176" y1="1296" y2="1296" x1="2048" />
            <wire x2="2176" y1="1040" y2="1040" x1="2048" />
            <wire x2="2176" y1="784" y2="784" x1="2048" />
            <wire x2="2176" y1="528" y2="528" x1="2048" />
            <wire x2="2176" y1="272" y2="272" x1="2048" />
        </branch>
        <branch name="LVDS_Channel1">
            <wire x2="1264" y1="688" y2="688" x1="1072" />
            <wire x2="1280" y1="688" y2="688" x1="1264" />
        </branch>
        <branch name="LVDS_Channel2">
            <wire x2="1296" y1="1200" y2="1200" x1="928" />
        </branch>
        <branch name="LVDS_Channel3">
            <wire x2="1296" y1="1712" y2="1712" x1="944" />
        </branch>
        <branch name="CMOS_CLK">
            <wire x2="1104" y1="240" y2="240" x1="1056" />
            <wire x2="1104" y1="240" y2="752" x1="1104" />
            <wire x2="1280" y1="752" y2="752" x1="1104" />
            <wire x2="1104" y1="752" y2="1264" x1="1104" />
            <wire x2="1296" y1="1264" y2="1264" x1="1104" />
            <wire x2="1104" y1="1264" y2="1776" x1="1104" />
            <wire x2="1296" y1="1776" y2="1776" x1="1104" />
            <wire x2="1104" y1="1776" y2="2288" x1="1104" />
            <wire x2="1296" y1="2288" y2="2288" x1="1104" />
            <wire x2="1280" y1="240" y2="240" x1="1104" />
        </branch>
        <branch name="CMOS_CLK_INV">
            <wire x2="1152" y1="304" y2="304" x1="1056" />
            <wire x2="1152" y1="304" y2="816" x1="1152" />
            <wire x2="1280" y1="816" y2="816" x1="1152" />
            <wire x2="1152" y1="816" y2="1328" x1="1152" />
            <wire x2="1296" y1="1328" y2="1328" x1="1152" />
            <wire x2="1152" y1="1328" y2="1840" x1="1152" />
            <wire x2="1296" y1="1840" y2="1840" x1="1152" />
            <wire x2="1152" y1="1840" y2="2352" x1="1152" />
            <wire x2="1296" y1="2352" y2="2352" x1="1152" />
            <wire x2="1280" y1="304" y2="304" x1="1152" />
        </branch>
        <iomarker fontsize="28" x="928" y="1200" name="LVDS_Channel2" orien="R180" />
        <iomarker fontsize="28" x="944" y="1712" name="LVDS_Channel3" orien="R180" />
        <iomarker fontsize="28" x="1056" y="304" name="CMOS_CLK_INV" orien="R180" />
        <iomarker fontsize="28" x="1056" y="240" name="CMOS_CLK" orien="R180" />
        <instance x="1152" y="656" name="XLXI_205" orien="R0" />
        <instance x="1152" y="1184" name="XLXI_206" orien="R0" />
        <instance x="1152" y="1696" name="XLXI_207" orien="R0" />
        <instance x="1152" y="2688" name="XLXI_209" orien="R0" />
        <instance x="1152" y="2208" name="XLXI_208" orien="R0" />
        <branch name="XLXN_32">
            <wire x2="1280" y1="432" y2="432" x1="1216" />
            <wire x2="1216" y1="432" y2="496" x1="1216" />
            <wire x2="1280" y1="496" y2="496" x1="1216" />
            <wire x2="1216" y1="496" y2="528" x1="1216" />
        </branch>
        <branch name="XLXN_34">
            <wire x2="1280" y1="944" y2="944" x1="1216" />
            <wire x2="1216" y1="944" y2="1008" x1="1216" />
            <wire x2="1280" y1="1008" y2="1008" x1="1216" />
            <wire x2="1216" y1="1008" y2="1056" x1="1216" />
        </branch>
        <branch name="XLXN_36">
            <wire x2="1296" y1="1456" y2="1456" x1="1216" />
            <wire x2="1216" y1="1456" y2="1520" x1="1216" />
            <wire x2="1296" y1="1520" y2="1520" x1="1216" />
            <wire x2="1216" y1="1520" y2="1568" x1="1216" />
        </branch>
        <branch name="XLXN_38">
            <wire x2="1296" y1="1968" y2="1968" x1="1216" />
            <wire x2="1216" y1="1968" y2="2032" x1="1216" />
            <wire x2="1296" y1="2032" y2="2032" x1="1216" />
            <wire x2="1216" y1="2032" y2="2080" x1="1216" />
        </branch>
        <branch name="XLXN_40">
            <wire x2="1296" y1="2480" y2="2480" x1="1216" />
            <wire x2="1216" y1="2480" y2="2544" x1="1216" />
            <wire x2="1296" y1="2544" y2="2544" x1="1216" />
            <wire x2="1216" y1="2544" y2="2560" x1="1216" />
        </branch>
        <instance x="1184" y="128" name="XLXI_210" orien="R0" />
        <branch name="XLXN_43">
            <wire x2="1248" y1="128" y2="368" x1="1248" />
            <wire x2="1280" y1="368" y2="368" x1="1248" />
            <wire x2="1248" y1="368" y2="880" x1="1248" />
            <wire x2="1280" y1="880" y2="880" x1="1248" />
            <wire x2="1248" y1="880" y2="1392" x1="1248" />
            <wire x2="1296" y1="1392" y2="1392" x1="1248" />
            <wire x2="1248" y1="1392" y2="1904" x1="1248" />
            <wire x2="1296" y1="1904" y2="1904" x1="1248" />
            <wire x2="1248" y1="1904" y2="2416" x1="1248" />
            <wire x2="1296" y1="2416" y2="2416" x1="1248" />
        </branch>
        <branch name="Channel_0_P">
            <wire x2="2592" y1="144" y2="144" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2592" y="144" name="Channel_0_P" orien="R0" />
        <branch name="Channel_0_N">
            <wire x2="2592" y1="400" y2="400" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2592" y="400" name="Channel_0_N" orien="R0" />
        <branch name="Channel_1_P">
            <wire x2="2592" y1="656" y2="656" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2592" y="656" name="Channel_1_P" orien="R0" />
        <branch name="Channel_1_N">
            <wire x2="2592" y1="912" y2="912" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2592" y="912" name="Channel_1_N" orien="R0" />
        <branch name="Channel_2_P">
            <wire x2="2592" y1="1168" y2="1168" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2592" y="1168" name="Channel_2_P" orien="R0" />
        <branch name="Channel_2_N">
            <wire x2="2592" y1="1424" y2="1424" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2592" y="1424" name="Channel_2_N" orien="R0" />
        <branch name="Channel_3_P">
            <wire x2="2592" y1="1680" y2="1680" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2592" y="1680" name="Channel_3_P" orien="R0" />
        <branch name="Channel_3_N">
            <wire x2="2592" y1="1936" y2="1936" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2592" y="1936" name="Channel_3_N" orien="R0" />
        <branch name="Sync_P">
            <wire x2="2592" y1="2192" y2="2192" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2592" y="2192" name="Sync_P" orien="R0" />
        <branch name="Sync_N">
            <wire x2="2592" y1="2448" y2="2448" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2592" y="2448" name="Sync_N" orien="R0" />
        <iomarker fontsize="28" x="1072" y="688" name="LVDS_Channel1" orien="R180" />
        <instance x="320" y="768" name="XLXI_213" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="IDELAY_TYPE" x="192" y="-380" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DELAY_SRC" x="223" y="-380" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="IDELAY_VALUE" x="241" y="-380" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DATA_RATE" x="241" y="-380" type="instance" />
        </instance>
        <branch name="XLXN_47">
            <wire x2="768" y1="304" y2="304" x1="704" />
            <wire x2="768" y1="176" y2="304" x1="768" />
            <wire x2="1280" y1="176" y2="176" x1="768" />
        </branch>
        <branch name="LVDS_Channel0">
            <wire x2="320" y1="352" y2="352" x1="288" />
        </branch>
        <iomarker fontsize="28" x="288" y="352" name="LVDS_Channel0" orien="R180" />
        <instance x="416" y="2640" name="XLXI_214" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="IDELAY_TYPE" x="192" y="-380" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DELAY_SRC" x="223" y="-380" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="IDELAY_VALUE" x="241" y="-380" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="DATA_RATE" x="241" y="-380" type="instance" />
        </instance>
        <branch name="XLXN_49">
            <wire x2="1040" y1="2176" y2="2176" x1="800" />
            <wire x2="1040" y1="2176" y2="2224" x1="1040" />
            <wire x2="1296" y1="2224" y2="2224" x1="1040" />
        </branch>
        <branch name="LVDS_Sync">
            <wire x2="416" y1="2224" y2="2224" x1="384" />
        </branch>
        <iomarker fontsize="28" x="384" y="2224" name="LVDS_Sync" orien="R180" />
    </sheet>
</drawing>