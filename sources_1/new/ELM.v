//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2019 20:57:54
// Design Name: 
// Module Name: top_layer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "include.v"

module ELM #(
    parameter integer C_S_AXI_DATA_WIDTH    = 32,
    parameter integer C_S_AXI_ADDR_WIDTH    = 5
)
(
    //Clock and Reset
    input                                   s_axi_aclk,
    input                                   s_axi_aresetn,
    //AXI Stream interface
    input [`dataWidth-1:0]                  axis_in_data,
    input                                   axis_in_data_valid,
    
    output                                  axis_in_data_ready,
    output [`numNeuronLayer2*`dataWidth-1:0] x2_out
);


assign axis_in_data_ready = 1'b1;

wire reset;

assign reset = ~s_axi_aresetn;

localparam IDLE = 'd0,
           SEND = 'd1;
           
wire [`numNeuronLayer1-1:0] o1_valid;
wire [`numNeuronLayer1*`dataWidth-1:0] x1_out;
reg [`numNeuronLayer1*`dataWidth-1:0] holdData_1;
reg [`dataWidth-1:0] out_data_1;
reg data_out_valid_1;

wire [31:0]  config_layer_num;
wire [31:0]  config_neuron_num;
wire [31:0] weightValue;
wire [31:0] biasValue;


Layer_1 #(.layerNum(1), .numNeuronLayer(50), .actType(`Layer1ActType)) l1(
	.clk(s_axi_aclk),
	.rst(reset),
	.weightValid(axis_in_data_valid),
	.biasValid(axis_in_data_valid),
	.weightValue(weightValue),
	.biasValue(biasValue),
	.config_layer_num(config_layer_num),
	.config_neuron_num(config_neuron_num),
	.x_valid(axis_in_data_valid),
	.x_in(axis_in_data),
	.o_valid(o1_valid),
	.x_out(x1_out)
);

//State machine for data pipelining
reg       state_1;
integer   count_1;
always @(posedge s_axi_aclk)
begin
    if(reset)
    begin
        state_1 <= IDLE;
        count_1 <= 0;
        data_out_valid_1 <=0;
    end
    else
    begin
        case(state_1)
            IDLE: begin
                count_1 <= 0;
                data_out_valid_1 <=0;
                if (o1_valid[0] == 1'b1)
                begin
                    holdData_1 <= x1_out;
                    state_1 <= SEND;
                end
            end
            SEND: begin
                out_data_1 <= holdData_1[`dataWidth-1:0];
                holdData_1 <= holdData_1>>`dataWidth;
                count_1 <= count_1 +1;
                data_out_valid_1 <= 1;
                if (count_1 == `numNeuronLayer1)
                begin
                    state_1 <= IDLE;
                    data_out_valid_1 <= 0;
                end
            end
        endcase
    end
end

wire [`numNeuronLayer2-1:0] o2_valid;
reg [`numNeuronLayer2*`dataWidth-1:0] holdData_2;
reg [`dataWidth-1:0] out_data_2;
reg data_out_valid_2;

Layer_2 #(.layerNum(2),.numNeuronLayer(2),.actType(`Layer2ActType)) l2(
	.clk(s_axi_aclk),
	.rst(reset),
	.weightValid(axis_in_data_valid),
	.biasValid(axis_in_data_valid),
	.weightValue(weightValue),
	.biasValue(biasValue),
	.config_layer_num(config_layer_num),
	.config_neuron_num(config_neuron_num),
	.x_valid(data_out_valid_1),
	.x_in(out_data_1),
	.o_valid(o2_valid),
	.x_out(x2_out)
);




endmodule
