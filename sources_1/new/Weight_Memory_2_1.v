`timescale 1ns / 1ps
`include "include.v"

module Weight_Memory_2_1 #(
    parameter neuronNo=1,
    parameter layerNo=2,
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
        Weight_Memory_2_1_IP bram_inst (
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
            $readmemb("weight_mem_2_1.mif", mem);
        end
        always @(posedge clk) begin
            if (ren)
                wouta <= mem[raddr];
        end
        assign wout = wouta;
    `endif

endmodule
