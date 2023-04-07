`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 12:17:53
// Design Name: 
// Module Name: Mod_Get_t
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

module Mod_Get_t(
	input 	wire 						CLK,
	input 	wire 						RST_N,

	input 	wire [`DATA_WIDTH-1:0] 		t_param_in,
	input 	wire						t_valid,
	input   wire [31:0]					addr_message_in ,

	input   wire 						get_t,
	input   wire [`DATA_WIDTH-1:0]  	Get_M_Valid_Data,
	output  wire [31:0]   				record_addr_out,

	output  reg 				    	Mod_N_R_En,
	output  reg  [31:0] 				Mod_N_R_Addr,
	input   wire [`DATA_WIDTH-1:0]  	Read_Mod_N_Data,

	//Config t
	output  wire [`DATA_WIDTH-1 : 0] 	Out_t,
	output  reg  [31:0]		 		 	Config_t_Addr,
	output  reg  					 	Config_t_valid,
	output  wire  [`DATA_WIDTH-1 : 0] 	Out_r,
	output  reg  [31:0]		 		 	Config_r_Addr,
	output  reg  					 	Config_r_valid,
	output  reg 					 	Config_Done,

	input   wire [4:0]					RSA_Mode


    );		
	parameter IDEL 				= 6'd0;
	parameter GET_VALID_BIT		= 6'd1;
	parameter READ_MOD_N    	= 6'd2;
	parameter READ_MOD_N_Temp 	= 6'd3;
	parameter ORD_BIT_DATA  	= 6'd4;
	parameter ORD_BIG_DATA  	= 6'd5;
	parameter PREPARE 			= 6'd6;
	parameter BIG_LOOP			= 6'd7;
	parameter BUFFER_RES 		= 6'd8;
	parameter CONFIG_T    		= 6'd9;
	parameter GET_R             = 6'd10;
	parameter BUFFER_R 			= 6'd11;
	parameter CONFIG_R 			= 6'd12;
	parameter CHECK 			= 6'd13;
	parameter ADD_PIPELINE      = 6'd14;
	parameter WAIT_COMPARE_RESULT = 6'd15;
	parameter ARRAY_SHIFT       = 6'd16;

	parameter COMPARE_IDEL     	= 6'd0;
	parameter COMPARE_M_MOD_N  	= 6'd1;
	parameter COMPARE_WAIT_MMOD = 6'd2;
	parameter COMPARE_M_M1      = 6'd3;
	parameter COMPARE_WAIT_MM   = 6'd4;
	parameter COMPARE_CHEK      = 6'd5;

	wire 						has_valid_bit;	
	reg  	[31:0]   			record_addr;
	// reg  	[`DATA_WIDTH-1:0]   Temp_Mod_N [0:`TOTAL_ADDR-1];

	reg   						Read_Bit;
	reg 	[4:0]				Read_Addr;
	reg 	[4:0]   			Bit_Aim_Addr;

	reg 	[5:0] 				state;
	reg     [5:0] 				sub_state;
	reg 	[4:0] 				Save_Addr;
	reg 	[`DATA_WIDTH-1:0] 	Mod_N [0:`TOTAL_ADDR-1];
	
	reg 						ORD_R_En;
	reg 	[31:0] 				ORD_Addr;
	reg 	[31:0] 				Valid_Length;
	reg 	[31:0]          	Add_Length;
	reg 						Update_Sub_For_t_En;

	
	reg 	[31:0] 				Mod_N_W_Addr;
	reg        					Mod_N_R_En_Reg;
	reg 	[31:0] 				Read_From_Temp;

	reg 	[31:0] 				ORD_Addr_Reg;
	reg        					ORD_R_En_Reg;


	reg 	[31:0] 				Update_Sub_For_t_Addr;
	
	
	// reg signed [`TOTAL_BITS*2:0] m1;
	// reg 	[`TOTAL_BITS-1:0] 	RES_t;
	// reg 	[`TOTAL_BITS-1:0] 	For_Shift_Res_t;
	// reg 	[`TOTAL_BITS-1:0] 	For_Shift_Res_r;
	// reg 	[`TOTAL_BITS-1:0] 	RES_r;
	reg  				  		Get_R_Success;
	reg 				  		Get_T_Success;
	reg 				  		Clear_Mod_N;

	// wire  [`TOTAL_BITS*2:0] 	add_result;
	wire 						add_complete;
	reg 						add_start;


	//reg     		[`DATA_WIDTH-1:0] Sub_For_t [0:`TOTAL_ADDR*2-1];
	//reg     		[`DATA_WIDTH-1:0] m_temp 	[0:`TOTAL_ADDR*2];
	//reg 	signed 	[`DATA_WIDTH-1:0] m1 		[0:`TOTAL_ADDR*2];
	//reg 			[`DATA_WIDTH-1:0] m0        [0:`TOTAL_ADDR*2];
	reg            	[1:0]			      C;
	//reg [`DATA_WIDTH - 1 : 0] r_in [`TOTAL_ADDR - 1 : 0];


	// wire [4:0] RSA_Mode = 4;

	wire [31:0] shifter_record_addr = record_addr << 5;

	assign has_valid_bit = | t_param_in;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			record_addr <= 0;
		end
		else if(t_valid && has_valid_bit)begin
			record_addr <= addr_message_in;
		end
	end
	assign record_addr_out = record_addr;

	reg [31:0] two_times_len;
	reg [31:0] valid_addr_len;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Add_Length <= 0;
			two_times_len <= 0;
			valid_addr_len <= 0;
		end
		else begin
			case(RSA_Mode)
				0: begin Add_Length <= 384  	- Valid_Length; two_times_len <= 383;  valid_addr_len <= 5;  end // 192bit
				1: begin Add_Length <= 512  	- Valid_Length; two_times_len <= 511;  valid_addr_len <= 7;  end // 256bit
				2: begin Add_Length <= 1024  	- Valid_Length; two_times_len <= 1023; valid_addr_len <= 15; end // 512bit
				3: begin Add_Length <= 2048  	- Valid_Length; two_times_len <= 2047; valid_addr_len <= 31; end // 1024bit
				4: begin Add_Length <= 4096 	- Valid_Length; two_times_len <= 4095; valid_addr_len <= 63; end // 2048bit
				default:;
			endcase
		end
	end


	reg 						 m0_m_temp_compare_start;
	wire 						 m0_m_temp_data_r_en;
	wire [31:0] 				 m0_m_temp_data_addr;
	wire  [`DATA_WIDTH-1:0]       m0_read_data;
	wire  [`DATA_WIDTH-1:0]       m_temp_read_data;
	wire 						 m0_m_temp_result;
	wire 						 m0_m_temp_compare_ok;


	reg 						 m0_Mod_N_compare_start;
	wire 						 m0_Mod_N_data_r_en;
	wire [31:0] 				 m0_Mod_N_data_addr;
	reg  [`DATA_WIDTH-1:0]       Mod_N_read_data;
	wire 						 m0_Mod_N_result;
	wire 						 m0_Mod_N_compare_ok;

	wire 						adder_read_en;
	wire [31:0] 				adder_read_addr;
	wire [`DATA_WIDTH - 1 : 0] 	m1_adder;

	wire 						result_valid;
	wire  [31:0] 				result_addr;
	wire  [`DATA_WIDTH - 1 : 0] result;

 	reg 									shift_start;
 	wire 									shift_read_en;
 	wire [31:0] 							shift_read_addr;

 	wire 									shift_valid;
	wire  [31:0]							shift_addr;
	wire  signed [`DATA_WIDTH-1:0]   		shift_m1;
	wire  [`DATA_WIDTH-1:0]  	 			shift_m_temp;

	wire 									shift_ok;
	reg 									Get_R_En; 


	reg   [31:0] 							Get_R_Counter;
	reg 									get_out_t;
	reg 									get_out_r;
	
	reg   [31:0] 							config_t_read_addr;
	reg   [31:0] 							config_r_read_addr;
	reg 									recode_index_reset;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			state <= IDEL;
			Save_Addr <= 0;
			Mod_N_R_En <= 0; 
			ORD_R_En <= 0;
			Update_Sub_For_t_En <= 0;
			Get_T_Success <= 0;
			Get_R_Success <= 0;
			sub_state <= COMPARE_IDEL;
			Get_R_En <= 0;
			get_out_t <= 0;
			get_out_r <= 0;
		end
		else begin
			Config_Done <= 0;
			Clear_Mod_N <= 0;
			add_start <= 0;
			m0_m_temp_compare_start <= 0;
			m0_Mod_N_compare_start <= 0;
			shift_start <= 0; 
			recode_index_reset <= 0;
			case(state)
				IDEL:begin
					if(get_t)begin
						state <= GET_VALID_BIT;
						Clear_Mod_N <= 1;
					end
				end

				GET_VALID_BIT:begin
					if(Read_Bit)begin
						Save_Addr <= Bit_Aim_Addr;
						state <= READ_MOD_N;
						Mod_N_R_En <= 1;
					end
				end

				READ_MOD_N:begin
					if(Mod_N_R_Addr == record_addr)begin
						Mod_N_R_En <= 0;
						state <= READ_MOD_N_Temp;
						// ORD_R_En <= 1;
						Valid_Length <= shifter_record_addr + Save_Addr + 1;
					end
				end

				READ_MOD_N_Temp:begin
					state <= ORD_BIT_DATA;
					// ORD_R_En <= 1;
				end

				ORD_BIT_DATA:begin
					// if(ORD_Addr == record_addr)begin
						ORD_R_En <= 0;
						state <= ORD_BIG_DATA;
						
						Update_Sub_For_t_En <= 1;
					// end
				end

				ORD_BIG_DATA:begin

					if(Update_Sub_For_t_Addr == `TOTAL_BITS*2+31)begin
						Update_Sub_For_t_En <= 0;
						state <= PREPARE;
					end
				end

				PREPARE:begin
				    case(sub_state)
						COMPARE_IDEL: begin
							m0_Mod_N_compare_start <= 1;
							sub_state <= COMPARE_WAIT_MMOD;
						end 
						COMPARE_WAIT_MMOD:begin
							if(m0_Mod_N_compare_ok)begin
								if(!m0_Mod_N_result)begin
									state <= BIG_LOOP;
									sub_state <= COMPARE_IDEL;
									recode_index_reset <= 1;
								end
								else begin
									sub_state <= COMPARE_WAIT_MM;
									m0_m_temp_compare_start <= 1;
								end
							end
						end

						COMPARE_WAIT_MM:begin
							if(m0_m_temp_compare_ok)begin
								if(m0_m_temp_result)begin
									state <= ADD_PIPELINE;
									add_start <= 1;
									sub_state <= COMPARE_IDEL;
								end
								else begin
									state <= ARRAY_SHIFT;
									shift_start <= 1;
									sub_state <= COMPARE_IDEL;
								end
							end
						end

					endcase
				end

				ADD_PIPELINE:begin
					if(add_complete)begin
						state <= PREPARE;
					end
				end

				ARRAY_SHIFT:begin
					if(shift_ok)begin
						state <= PREPARE;
					end
				end

				BIG_LOOP:begin
					Get_R_En <= 1;
					state <= GET_R;
				end

				GET_R:begin
					// RES_r <= {~Mod_N + 1};
					if(Get_R_Counter == `TOTAL_BITS-1)begin
						Get_R_En <= 0;
						state <= CONFIG_T;
						get_out_t <= 1;
					end
				end

				CONFIG_T:begin
					if(Config_t_Addr == valid_addr_len)begin
						state <= CONFIG_R;	
						Get_T_Success <= 1; 
						get_out_t <= 0;
						get_out_r <= 1;
					end 
				end

				CONFIG_R:begin
					if(Config_r_Addr == valid_addr_len)begin
						state <= CHECK;	
						Get_R_Success <= 1;
						Config_Done <= 1;
						get_out_r <= 0;
					end 
				end

				CHECK:begin
					state <= IDEL;
				end

			endcase
		end
	end


	Comparator m0_m_temp_compare(
	.CLK(CLK),
	.RST_N(RST_N),

	.compare_start(m0_m_temp_compare_start),


	//get data;
	.data_r_en(m0_m_temp_data_r_en),
	.data_addr(m0_m_temp_data_addr),
	.read_data1(m0_read_data),
	.read_data2(m_temp_read_data),
	.Compare_Result(m0_m_temp_result),
	.recode_index_reset(recode_index_reset),

	.compare_ok(m0_m_temp_compare_ok)

	);

	Comparator m0_Mod_N_compare(
	.CLK(CLK),
	.RST_N(RST_N),

	.compare_start(m0_Mod_N_compare_start),


	//get data;
	.data_r_en(m0_Mod_N_data_r_en),
	.data_addr(m0_Mod_N_data_addr),
	.read_data1(m0_read_data),
	.read_data2(Mod_N_read_data),
	.Compare_Result(m0_Mod_N_result),
	.recode_index_reset(recode_index_reset),

	.compare_ok(m0_Mod_N_compare_ok)

	);

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Mod_N_read_data <= 0;
		end
		else if(m0_Mod_N_data_r_en)begin
			if(m0_Mod_N_data_addr > record_addr)begin
				Mod_N_read_data <= 0;
			end
			else begin
				Mod_N_read_data <= Mod_N[m0_Mod_N_data_addr];
			end
		end
	end

 	PipeLine_Adder x_PipeLine_Adder(
	.CLK(CLK),
	.RST_N(RST_N),

	.read_en(adder_read_en),
	.read_addr(adder_read_addr),
	.m0(m0_read_data),
	.m1(m1_adder),

	.add_start(add_start),

	.result_valid(result_valid),
	.result_addr(result_addr),
	.result(result),

	.add_complete(add_complete),
	.two_times_len_1(valid_addr_len)
    
    );	


    Array_Shift x_Array_Shift(
		.CLK(CLK),
		.RST_N(RST_N),

		.shift_start(shift_start),

		.read_en(shift_read_en),
		.read_addr(shift_read_addr),
		.m1(m1_adder),
		.m_temp(m_temp_read_data),

		.shift_valid(shift_valid),
		.shift_addr(shift_addr),
		.shift_m1(shift_m1),
		.shift_m_temp(shift_m_temp),

		.shift_ok(shift_ok) 		
	
	);


	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Read_Bit <= 0;
			Read_Addr <= 31;
			Bit_Aim_Addr <= 0;
		end
		else if(state == GET_VALID_BIT)begin
			Read_Bit <= Get_M_Valid_Data[Read_Addr];
			Read_Addr <= Read_Addr - 1;
			Bit_Aim_Addr <= Read_Addr;
		end
		else begin
			Read_Bit <= 0;
			Read_Addr <= 31;
		end
	end


	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Mod_N_R_En_Reg <= 0;
		end
		else begin
			Mod_N_R_En_Reg <= Mod_N_R_En;
		end
	end

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Mod_N_R_Addr <= 0;
		end
		else if(Mod_N_R_En)begin
			Mod_N_R_Addr <= Mod_N_R_Addr + 1;
		end
		else begin
			Mod_N_R_Addr <= 0;
		end
	end

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Mod_N_W_Addr <= 0;
		end
		else begin
			Mod_N_W_Addr <= Mod_N_R_Addr;
		end
	end

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			// Mod_N <= 0;
		end
		else if(Clear_Mod_N)begin
			// Mod_N <= 0;
		end
		else if(Mod_N_R_En_Reg)begin
			Mod_N[Mod_N_W_Addr] <= Read_Mod_N_Data;
		end
	end

	reg [31:0] Row_Index;
	reg [31:0] Col_Index;
	reg [31:0] Fetch_Row_Index;
	reg [31:0] Fetch_Col_Index;
	reg 	   WB_RAM;
	reg [31:0] WB_ADDR;
	reg 	   WB_RAM_For_R;
	reg [31:0] WB_ADDR_For_R;

	always@(posedge CLK or negedge RST_N)begin
		WB_RAM <= 0;
		if(!RST_N)begin
			Update_Sub_For_t_Addr <= 0;
			Row_Index <= 0;
			Col_Index <= 0;
			WB_ADDR <= 0;
		end
		else if(Update_Sub_For_t_En)begin
			Update_Sub_For_t_Addr <= Update_Sub_For_t_Addr + 1;
			if(Col_Index == `DATA_WIDTH-1)begin
				Row_Index <= Row_Index + 1;
				WB_RAM <= 1;
				WB_ADDR <= Row_Index;
				Col_Index <= 0;
			end
			else begin
				Row_Index <= Row_Index;
				Col_Index <= Col_Index + 1;
			end
		end
		else begin
			Update_Sub_For_t_Addr <= 0;
			Row_Index <= 0;
			Col_Index <= 0;
		end
	end


	always@(posedge CLK or negedge RST_N)begin
		WB_RAM_For_R <= 0;
		if(!RST_N)begin
			Fetch_Row_Index <= 0;
			Fetch_Col_Index <= 0;
			Get_R_Counter <= 0;
			WB_ADDR_For_R <= 0;
		end
		else if(Update_Sub_For_t_En)begin
			if(Update_Sub_For_t_Addr <= Add_Length - 1)begin
				Fetch_Row_Index <= 0;
				Fetch_Col_Index <= 0;
			end
			else if(Update_Sub_For_t_Addr <= two_times_len)begin
				if(Fetch_Col_Index == `DATA_WIDTH-1)begin
					Fetch_Row_Index <= Fetch_Row_Index + 1;
					Fetch_Col_Index <= 0;
				end
				else begin
					Fetch_Row_Index <= Fetch_Row_Index;
					Fetch_Col_Index <= Fetch_Col_Index + 1;
				end
			end
		end
		else if(Get_R_En)begin
			Get_R_Counter <= Get_R_Counter + 1;
			if(Fetch_Col_Index == `DATA_WIDTH-1)begin
				Fetch_Row_Index <= Fetch_Row_Index + 1;
				Fetch_Col_Index <= 0;
				WB_RAM_For_R <= 1;
				WB_ADDR_For_R <= Fetch_Row_Index;
			end
			else begin
				Fetch_Row_Index <= Fetch_Row_Index;
				Fetch_Col_Index <= Fetch_Col_Index + 1;
			end
		end
		else begin
			Fetch_Row_Index <= 0;
			Fetch_Col_Index <= 0;
			Get_R_Counter <= 0;
		end
	end

	


	reg [`DATA_WIDTH-1:0] Buffer_DATA_Temp_m1;
	reg [`DATA_WIDTH-1:0] Buffer_DATA_Temp_m_temp;
	reg [`DATA_WIDTH-1:0] Buffer_DATA_Temp_m0;
	reg [`DATA_WIDTH-1:0] Buffer_DATA_Temp_rin;
	reg [`DATA_WIDTH-1:0] Read_From_Mod_N;


	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Read_From_Mod_N <= 0;
		end
		else if(Update_Sub_For_t_En || Get_R_En)begin
			if(Fetch_Col_Index == `DATA_WIDTH-1)begin
				 Read_From_Mod_N <= ~Mod_N[Fetch_Row_Index + 1];
			end
		end
		else begin
			Read_From_Mod_N <= ~Mod_N[Fetch_Row_Index];
		end
	end

	wire see = Read_From_Mod_N[Fetch_Col_Index];//~Mod_N[Fetch_Row_Index][Fetch_Col_Index];


	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			C <= 0;
			Buffer_DATA_Temp_m1 <= 0;
		end
		else if(Update_Sub_For_t_En)begin
			if(Update_Sub_For_t_Addr <= Add_Length - 1)begin
				// Sub_For_t[Update_Sub_For_t_Addr] <= 0;
				if(Update_Sub_For_t_Addr == 0)begin
					// {m1[Row_Index][Col_Index]} <= 1'b1 + 1'b1;
					Buffer_DATA_Temp_m1[Col_Index] <= 1'b1 + 1'b1;
					C <= 1'b1 + 1'b1;
				end
				else begin
					// {m1[Row_Index][Col_Index]} <= 1'b1 + C[1];
					Buffer_DATA_Temp_m1[Col_Index] <= 1'b1 + C[1];
					C <= 1'b1 + C[1];
				end
				// m_temp[Row_Index][Col_Index] 	<= 0;
				Buffer_DATA_Temp_m_temp[Col_Index] 	<= 0;
			end
			else if(Update_Sub_For_t_Addr <= two_times_len)begin
				if(Update_Sub_For_t_Addr == 0)begin
					// {m1[Row_Index][Col_Index]} <= see + 1'b1;
					Buffer_DATA_Temp_m1[Col_Index] <= see + 1'b1;
					C <= see + 1'b1;
				end
				else begin
					// {m1[Row_Index][Col_Index]} <= see+ C[1];
					Buffer_DATA_Temp_m1[Col_Index] <= see+ C[1];
					C <= see + C[1];
				end
				// m_temp[Row_Index][Col_Index] <= Mod_N[Fetch_Row_Index][Fetch_Col_Index];
				Buffer_DATA_Temp_m_temp[Col_Index] <= ~see;
			end
			else begin
				// {m1[Row_Index][Col_Index]} <= 1'b1 + C[1];
				Buffer_DATA_Temp_m1[Col_Index] <= 1'b1 + C[1];
				// m_temp[Row_Index][Col_Index] <= 0;
				Buffer_DATA_Temp_m_temp[Col_Index] <= 0;
				C <= 1'b1 + C[1];
			end
		end
		// else if(shift_valid)begin
		// 	// m1[shift_addr] 		<= shift_m1;
		// 	m_temp[shift_addr]	<= shift_m_temp;
		// end
		else begin
			C <= 0;
		end
	end

	//m1
	sram_32_129 m1_sram (
	  .clka(CLK),    // input wire clka
	  .ena(WB_RAM | shift_valid),      // input wire ena
	  .wea(WB_RAM | shift_valid),      // input wire [0 : 0] wea
	  .addra(WB_RAM ? WB_ADDR : shift_addr),  // input wire [7 : 0] addra
	  .dina(WB_RAM ? Buffer_DATA_Temp_m1 : shift_m1),    // input wire [31 : 0] dina
	  
	  .clkb(CLK),    // input wire clkb
	  .enb(adder_read_en | shift_read_en),      // input wire enb
	  .addrb(adder_read_en ? adder_read_addr : shift_read_addr),  // input wire [7 : 0] addrb
	  .doutb(m1_adder)  // output wire [31 : 0] doutb
	);
	// always@(posedge CLK or negedge RST_N)begin
	// 	if(!RST_N)begin
	// 		m1_adder <= 0;
	// 	end
	// 	else if(adder_read_en)begin
	// 		m1_adder <= m1[adder_read_addr];
	// 	end
	// 	else if(shift_read_en)begin
	// 		m1_adder <= m1[shift_read_addr];
	// 	end
	// end
	// always@(posedge CLK or negedge RST_N)begin
	// 	if(~RST_N)begin
			
	// 	end
	// 	else if(WB_RAM)begin
	// 		m1[WB_ADDR] <= Buffer_DATA_Temp_m1;
	// 	end
	// 	else if(shift_valid)begin
	// 		m1[shift_addr] <= shift_m1;
	// 	end
	// end

	////m_temp
	sram_32_129 m_temp_sram (
	  .clka(CLK),    // input wire clka
	  .ena(WB_RAM | shift_valid),      // input wire ena
	  .wea(WB_RAM | shift_valid),      // input wire [0 : 0] wea
	  .addra(WB_RAM ? WB_ADDR : shift_addr),  // input wire [7 : 0] addra
	  .dina(WB_RAM ? Buffer_DATA_Temp_m_temp : shift_m_temp),    // input wire [31 : 0] dina
	  
	  .clkb(CLK),    // input wire clkb
	  .enb(m0_m_temp_data_r_en | shift_read_en),      // input wire enb
	  .addrb(m0_m_temp_data_r_en ? m0_m_temp_data_addr : shift_read_addr),  // input wire [7 : 0] addrb
	  .doutb(m_temp_read_data)  // output wire [31 : 0] doutb
	);
	// always@(posedge CLK or negedge RST_N)begin
	// 	if(!RST_N)begin
	// 		m_temp_read_data <= 0;
	// 	end
	// 	else if(m0_m_temp_data_r_en)begin
	// 		m_temp_read_data <= m_temp[m0_m_temp_data_addr];
	// 	end
	// 	else if(shift_read_en)begin
	// 		m_temp_read_data <= m_temp[shift_read_addr];
	// 	end
	// end
	// always@(posedge CLK or negedge RST_N)begin
	// 	if(~RST_N)begin
			
	// 	end
	// 	else if(WB_RAM)begin
	// 		m_temp[WB_ADDR] <= Buffer_DATA_Temp_m_temp;
	// 	end
	// 	else if(shift_valid)begin
	// 		m_temp[shift_addr]	<= shift_m_temp;
	// 	end
	// end

	reg [1:0] C_r;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			C_r <= 0;
		end
		else if(Get_R_En)begin
			if(Get_R_Counter <= `TOTAL_BITS-1)begin
				if(Get_R_Counter == 0)begin
					// {r_in[Fetch_Row_Index][Fetch_Col_Index]} <= see + 1'b1;
					Buffer_DATA_Temp_rin[Fetch_Col_Index] <= see + 1'b1;
					C_r <= see + 1'b1;
				end
				else if(Get_R_Counter <= Valid_Length - 1) begin
					// {r_in[Fetch_Row_Index][Fetch_Col_Index]} <= see + C_r[1];
					Buffer_DATA_Temp_rin[Fetch_Col_Index] <= see + C_r[1];
					C_r <= see + C_r[1];
				end
				else begin
					// {r_in[Fetch_Row_Index][Fetch_Col_Index]} <= 1'b1 + C_r[1];
					Buffer_DATA_Temp_rin[Fetch_Col_Index] <= 1'b1 + C_r[1];
					C_r <= 1'b1 + C_r[1];
				end
			end
		end
		else begin
			C_r <= 0;
		end
		
	end


	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Buffer_DATA_Temp_m0 <= 0;
		end
		else if(Update_Sub_For_t_En)begin
			if(Update_Sub_For_t_Addr <= two_times_len)begin
				// m0[Row_Index][Col_Index] <= 0;
				Buffer_DATA_Temp_m0[Col_Index] <= 0;
			end
			else if(Update_Sub_For_t_Addr == two_times_len + 1)begin
				// m0[Row_Index][Col_Index] <= 1;
				Buffer_DATA_Temp_m0[Col_Index] <= 1;
			end
			else begin
				// m0[Row_Index][Col_Index] <= 0;
				Buffer_DATA_Temp_m0[Col_Index] <= 0;
			end
		end
		// else if(result_valid)begin
		// 	m0[result_addr] <= result;
		// end
	end

	//m0
	reg [7:0] m_temp_sram_addr;
	reg 	  m_temp_sram_read_en;
	sram_32_129 m0_sram (
	  .clka(CLK),    // input wire clka
	  .ena(WB_RAM | result_valid),      // input wire ena
	  .wea(WB_RAM | result_valid),      // input wire [0 : 0] wea
	  .addra(WB_RAM ? WB_ADDR : result_addr),  // input wire [7 : 0] addra
	  .dina(WB_RAM ? Buffer_DATA_Temp_m0 : result),    // input wire [31 : 0] dina
	  
	  .clkb(CLK),    // input wire clkb
	  .enb(m_temp_sram_read_en),      // input wire enb
	  .addrb(m_temp_sram_addr),  // input wire [7 : 0] addrb
	  .doutb(m0_read_data)  // output wire [31 : 0] doutb
	);

	always@(*)begin
		if(!RST_N)begin
			m_temp_sram_addr <= 8'b0;
			m_temp_sram_read_en <= 0;
		end
		else if(m0_m_temp_data_r_en)begin
			m_temp_sram_addr <= m0_m_temp_data_addr;
			m_temp_sram_read_en <= 1;
		end
		else if(m0_Mod_N_data_r_en)begin
			m_temp_sram_addr <= m0_Mod_N_data_addr;
			m_temp_sram_read_en <= 1;
		end
		else if(adder_read_en)begin
			m_temp_sram_addr <= adder_read_addr;
			m_temp_sram_read_en <= 1;
		end
		else if(get_out_t)begin
			m_temp_sram_addr <= config_t_read_addr;
			m_temp_sram_read_en <= 1;
		end
		else begin
			m_temp_sram_addr <= 8'b0;
			m_temp_sram_read_en <= 0;
		end
	end
	// always@(posedge CLK or negedge RST_N)begin
	// 	if(~RST_N)begin
			
	// 	end
	// 	else if(WB_RAM)begin
	// 		m0[WB_ADDR] <= Buffer_DATA_Temp_m0;
	// 	end
	// 	else if(result_valid)begin
	// 		m0[result_addr] <= result;
	// 	end
	// end


	/////////////////////////////////////////////////////////
	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Config_t_valid <= 0;
		end
		else if(state == CONFIG_T && Config_t_Addr != valid_addr_len)begin
			Config_t_valid <= 1;
		end
		else begin
			Config_t_valid <= 0;
		end
	end

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Config_t_Addr <= 0;
		end
		else if(Config_t_valid)begin
			Config_t_Addr <= Config_t_Addr + 1;
		end
		else begin
			Config_t_Addr <= 0;
		end
	end

	assign Out_t = m0_read_data;

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Config_r_valid <= 0;
		end
		else if(state == CONFIG_R && Config_r_Addr != valid_addr_len)begin
			Config_r_valid <= 1;
		end
		else begin
			Config_r_valid <= 0;
		end
	end

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			Config_r_Addr <= 0;
		end
		else if(Config_r_valid)begin
			Config_r_Addr <= Config_r_Addr + 1;
		end
		else begin
			Config_r_Addr <= 0;
		end
	end

	// r_in
	sram_32_64 r_in_sram (
	  .clka(CLK),    // input wire clka
	  .ena(WB_RAM_For_R),      // input wire ena
	  .wea(WB_RAM_For_R),      // input wire [0 : 0] wea
	  .addra(WB_ADDR_For_R),  // input wire [3 : 0] addra
	  .dina(Buffer_DATA_Temp_rin),    // input wire [15 : 0] dina
	  
	  .clkb(CLK),    // input wire clkb
	  .enb(get_out_r),      // input wire enb
	  .addrb(config_r_read_addr),  // input wire [3 : 0] addrb
	  .doutb(Out_r)  // output wire [15 : 0] doutb
	);
	// always@(posedge CLK or negedge RST_N)begin
	// 	if(~RST_N)begin
			
	// 	end
	// 	else if(WB_RAM_For_R)begin
	// 		r_in[WB_ADDR_For_R] <= Buffer_DATA_Temp_rin;
	// 	end
	// end
	// always@(posedge CLK or negedge RST_N)begin
	// 	if(!RST_N)begin
	// 		Out_r <= 0;
	// 	end
	// 	else if(get_out_r)begin
	// 		Out_r <= r_in[config_r_read_addr];
	// 	end
	// end


	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			config_t_read_addr <= 0;
		end
		else if(get_out_t)begin
			if(config_t_read_addr == valid_addr_len)begin
				config_t_read_addr <= 0;
			end
			else begin
				config_t_read_addr <= config_t_read_addr + 1;
			end
		end
		else begin
			config_t_read_addr <= 0;
		end
	end

	always@(posedge CLK or negedge RST_N)begin
		if(!RST_N)begin
			config_r_read_addr <= 0;
		end
		else if(get_out_r)begin
			if(config_r_read_addr == valid_addr_len)begin
				config_r_read_addr <= 0;
			end
			else begin
				config_r_read_addr <= config_r_read_addr + 1;
			end
		end
		else begin
			config_r_read_addr <= 0;
		end
	end

endmodule