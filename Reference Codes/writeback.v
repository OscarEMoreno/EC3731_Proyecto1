`timescale 1ns / 1ps
//taken from https://github.com/lucaslt89/pipeline_vFiles/blob/master/write_back.v
module write_back(
    input MemToReg,
    input [31:0] mem_data,
    input [31:0] ex_data,
    output [31:0] wb_out
    );

	reg [31:0] aux = 0;
	 
	always @(*)
	begin
		case (MemToReg)
		0:
			aux = ex_data;
		1:
			aux = mem_data;		
		endcase
	end

	assign wb_out = aux;

endmodule