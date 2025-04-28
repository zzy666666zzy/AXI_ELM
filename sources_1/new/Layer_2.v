`timescale 1ns / 1ps
`include "include.v"

module Layer_2 #(parameter layerNum = 2, numNeuronLayer = 2, actType = "relu")(
    input clk,
    input rst,
    input weightValid,
    input biasValid,
    input [`dataWidth-1:0] weightValue,
    input [`dataWidth-1:0] biasValue,
    input [`dataWidth-1:0] config_layer_num,
    input [`dataWidth-1:0] config_neuron_num,
    input x_valid,
    input [`dataWidth-1:0] x_in,
    output [numNeuronLayer-1:0] o_valid,
    output [numNeuronLayer*`dataWidth-1:0] x_out
);

neuron_2_0 #(
	.numWeight(`numWeightLayer2),
	.layerNo(layerNum),
	.neuronNo(0),
	.actType(actType)
) n_2_0 (
	.clk(clk),
	.rst(rst),
	.myinput(x_in),
	.weightValid(weightValid),
	.biasValid(biasValid),
	.weightValue(weightValue),
	.biasValue(biasValue),
	.config_layer_num(config_layer_num),
	.config_neuron_num(config_neuron_num),
	.myinputValid(x_valid),
	.out(x_out[0*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[0])
);

neuron_2_1 #(
	.numWeight(`numWeightLayer2),
	.layerNo(layerNum),
	.neuronNo(1),
	.actType(actType)
) n_2_1 (
	.clk(clk),
	.rst(rst),
	.myinput(x_in),
	.weightValid(weightValid),
	.biasValid(biasValid),
	.weightValue(weightValue),
	.biasValue(biasValue),
	.config_layer_num(config_layer_num),
	.config_neuron_num(config_neuron_num),
	.myinputValid(x_valid),
	.out(x_out[1*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[1])
);
endmodule
