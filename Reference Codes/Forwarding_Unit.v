module forwarding_unit(
						input [4:0] EX_MEM_RegisterRd,   //reg_dest_EX_out en el pipeline
						input [4:0] MEM_WB_RegisterRd,   //write_back_address_ID_in en el pipeline
						input MemToReg_EX,             //MemToReg salida del execute
						input EX_MEM_RegWrite,         //RegWrite salida del execute
						input MemToReg_MEM,            
						input MEM_WB_RegWrite,         
						input [4:0] ID_EX_RegisterRs,  
						input [4:0] ID_EX_RegisterRt,  
						output [1:0] ForwardA,          //salida al mux (execute)
						output [1:0] ForwardB           //salida al mux(execute)
						);
 

reg [1:0] auxiliar_1, auxiliar_2;

always@*

begin


//Execution hazard
if(EX_MEM_RegWrite & (EX_MEM_RegisterRd != 0) & (EX_MEM_RegisterRd == ID_EX_RegisterRs))
auxiliar_1 = 2'b10;
if(EX_MEM_RegWrite & (EX_MEM_RegisterRd != 0) & (EX_MEM_RegisterRd == ID_EX_RegisterRt))
auxiliar_2 = 2'b10;

//Memory hazard
 if(MEM_WB_RegWrite & (MEM_WB_RegisterRd != 0) & (EX_MEM_RegisterRd != ID_EX_RegisterRs) & (MEM_WB_RegisterRd == ID_EX_RegisterRs))
	auxiliar_1 = 2'b01;
else
    auxiliar_1 = 2'b00;

if(MEM_WB_RegWrite & (MEM_WB_RegisterRd != 0) & (EX_MEM_RegisterRd != ID_EX_RegisterRt) & (MEM_WB_RegisterRd == ID_EX_RegisterRt))
	auxiliar_2 = 2'b01;
else
	auxiliar_2 = 2'b00;

end
assign ForwardA = auxiliar_1;
assign ForwardB = auxiliar_2;
endmodule