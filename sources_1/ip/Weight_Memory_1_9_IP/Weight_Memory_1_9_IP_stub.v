// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Mon Apr 28 15:42:41 2025
// Host        : Zhenya running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/41536/Desktop/ELM_auto/ELM_auto/ELM_auto.srcs/sources_1/ip/Weight_Memory_1_9_IP/Weight_Memory_1_9_IP_stub.v
// Design      : Weight_Memory_1_9_IP
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module Weight_Memory_1_9_IP(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[6:0],douta[11:0]" */;
  input clka;
  input ena;
  input [6:0]addra;
  output [11:0]douta;
endmodule
