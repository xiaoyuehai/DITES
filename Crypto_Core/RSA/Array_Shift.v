`include "_parameter.v"

module Array_Shift(
	input   wire 							CLK,
	input   wire 							RST_N,

	input   wire  							shift_start,

	output  reg  		 					read_en,
	output  reg  [31:0] 					read_addr,
	input   wire signed [`DATA_WIDTH-1:0] 	m1,
	input   wire [`DATA_WIDTH-1:0]          m_temp,

	output  wire 							shift_valid,
	output  reg  [31:0]						shift_addr,
	output  reg  signed [`DATA_WIDTH-1:0]   shift_m1,
	output  reg  [`DATA_WIDTH-1:0]  	 	shift_m_temp,

	output  wire 							shift_ok 		
	
	);

	parameter IDEL 		  = 5'd0;
	parameter START_SHIFT = 5'd1;
	parameter SHIFT_TEMP  = 5'd2;
	parameter SHIFT_TEMP1 = 5'd3;
	parameter SHIFT_OK    = 6'd4;

	reg [4:0] state;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			state <= IDEL;
			read_en <= 0;
		end
		else begin
			case(state)
				IDEL:begin
					if(shift_start)begin
						state <= START_SHIFT;
						read_en <= 1;
					end
				end

				START_SHIFT:begin
					if(read_addr == `TOTAL_ADDR * 2)begin
						state <= SHIFT_TEMP;
						read_en <= 0;
					end
				end

				SHIFT_TEMP:begin
					state <= SHIFT_TEMP1;
				end

				SHIFT_TEMP1:begin
					state <= SHIFT_OK;
				end

				SHIFT_OK:begin
					state <= IDEL;
				end

			endcase
		end
	end 

	assign shift_ok = state == SHIFT_OK;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			read_addr <= 0;
		end
		else if(read_en)begin
			read_addr <= read_addr + 1;
		end
		else begin
			read_addr <= 0;
		end
	end

	reg signed [`DATA_WIDTH-1:0] m1_buffer;
	reg [`DATA_WIDTH-1:0] m_temp_buffer;
	reg read_en_reg,read_en_reg_reg,read_en_reg_reg_reg;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			m1_buffer <= 0;
			m_temp_buffer <= 0;
		end
		else begin
			m1_buffer <= m1;
			m_temp_buffer <= m_temp;
		end
	end

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			read_en_reg <= 0;
			read_en_reg_reg <= 0;
			read_en_reg_reg_reg <= 0;
		end
		else begin
			read_en_reg <= read_en;
			read_en_reg_reg <= read_en_reg;
			read_en_reg_reg_reg <= read_en_reg_reg;
		end
	end

	assign shift_valid = read_en_reg_reg_reg;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			shift_addr <= 0;
		end
		else if(shift_valid)begin
			shift_addr <= shift_addr + 1;
		end
		else begin
			shift_addr <= 0;
		end
	end

	wire signed [`DATA_WIDTH-1:0] shift_temp0 = m1_buffer >>> 1;
	wire [`DATA_WIDTH-1:0] shift_temp1 = m_temp_buffer >>> 1;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			shift_m1 <= 0;
			shift_m_temp <= 0;
 		end
 		else if(shift_addr + 1 == `TOTAL_ADDR*2)begin
 			shift_m1 <= m1_buffer >>> 1;
			shift_m_temp <= shift_temp1;
 		end
		else begin
			shift_m1 <= {m1[0], shift_temp0[`DATA_WIDTH-2:0]};
			shift_m_temp <= {m_temp[0],shift_temp1[`DATA_WIDTH-2:0]};
		end
	end

endmodule