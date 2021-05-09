// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Sat May  8 18:50:53 2021
// Host        : LAPTOP-5IS28MMD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/jimen/Documents/Tec/6to Semestre/Lab de
//               Sistemas/Scanner3D/Scanner3D.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v}
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk25, reset, locked, clk)
/* synthesis syn_black_box black_box_pad_pin="clk25,reset,locked,clk" */;
  output clk25;
  input reset;
  output locked;
  input clk;
endmodule
