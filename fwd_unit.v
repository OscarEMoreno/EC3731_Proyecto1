//Forwarding unit
// Oscar Moreno 1410718

module fwd_unit(
						input [4:0] EX_rd,
						input [4:0] MEM_rd,  
						input [4:0] WB_rd, 
						input [1:0] EX_inst,  
						input [1:0] MEM_inst,
						input [1:0] WB_inst,
						input [1:0] rs1,			 //register source 
						input [1:0] rs2,
						output [1:0] fwd_A,          // Output 1 (Mux control signal)
						output [1:0] fwd_B           // Output 2 (Mux control signal)
						);
 
	reg [1:0] aux_1, aux_2;
	
	always@*
		begin

		//Execution 
		
		if((rs1 & (EX_rd != 0)) | (rs2 & (EX_rd != 0)))
			aux_1 = 2'b01;   //fwd
			EX_inst = 2'b01;
			
		else 
		// Memory
		if((rs2 & ( MEM_rd!= 0)) | (rs2 & (MEM_rd != 0)))
			aux_1 = 2'b01;   
			MEM_inst = 2'b01;
			aux_2 = 2'b10;

			//WB
		if((rs2 & ( WB_rd!= 0)) | (rs2 & (WB_rd != 0)))
			aux_1 = 2'b01;  
			WB_inst = 2'b01;
			aux_2 = 2'b10;
			
		else 
			WB_inst = 2'b01;
			aux_2 = 2'b11;
		end
	
	assign fwd_A = aux_1;
	assign fwd_B = aux_2;
endmodule











//input EX_MEM_RegWrite,         
	//					input MemToReg_MEM,            
		//				input MEM_WB_RegWrite,         
			//			input [4:0] ID_EX_RegisterRs,  
				//		input [4:0] ID_EX_RegisterRt, 