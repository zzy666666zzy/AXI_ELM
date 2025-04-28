import os

# ======== USER CONFIGURABLE ========
layer_idx = 1          # Number of layers
neurons= 50     # Number of neurons per layer
output_dir = "../"
# ====================================

os.makedirs(output_dir, exist_ok=True)

# -----------------------
# Templates (escaped properly)
# -----------------------

# Template for each neuron file
neuron_template = """\
`timescale 1ns / 1ps
`include "include.v"

module neuron_{layer}_{neuron} #(parameter layerNo={layer}, neuronNo={neuron}, numWeight=128, actType="sigmoid_LU")(
    input clk,
    input rst,
    input myinputValid,
    input weightValid,
    input biasValid,
    input [`dataWidth-1:0] myinput,
    input [`dataWidth-1:0] weightValue,
    input [`dataWidth-1:0] biasValue,
    input [2*`dataWidth:0] config_layer_num,
    input [2*`dataWidth:0] config_neuron_num,
    output [`ROM_bitwidth-1:0] out,
    output reg outvalid
);

    parameter addressWidth = $clog2(numWeight);

    reg wen;
    wire ren;
    reg [addressWidth-1:0] w_addr;
    reg [addressWidth:0] r_addr;
    reg [`dataWidth-1:0] w_in;
    wire [`dataWidth-1:0] w_out;
    reg [2*`dataWidth-1:0] mul; 
    reg [2*`dataWidth-1:0] sum;
    reg [2*`dataWidth-1:0] bias;
    reg [2*`dataWidth-1:0] biasReg[0:0];
    reg weight_valid;
    reg mult_valid;
    wire mux_valid;
    reg sigValid;
    wire [2*`dataWidth-1:0] comboAdd;
    wire [2*`dataWidth-1:0] BiasAdd;
    reg [`dataWidth-1:0] myinputd;
    reg muxValid_d;
    reg muxValid_f;
    reg addr = 0;

    assign mux_valid = mult_valid;
    assign comboAdd = mul + sum;
    assign BiasAdd = bias + sum;
    assign ren = myinputValid;

    always @(posedge clk) begin
        if(rst) begin
            w_addr <= {{addressWidth{{1'b1}}}};
            wen <= 0;
        end
        else if(weightValid & (config_layer_num == layerNo) & (config_neuron_num == neuronNo)) begin
            w_in <= weightValue;
            w_addr <= w_addr + 1;
            wen <= 1;
        end
        else
            wen <= 0;
    end

    `ifdef pretrained
        initial begin
            $readmemb(biasFile, biasReg);
        end
        always @(posedge clk) begin
            bias <= {{biasReg[addr][`dataWidth-1:0],{{`fracWidth{{1'b0}}}}}};
        end
    `else
        always @(posedge clk) begin
            if(biasValid)
                bias <= $signed(biasValue) <<< `fracWidth;
        end
    `endif

    always @(posedge clk) begin
        if(rst | outvalid)
            r_addr <= 0;
        else if(myinputValid)
            r_addr <= r_addr + 1;
    end

    always @(posedge clk) begin
        mul <= $signed(myinputd) * $signed(w_out);
    end

    always @(posedge clk) begin
        if(rst | outvalid)
            sum <= 0;
        else if((r_addr == numWeight) & muxValid_f)
            sum <= BiasAdd;
        else if(mux_valid)
            sum <= comboAdd;
    end

    always @(posedge clk) begin
        myinputd <= myinput;
        weight_valid <= myinputValid;
        mult_valid <= weight_valid;
        sigValid <= ((r_addr == numWeight) & muxValid_f) ? 1'b1 : 1'b0;
        outvalid <= sigValid;
        muxValid_d <= mux_valid;
        muxValid_f <= !mux_valid & muxValid_d;
    end

    Weight_Memory_{layer}_{neuron} #(
        .neuronNo(neuronNo),
        .layerNo(layerNo),
        .addressWidth(addressWidth),
        .dataWidth(`dataWidth)
    ) weight_memory_inst (
        .clk(clk),
        .ren(ren),
        .wen(wen),
        .raddr(r_addr),
        .wout(w_out)
    );

	    wire [`dataWidth-1:0] out_sigmoid_normal, out_sigmoid_LU;
    
    generate
        if(actType == "two_sigmoid")
        begin:two_sigm
        //Instantiation of ROM for sigmoid
            Sig_ROM #(.inWidth(`sigmoidSize),.dataWidth(`dataWidth)) sigmoid_normal(
            .clk(clk),
            .sign_flag(sum[2*`dataWidth-1]),
            //truncate input data width, if sum is 32-bit, RAM entries are 2^32, not practical,
            //so truncate it to reduce RAM entries
            .x(sum[2*`dataWidth-1-`weightIntWidth-:`sigmoidSize]), //bit width truncate after mul
            .out(out_sigmoid_normal)
        );
            Sig_LU_ROM_HALF #(.inWidth(`sigmoidSize),.dataWidth(`dataWidth)) sigmoid_LU(
            .clk(clk),
            .sign_flag(sum[2*`dataWidth-1]),
            .x(sum[2*`dataWidth-1-`weightIntWidth-:`sigmoidSize]), //bit width truncate after mul
            .out(out_sigmoid_LU)
            );
        end
        
        else if (actType == "sigmoid_nor")
        begin
            //Instantiation of ROM for sigmoid
            Sig_ROM #(.inWidth(`sigmoidSize),.dataWidth(`dataWidth)) sigmoid_normal(
            .clk(clk),
            .sign_flag(sum[2*`dataWidth-1]),
            //truncate input data width, if sum is 32-bit, RAM entries are 2^32, not practical,
            //so truncate it to reduce RAM entries
            .x(sum[2*`dataWidth-1-`weightIntWidth-:`sigmoidSize]),
            .out(out_sigmoid_normal)
        );
        end
        
        else if (actType == "sigmoid_LU")
        begin: LU_sigm
            Sig_LU_ROM_HALF #(.inWidth(`sigmoidSize),.dataWidth(`dataWidth)) sigmoid_LU(
            .clk(clk),
            .sign_flag(sum[2*`dataWidth-1]),
            .x(sum[2*`dataWidth-1-`weightIntWidth-:`sigmoidSize]),
            .out(out_sigmoid_LU)
            );
        end
        
        else if (actType == "sigmoid_LU_half")
        begin: LU_sigm_half
            Sig_LU_ROM_HALF #(.inWidth(`sigmoidSize),.dataWidth(`dataWidth)) sigmoid_LU_half(
            .clk(clk),
            .sign_flag(sum[2*`dataWidth-1]),
            .x(sum[2*`dataWidth-1-`weightIntWidth-:`sigmoidSize]),
            .out(out_sigmoid_LU)
            );
        end
        
        else if (actType == "relu")
        begin:ReLUinst
            ReLU #(.dataWidth(`dataWidth),.weightIntWidth(`weightIntWidth)) relu (
            .clk(clk),
            .x(sum),
            .out(out)
        );
        end
        else
        begin:dummy
            dummy_activation da (
            .sum(sum),
            .out(out)
        );
        end
    endgenerate
    
    assign out = (actType == "sigmoid_LU") ? out_sigmoid_LU : out_sigmoid_normal;

    `ifdef DEBUG
    always @(posedge clk)
    begin
        if(outvalid)
            $display(neuronNo,,,,"%b",out);
    end
    `endif

endmodule
"""

# Template for each weight memory
weight_memory_template = """\
`timescale 1ns / 1ps
`include "include.v"

module Weight_Memory_{layer}_{neuron} #(
    parameter neuronNo={neuron},
    parameter layerNo={layer},
    parameter addressWidth=10,
    parameter dataWidth=16
) (
    input clk,
    input ren,
    input wen,
    input [addressWidth:0] raddr,
    output wire [dataWidth-1:0] wout
);

    `ifdef synthesis
        wire [dataWidth-1:0] wouta;
        Weight_Memory_{layer}_{neuron}_IP bram_inst (
            .clka(clk),
            .addra(raddr),
            .douta(wouta),
			.ena('b1)
        );
        assign wout = wouta;
    `elsif simulation
        reg [dataWidth-1:0] wouta;
        (* ram_style = "block" *) reg [dataWidth-1:0] mem [2**addressWidth-1:0];
        initial begin
            $readmemb("weight_mem_{layer}_{neuron}.mif", mem);
        end
        always @(posedge clk) begin
            if (ren)
                wouta <= mem[raddr];
        end
        assign wout = wouta;
    `endif

endmodule
"""

# Template for Layer_x.v
layer_header_template = """\
`timescale 1ns / 1ps
`include "include.v"

module Layer_{layer} #(parameter layerNum = {layer}, numNeuronLayer = {neurons}, actType = "relu")(
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
"""

layer_footer_template = "endmodule\n"

# -----------------------
# Start Generating
# -----------------------

layer_content = layer_header_template.format(layer=layer_idx, neurons=neurons)

for n in range(neurons):
	neuron_filename = f"{output_dir}/neuron_{layer_idx}_{n}.v"
	weight_filename = f"{output_dir}/Weight_Memory_{layer_idx}_{n}.v"

	# Write neuron
	with open(neuron_filename, 'w') as f:
		f.write(neuron_template.format(layer=layer_idx, neuron=n))

	# Write weight memory
	with open(weight_filename, 'w') as f:
		f.write(weight_memory_template.format(layer=layer_idx, neuron=n))

	# Append neuron instantiation into Layer
	layer_content += f"""
neuron_{layer_idx}_{n} #(
	.numWeight(`numWeightLayer{layer_idx}),
	.layerNo(layerNum),
	.neuronNo({n}),
	.actType(actType)
) n_{layer_idx}_{n} (
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
	.out(x_out[{n}*`dataWidth +: `dataWidth]),
	.outvalid(o_valid[{n}])
);
"""


# Save the Layer file
with open(f"{output_dir}/Layer_{layer_idx}.v", 'w') as f:
	f.write(layer_content + layer_footer_template)

print(f"✅ Successfully generated {neurons} neurons and weights for {layer_idx} layers!")
