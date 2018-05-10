module MUX(PC_4, PC_branch, Control_PC_Mux, PC_jal, PC_jalr, PC_Exception, MRET,Mux_out);

    input [31:0] PC_4;    //Puertos de entrada.
    input [31:0] PC_branch;
    input [2:0]  Control_PC_Mux;
    input [31:0] PC_jal;
    input [31:0] PC_jalr;
    input [31:0] PC_Exception;
    input [31:0] MRET;
    reg   [31:0] Mux_out;   // Salida
  

  always @(*) // Actualiza con los cambios
    begin
       case(Control_PC_Mux)
		 3'b000: Mux_out = PC_4; 
		 3'b001: Mux_out = PC_branch; 
		 3'b010: Mux_out = Control_PC_Mux; 
		 3'b011: Mux_out = PC_jal; 
		 3'b100: Mux_out = PC_jalr;
		 3'b101: Mux_out = PC_Exception;
		 3'b111: Mux_out = MRET;
		 default:Mux_out = PC_4;
		endcase
    end
   
endmodule // MUX