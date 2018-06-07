`timescale 1ns / 1ps
// Taken from https://github.com/lucaslt89/pipeline_vFiles/blob/master/test_instruction_fetch.v
module instruction_decode(
    input [31:0] instruction,
    input [10:0] current_pc,
    input [31:0] write_back_data,
	 input [4:0] write_back_address,
	 input RegWrite,
	 input clock,
	 input stall_mux,
	 
    output [10:0] jump_dest_addr,
    output [31:0] data_a,
    output [31:0] data_b,
	 output [31:0] sign_extended,
	 output [4:0] reg_dest_r_type,//rd
	 output [4:0] reg_dest_l_type,//rt
	 output [4:0] reg_dest_s_type,//rs
	 output [4:0] sa, //sa
	 //Control Signals Output
	 output RegDst_out,
	 output ALUSrc_out,
	 output MemToReg_out,
	 output RegWrite_out,
	 output MemRead_out,
	 output MemWrite_out,
	 output Branch_out,
	 output [1:0] ALUOp_out,
	 
	 
	 //Registers to UART
	 output [31:0] register_0_id_out,
	 output [31:0] register_1_id_out,
	 output [31:0] register_2_id_out,
	 output [31:0] register_3_id_out,
	 output [31:0] register_4_id_out,
	 output [31:0] register_5_id_out,
	 output [31:0] register_6_id_out,
	 output [31:0] register_7_id_out,
	 output [31:0] register_8_id_out,
	 output [31:0] register_9_id_out,
	 output [31:0] register_10_id_out,
	 output [31:0] register_11_id_out,
	 output [31:0] register_12_id_out,
	 output [31:0] register_13_id_out,
	 output [31:0] register_14_id_out,
	 output [31:0] register_15_id_out,
	 output [31:0] register_16_id_out,
	 output [31:0] register_17_id_out,
	 output [31:0] register_18_id_out,
	 output [31:0] register_19_id_out,
	 output [31:0] register_20_id_out,
	 output [31:0] register_21_id_out,
	 output [31:0] register_22_id_out,
	 output [31:0] register_23_id_out,
	 output [31:0] register_24_id_out,
    output [31:0] register_25_id_out,
	 output [31:0] register_26_id_out,
	 output [31:0] register_27_id_out,
	 output [31:0] register_28_id_out,
	 output [31:0] register_29_id_out,
	 output [31:0] register_30_id_out,
	 output [31:0] register_31_id_out
    );
	 
	 //registers wires
	 wire [31:0] reg_data_a;
	 wire [31:0] reg_data_b;
	 
	 //sign extension wires
	 wire [31:0] sign_extended_value;
	 wire [31:0] sign_extended_value_shifted;
	 
	 //jump
	 wire [10:0] jump_dest_addr_aux;
	 
	 //Control Signals Input
	 wire RegDst_in;
	 wire ALUSrc_in;
	 wire MemToReg_in;
	 wire RegWrite_in;
	 wire MemRead_in;
	 wire MemWrite_in;
	 wire Branch_in;
	 wire [1:0] ALUOp_in;
	 
	 control_mux u_control_mux (
		 .op_code(instruction[31:26]),
		 .formato(instruction[5:0]),
		 .stall_mux(stall_mux),
		 .RegDst_out(RegDst_in), 
		 .ALUSrc_out(ALUSrc_in), 
		 .MemToReg_out(MemToReg_in), 
		 .RegWrite_out(RegWrite_in), 
		 .MemRead_out(MemRead_in), 
		 .MemWrite_out(MemWrite_in), 
		 .Branch_out(Branch_in), 
		 .ALUOp_out(ALUOp_in)
    );
	 
	 registers u_registers (
		 .read_addr_a(instruction[25:21]), 
		 .read_addr_b(instruction[20:16]),
		 .write_address(write_back_address),
		 .write_data(write_back_data), 
		 .reg_write(RegWrite),
		 .clock(clock),
		 .data_a(reg_data_a),
		 .data_b(reg_data_b),
		 .register_0_id_out(register_0_id_out), 
		 .register_1_id_out(register_1_id_out), 
		 .register_2_id_out(register_2_id_out), 
		 .register_3_id_out(register_3_id_out), 
		 .register_4_id_out(register_4_id_out), 
		 .register_5_id_out(register_5_id_out), 
		 .register_6_id_out(register_6_id_out), 
		 .register_7_id_out(register_7_id_out), 
		 .register_8_id_out(register_8_id_out), 
		 .register_9_id_out(register_9_id_out), 
		 .register_10_id_out(register_10_id_out), 
		 .register_11_id_out(register_11_id_out), 
		 .register_12_id_out(register_12_id_out), 
		 .register_13_id_out(register_13_id_out), 
		 .register_14_id_out(register_14_id_out), 
		 .register_15_id_out(register_15_id_out), 
		 .register_16_id_out(register_16_id_out), 
		 .register_17_id_out(register_17_id_out), 
		 .register_18_id_out(register_18_id_out), 
		 .register_19_id_out(register_19_id_out), 
		 .register_20_id_out(register_20_id_out), 
		 .register_21_id_out(register_21_id_out), 
		 .register_22_id_out(register_22_id_out), 
		 .register_23_id_out(register_23_id_out), 
		 .register_24_id_out(register_24_id_out), 
		 .register_25_id_out(register_25_id_out), 
		 .register_26_id_out(register_26_id_out), 
		 .register_27_id_out(register_27_id_out), 
		 .register_28_id_out(register_28_id_out), 
		 .register_29_id_out(register_29_id_out), 
		 .register_30_id_out(register_30_id_out), 
		 .register_31_id_out(register_31_id_out)
    );
	 
	 sign_extend u_sign_extend(
		.immediate(instruction[15:0]),
		.sign_extended(sign_extended_value)
    );
	 
	 sign_extend_shift u_sign_extend_shift(
		.sign_extend(sign_extended_value),
		.sign_extend_shifted(sign_extended_value_shifted)
    );
	 
	 adder u_dest_addr_adder(
		 .old_pc(current_pc),
		 .offset(sign_extended_value_shifted),
		 .new_pc(jump_dest_addr_aux)
    );
	 
	 id_ex u_id_ex_register(
		 .data_a_in(reg_data_a),
		 .data_b_in(reg_data_b),
		 .sign_extend_in(sign_extended_value),
		 .jump_dest_in(jump_dest_addr_aux),
		 .reg_dest_r_type_in(instruction[15:11]),//rd
		 .reg_dest_l_type_in(instruction[20:16]),//rt
		 .reg_dest_s_type_in(instruction[25:21]),//rs
		 .sa_in(instruction[10:6]),
		 .clock(clock),
		 .data_a_out(data_a),
		 .data_b_out(data_b),
		 .sign_extend_out(sign_extended),
		 .jump_dest_out(jump_dest_addr),
		 .reg_dest_r_type_out(reg_dest_r_type),//rd
		 .reg_dest_l_type_out(reg_dest_l_type),//rt
		 .reg_dest_s_type_out(reg_dest_s_type),//rs
		 .sa_out(sa),
		  //Control Signals Input
		 .RegDst_in(RegDst_in), 
		 .ALUSrc_in(ALUSrc_in), 
		 .MemToReg_in(MemToReg_in), 
		 .RegWrite_in(RegWrite_in), 
		 .MemRead_in(MemRead_in), 
		 .MemWrite_in(MemWrite_in), 
		 .Branch_in(Branch_in), 
		 .ALUOp_in(ALUOp_in), 
		  //Control Signals Output
		 .RegDst_out(RegDst_out), 
		 .ALUSrc_out(ALUSrc_out), 
		 .MemToReg_out(MemToReg_out), 
		 .RegWrite_out(RegWrite_out), 
		 .MemRead_out(MemRead_out), 
		 .MemWrite_out(MemWrite_out), 
		 .Branch_out(Branch_out), 
		 .ALUOp_out(ALUOp_out)
    );

endmodule