module ALU ( operand_1, operand_2, ALU_control, resultado);
 	input  [31:0] operand_1,  //operandos
    input  [31:0] operand_2,  
    input [2:0] ALU_control, //Control de operaciones (Inicialmente 3 bits)
    output [31:0] resultado,  
	
  
always @( operand_1 or operand_2 or ALU_control) begin 
 case(ALU_control)
	 3'b000: resultado = operand_1 + operand_2; // add
	 3'b001: resultado = operand_1 - operand_2; // sub
	 3'b010: resultado = ~operand_1; // not
	 3'b011: resultado = operand_1 << operand_2; // logical shift left 
	 3'b100: resultado = operand_1 >> operand_2; // logical shift right 
	 3'b101: resultado = operand_1 & operand_2; // and
	 3'b110: resultado = operand_1 | operand_2; // or
	 3'b111: resultado = 32'd1;
	 default:resultado = 32'd0;
 endcase
 
end  
endmodule //ALU
