`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/21 10:35:37
// Design Name: 
// Module Name: PipeLine_Adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "_parameter.v"

module PipeLine_Adder(
	input    	wire     					CLK,
	input 		wire 						RST_N,

	output      wire 						read_en,
	output      wire [31:0] 				read_addr,
	input       wire [`DATA_WIDTH - 1 : 0] 	m0,
	input  		wire [`DATA_WIDTH - 1 : 0] 	m1,

	input       wire 						add_start,

	output      wire 						result_valid,
	output      wire  [31:0] 				result_addr,
	output      wire  [`DATA_WIDTH - 1 : 0] result,

	output      wire 						add_complete,
	input       wire [31	:0]				two_times_len_1
    
    );	
	
	parameter IDEL 		= 6'd0;
	parameter ADD_CAL   = 6'd1;
	parameter CHECK 	= 6'd3;
	parameter COMPLETE  = 6'd4;

	reg 	[`TOTAL_BITS*2:0] 	add1;
	reg 	[`TOTAL_BITS*2:0] 	add2;

	wire 	[31:0]  			add1_32bit;
	wire 	[31:0]  			add2_32bit;
	reg 	[31:0] 				inter_result;
	reg    						C;

	reg [5:0] state;
	reg       Cal_En, Cal_En_Reg,Cal_En_Reg_Reg;
	reg [31:0] Count, Count_Reg,Count_Reg_Reg;

	assign add_complete = state == COMPLETE;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			state <= IDEL;
			Cal_En <= 0;
		end
		else begin
			case(state)
				IDEL:begin
					if(add_start)begin
						
						state <= ADD_CAL;
						Cal_En <= 1;
					end
				end

				ADD_CAL:begin
					if(Count == (two_times_len_1 + 1)<<1)begin
						state <= CHECK;
						Cal_En <= 0;
					end
				end

				CHECK:begin
					state <= COMPLETE;
				end

				COMPLETE:begin
					state <= IDEL;
				end

			endcase
		end
	end

	always@(posedge CLK or negedge RST_N)begin
		if(~RST_N)begin
			inter_result <= 0;
			C <= 0;
		end
		else if(add_start)begin
			inter_result <= 0;
			C <= 0;
		end
		else if(Cal_En_Reg)begin
			{C,inter_result} <= m0 + m1 + C;
		end
	end

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Cal_En_Reg <= 0;
			Cal_En_Reg_Reg <= 0;
		end
		else begin
			Cal_En_Reg <= Cal_En;
			Cal_En_Reg_Reg <= Cal_En_Reg;
		end
	end

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Count <= 0;
		end
		else if(Cal_En)begin
			Count <= Count + 1;
		end
		else begin
			Count <= 0;
		end
	end

	assign read_en = Cal_En;
	assign read_addr = Count;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Count_Reg <= 0;
			Count_Reg_Reg <= 0;
		end
		else begin
			Count_Reg <= Count;
			Count_Reg_Reg <= Count_Reg;
		end
	end

	assign result_addr = Count_Reg_Reg;
	assign result_valid = Cal_En_Reg_Reg;
	assign result       = inter_result;


endmodule
