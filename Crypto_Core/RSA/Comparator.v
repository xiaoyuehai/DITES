`include "_parameter.v"
module Comparator(
	input  wire 				CLK,
	input  wire 				RST_N,

	input  wire 				compare_start,


	//get data;
	output reg  				data_r_en,
	output reg 	[31:0]			data_addr,
	input  wire	[`DATA_WIDTH-1:0] read_data1,
	input  wire	[`DATA_WIDTH-1:0] read_data2,
	output reg 					Compare_Result,
	input  wire					recode_index_reset,

	output wire 				compare_ok

	);

	reg [31:0] record_index; 

	parameter IDEL 			= 5'd0;
	parameter PRE_COMPARE 	= 5'd1;
	parameter START_COMPARE = 5'd2;
	parameter COMPARE_OK 	= 5'd3;

	reg [4:0] state;
	reg ReSet_Record_Index;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			state <= IDEL;
			ReSet_Record_Index <= 0;
		end
		else begin
			ReSet_Record_Index <= 0;
			case(state)
				IDEL:begin
					if(compare_start)begin
						state <= PRE_COMPARE;
					end
				end

				PRE_COMPARE:begin
					state <= START_COMPARE;
				end

				START_COMPARE:begin
					if(read_data1 != read_data2)begin
						state <= COMPARE_OK;
					end
				end

				COMPARE_OK:begin
					if(record_index == 0)begin
						ReSet_Record_Index <= 1;
					end
					state <= IDEL;
				end

			endcase
		end
	end

	assign compare_ok = state == COMPARE_OK;

	reg data_r_en_reg;
	reg flag;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			data_r_en_reg <= 0;
		end
		else begin
			data_r_en_reg <= data_r_en;
		end
	end

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			record_index <= `TOTAL_ADDR*2;
			Compare_Result <= 0;
		end

		else if(compare_start)begin
			flag <= 0;
		end
		else if(state == START_COMPARE && data_r_en_reg)begin
			if(read_data1 != read_data2)begin
				record_index <= record_index;
				if(read_data1 > read_data2)begin
					Compare_Result <= 1;
				end
				else begin
					Compare_Result <= 0;
				end
			end
			else if(read_data1 == read_data2 && |read_data1)begin
				record_index <= record_index;
				flag <= 1;
			end
			else begin
				record_index <= flag ? record_index : record_index - 1;
			end
		end
		else if(recode_index_reset)begin
			record_index <= `TOTAL_ADDR*2;
			// Compare_Result <= 0; 
		end

	end

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			data_addr <= 0;
			data_r_en <= 0;
		end
		else if(state == IDEL && compare_start)begin
			data_addr <= record_index;
			data_r_en <= 1;
		end
		else if(state == START_COMPARE || state == PRE_COMPARE)begin
			
			if(read_data1 != read_data2 && state == START_COMPARE)begin
				data_r_en <= 0;
				data_addr <= data_addr;
			end
			else begin
				data_r_en <= 1;
				data_addr <= data_addr - 1;
			end
		end
	end

endmodule