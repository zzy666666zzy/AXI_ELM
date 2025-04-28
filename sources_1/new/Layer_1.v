`timescale 1ns / 1ps
`include "include.v"

module Layer_1 #(parameter layerNum = 1, numNeuronLayer = 50, actType = "relu")(
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

neuron_1_0 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(0),
	.actType(actType)
) n_1_0 (
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

neuron_1_1 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(1),
	.actType(actType)
) n_1_1 (
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

neuron_1_2 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(2),
	.actType(actType)
) n_1_2 (
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
	.out(x_out[2*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[2])
);

neuron_1_3 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(3),
	.actType(actType)
) n_1_3 (
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
	.out(x_out[3*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[3])
);

neuron_1_4 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(4),
	.actType(actType)
) n_1_4 (
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
	.out(x_out[4*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[4])
);

neuron_1_5 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(5),
	.actType(actType)
) n_1_5 (
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
	.out(x_out[5*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[5])
);

neuron_1_6 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(6),
	.actType(actType)
) n_1_6 (
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
	.out(x_out[6*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[6])
);

neuron_1_7 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(7),
	.actType(actType)
) n_1_7 (
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
	.out(x_out[7*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[7])
);

neuron_1_8 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(8),
	.actType(actType)
) n_1_8 (
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
	.out(x_out[8*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[8])
);

neuron_1_9 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(9),
	.actType(actType)
) n_1_9 (
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
	.out(x_out[9*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[9])
);

neuron_1_10 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(10),
	.actType(actType)
) n_1_10 (
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
	.out(x_out[10*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[10])
);

neuron_1_11 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(11),
	.actType(actType)
) n_1_11 (
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
	.out(x_out[11*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[11])
);

neuron_1_12 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(12),
	.actType(actType)
) n_1_12 (
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
	.out(x_out[12*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[12])
);

neuron_1_13 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(13),
	.actType(actType)
) n_1_13 (
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
	.out(x_out[13*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[13])
);

neuron_1_14 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(14),
	.actType(actType)
) n_1_14 (
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
	.out(x_out[14*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[14])
);

neuron_1_15 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(15),
	.actType(actType)
) n_1_15 (
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
	.out(x_out[15*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[15])
);

neuron_1_16 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(16),
	.actType(actType)
) n_1_16 (
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
	.out(x_out[16*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[16])
);

neuron_1_17 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(17),
	.actType(actType)
) n_1_17 (
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
	.out(x_out[17*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[17])
);

neuron_1_18 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(18),
	.actType(actType)
) n_1_18 (
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
	.out(x_out[18*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[18])
);

neuron_1_19 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(19),
	.actType(actType)
) n_1_19 (
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
	.out(x_out[19*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[19])
);

neuron_1_20 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(20),
	.actType(actType)
) n_1_20 (
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
	.out(x_out[20*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[20])
);

neuron_1_21 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(21),
	.actType(actType)
) n_1_21 (
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
	.out(x_out[21*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[21])
);

neuron_1_22 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(22),
	.actType(actType)
) n_1_22 (
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
	.out(x_out[22*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[22])
);

neuron_1_23 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(23),
	.actType(actType)
) n_1_23 (
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
	.out(x_out[23*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[23])
);

neuron_1_24 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(24),
	.actType(actType)
) n_1_24 (
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
	.out(x_out[24*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[24])
);

neuron_1_25 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(25),
	.actType(actType)
) n_1_25 (
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
	.out(x_out[25*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[25])
);

neuron_1_26 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(26),
	.actType(actType)
) n_1_26 (
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
	.out(x_out[26*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[26])
);

neuron_1_27 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(27),
	.actType(actType)
) n_1_27 (
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
	.out(x_out[27*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[27])
);

neuron_1_28 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(28),
	.actType(actType)
) n_1_28 (
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
	.out(x_out[28*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[28])
);

neuron_1_29 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(29),
	.actType(actType)
) n_1_29 (
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
	.out(x_out[29*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[29])
);

neuron_1_30 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(30),
	.actType(actType)
) n_1_30 (
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
	.out(x_out[30*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[30])
);

neuron_1_31 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(31),
	.actType(actType)
) n_1_31 (
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
	.out(x_out[31*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[31])
);

neuron_1_32 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(32),
	.actType(actType)
) n_1_32 (
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
	.out(x_out[32*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[32])
);

neuron_1_33 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(33),
	.actType(actType)
) n_1_33 (
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
	.out(x_out[33*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[33])
);

neuron_1_34 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(34),
	.actType(actType)
) n_1_34 (
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
	.out(x_out[34*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[34])
);

neuron_1_35 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(35),
	.actType(actType)
) n_1_35 (
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
	.out(x_out[35*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[35])
);

neuron_1_36 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(36),
	.actType(actType)
) n_1_36 (
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
	.out(x_out[36*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[36])
);

neuron_1_37 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(37),
	.actType(actType)
) n_1_37 (
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
	.out(x_out[37*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[37])
);

neuron_1_38 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(38),
	.actType(actType)
) n_1_38 (
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
	.out(x_out[38*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[38])
);

neuron_1_39 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(39),
	.actType(actType)
) n_1_39 (
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
	.out(x_out[39*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[39])
);

neuron_1_40 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(40),
	.actType(actType)
) n_1_40 (
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
	.out(x_out[40*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[40])
);

neuron_1_41 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(41),
	.actType(actType)
) n_1_41 (
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
	.out(x_out[41*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[41])
);

neuron_1_42 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(42),
	.actType(actType)
) n_1_42 (
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
	.out(x_out[42*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[42])
);

neuron_1_43 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(43),
	.actType(actType)
) n_1_43 (
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
	.out(x_out[43*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[43])
);

neuron_1_44 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(44),
	.actType(actType)
) n_1_44 (
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
	.out(x_out[44*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[44])
);

neuron_1_45 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(45),
	.actType(actType)
) n_1_45 (
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
	.out(x_out[45*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[45])
);

neuron_1_46 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(46),
	.actType(actType)
) n_1_46 (
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
	.out(x_out[46*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[46])
);

neuron_1_47 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(47),
	.actType(actType)
) n_1_47 (
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
	.out(x_out[47*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[47])
);

neuron_1_48 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(48),
	.actType(actType)
) n_1_48 (
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
	.out(x_out[48*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[48])
);

neuron_1_49 #(
	.numWeight(`numWeightLayer1),
	.layerNo(layerNum),
	.neuronNo(49),
	.actType(actType)
) n_1_49 (
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
	.out(x_out[49*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[49])
);
endmodule
