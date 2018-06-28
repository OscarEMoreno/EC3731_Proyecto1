// Autores

// William Chacon
// Oscar   Moreno
// Carlos  Sanoja

module Encoder(clk_in, rst_in, write_in, read_in, except_in, data_out, mtvec_out, mepc_out, mcause_out, mstatus_out, except_flag, EXCPT_PRIO, BussExcp, BussExcp_Flag_i);

    input clk_in;
    input rst_in
	
	//datos de interés de la excepción recibida
    input reg[31:0] except_in;
    input reg[31:0] mtvec_in;
    input reg[31:0] mepc_in;
    input reg[31:0] mcause_in;
    input reg[31:0] mstval_in;
    input write_in;
    input read_in;
	
	//datos de interés de la excepción retornada
    output reg[31:0] mtvec_out;
    output reg[31:0] mtval_out;
    output reg[31:0] mepc_out;
    output reg[31:0] mcause_out;
    output reg[31:0] mstatus_out;
	output except_flag;
	output reg[11:0] EXCPT_PRIO	// estructura de 18 registros de 32 bits
    //output reg[31:0] except_out;
	
	
	//excepciones del Bus
	input reg[0]	BussExcp_Flag_i
	input reg[31:0]	BussExcp
	reg[31:0]		BussExcp_Timer		<=	32'b111100010000000000000
	reg[31:0]		BussExcp_Sftw		<=	32'b111100100000000000000
	reg[31:0]		BussExcp_Xtrn		<=	32'b111101000000000000000
	output reg[0]	BussExcp_Flag_o		
	output reg[31:0]	BussExcp_cause


if (en_except_in != 0)	begin
		
	case (en_except_in) 
        32'b11110000000000001 : 		//1st priority level exception detected
			if (EXCPT_PRIO[11'b000000000001]==11'b0) begin
				EXCPT_PRIO[11'b000000000001][11:0] <=  except_in;
				if(EXCPT_PRIO < 11'b000000000010) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;

			
        32'b1110000000000010 :  		//2nd priority level exception detected
			if (EXCPT_PRIO[11'b000000000010]==11'b0) begin
				EXCPT_PRIO[11'b000000000010][11:0] <=  except_in;
				if(EXCPT_PRIO < 11'b000000000100) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;

			
        32'b1110000000000100 :  		//3rd priority level exception detected
			if (EXCPT_PRIO[11'b000000000100]==11'b0) begin
				EXCPT_PRIO[11'b000000000100][11:0] <=  except_in;
				if(EXCPT_PRIO < 11'b0000000001000) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;

			
        32'b1110000000001000 :  		//4th priority level exception detected
			if (EXCPT_PRIO[11'b000000001000]==11'b0) begin
				EXCPT_PRIO[11'b000000001000][11:0] <=  except_in;
				if(EXCPT_PRIO < 11'b000000010000) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;

			
        32'b1110000000010000 :  		//5th priority level exception detected
			if (EXCPT_PRIO[11'b000000010000]==11'b0) begin
				EXCPT_PRIO[11'b000000010000][11:0] <=  except_in;
				if(EXCPT_PRIO < 11'b0000000100000) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;

			
        32'b1110000000100000 :  		//6th priority level exception detected
			if (EXCPT_PRIO[11'b000000100000]==11'b0) begin
				EXCPT_PRIO[11'b000000100000][11:0] <=  except_in;
				if(EXCPT_PRIO < 11'b0000001000000) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;

			
        32'b1110000001000000 :  		//7th priority level exception detected
			if (EXCPT_PRIO[11'b000001000000]==11'b0) begin
				EXCPT_PRIO[11'b000001000000][11:0] <=  except_in;
				if(EXCPT_PRIO < 11'b000010000000) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;

			
        32'b1110000010000000 :  		//8th priority level exception detected
			if (EXCPT_PRIO[11'b000010000000]==11'b0) begin
				EXCPT_PRIO[11'b000010000000][11:0] <=  except_in;
				if(EXCPT_PRIO < 11'b000100000000) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;

			
        32'b1110000100000000 :  		//9th priority level exception detected
			if (EXCPT_PRIO[11'b000100000000]==11'b0) begin
				EXCPT_PRIO[11'b000100000000][11:0] <=  except_in;
				if(EXCPT_PRIO < 11'b001000000000) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;

			
        32'b1110001000000000 :  		//10th priority level exception detected
			if (EXCPT_PRIO[11'b001000000000]==11'b0) begin
				EXCPT_PRIO[11'b001000000000][11:0] <=  except_in;
				if(EXCPT_PRIO < 11'b010000000000) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;

			
        32'b1110010000000000 :  		//11th priority level exception detected
			if (EXCPT_PRIO[11'b010000000000]==11'b0) begin
				EXCPT_PRIO[11'b010000000000][11:0] <=  except_in;
				if(EXCPT_PRIO < 11'b100000000000) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;

			
        32'b1110010000000000 :  		//12th priority level exception detected
			if (EXCPT_PRIO[11'b100000000000]==11'b0) begin
				EXCPT_PRIO[11'b100000000000][11:0] <=  except_in;
				if(EXCPT_PRIO >= 11'b100000000000) begin
					mtvec_out		<=  mtvec_in;	//se asigna el mtvel de la excepción
					mtval_out		<=	mtval_in;	//se asigna el mtval de la excepción
					mepc_out		<=	mepc_in;	//se asigna el mepc de la excepción
					mcause_out	<=  mcause_in;		//se asigna el mcause de la excepción
					//mstatus_out <=  ;
				end
			end
			break;
			
			
        default:	break;

    endcase;

end


if (BussExcp_Flag_i != 0)	begin //si se recibe una excepción del Buss

	case(BussExcp)
		32'b111100010000000000000:
			BussExcp_Flag_o		<=	1'b1	//se enciende la bandera
			BussExcp_cause	<=	BussExcp_Timer	//se asigna el cause
			break;
			
			
		32'b111100010000000000000:
			BussExcp_Flag_o		<=	1'b1	//se enciende la bandera
			BussExcp_cause		<=	BussExcp_Sftw	//se asigna el cause
			break;
			
		
		32'b111100010000000000000:
			BussExcp_Flag_o		<=	1'b1	//se enciende la bandera
			BussExcp_cause		<=	BussExcp_Xtrn	//se asigna el cause
			break;
		
	endcase;
	
end
