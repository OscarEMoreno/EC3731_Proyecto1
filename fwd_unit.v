//Forwarding unit

//By 
// Oscar Moreno
// Carlos Sanoja
// Will Chacon

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
						output reg stall
						output reg stall
						);

	always@*
		begin

		//Execution 
		if((rs1 & (EX_rd != 0)) | (rs2 & (EX_rd != 0)))
			if (EX_inst == 01) begin
				fwd_A = 2'b01;   //fwd
				fwd_B = 2'b01;
			end else 
				stall = 1;
				end
		// Memory
		if((rs2 & ( MEM_rd!= 0)) | (rs2 & (MEM_rd != 0)))
			if ( (MEM_inst == 01) || (MEM_inst == 10) ) begin
	       //Se realiza  forwarding
	            fwd_A = 2'b10;
	            fwd_B = 2'b10;
	       end else 
				stall = 1;
				end
		else 
				stall = 1;
        end 
		
		//WB
		if((rs2 & ( WB_rd!= 0)) | (rs2 & (WB_rd != 0)))
			if ( (WB_inst == 01) || (WB_inst == 10) || (WB_inst == 11) ) begin
			
				fwd_A = 2'b11;
	            fwd_B = 2'b11;
			end
		end
	

endmodule



