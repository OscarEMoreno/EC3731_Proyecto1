/*
 Original Contributor : Luis Ruiz
 
 Oscar Moreno
 
 
 wbs -> corresponds to wishbone slave
 wbm -> corresponds to wishbone master
*/

module Wishbone(clk_i, rst_i, wbm_dat_i, wbm_sel_i, wbm_adr_i, wbm_we_i, wbm_re_i, wbm_dat_o, wbm_ack_o, wbm_err_o,  
wbs_dat_i, wbs_ack_i, wbs_err_i, wbs_cyc_o, wbs_stb_o, wbs_adr_o, wbs_dat_o, wbs_sel_o, wbs_we_o);

	input wire clk_i;// Common with other stages
	input wire rst_i;
	
	input wire [31:0] wbm_dat_i; // Pipeline Communication
	input wire [3:0] wbm_sel_i;    
	input wire [31:0] wbm_adr_i;
	
	input wire wbm_we_i;
	input wire wbm_re_i;
	
	output reg [31:0] wbm_dat_o;
	output reg wbm_ack_o;
	output reg wbm_err_o;

	
	input wire [31:0] wbs_dat_i; //Memory Communication
	input wire wbs_ack_i;        //Acknowledge
	input wire wbs_err_i;        // Error signal. Named following convention.
	
	output reg wbs_cyc_o;
	output reg wbs_stb_o;
	
	output reg [31:0] wbs_adr_o;
	output reg [31:0] wbs_dat_o;
	output reg [3:0] wbs_sel_o;
	output reg wbs_we_o;
	

	always @(posedge clk_i) begin
		if (rst_i) begin

		end else begin
			if(wbm_we_i) begin
			
				if(wbs_err_i) begin
					wbm_err_o <= wbs_err_i;
				end 
				else 
					if(!wbs_cyc_o && !wbs_stb_o) begin //Make sure there is no Bus Cycle in progress.
								wbm_err_o <= wbs_err_i;
								wbs_adr_o <= wbm_adr_i;
								wbs_dat_o <= wbm_dat_i;
								wbs_we_o <= wbm_we_i;
								wbs_sel_o <= wbm_sel_i;
								wbs_cyc_o <= 1;   //Assert 
								wbs_stb_o <= 1;
						end 
						
					else 
						if(wbs_ack_i) begin
							wbs_cyc_o <= 0;
							wbs_stb_o <= 0;
							end
							
			end 
			else

				if(wbm_re_i) begin
					if(wbs_err_i) begin
						wbm_err_o <= wbs_err_i;
					end 
					else 
					
						if(!wbs_cyc_o && !wbs_stb_o) begin
							wbm_err_o <= wbs_err_i;
							wbs_adr_o <= wbm_adr_i;
							wbs_we_o <= 0;
							wbs_sel_o <= wbm_sel_i;
							wbs_cyc_o <= 1;
							wbs_stb_o <= 1;
						end else 
						
							if(wbs_ack_i && wbs_stb_o) begin
								wbs_stb_o <= 0;
							end else if(wbs_ack_i && !wbs_stb_o) begin
								wbs_cyc_o <= 0;
								wbs_dat_o <= wbm_dat_i;
							end
				end

				end

	end
endmodule