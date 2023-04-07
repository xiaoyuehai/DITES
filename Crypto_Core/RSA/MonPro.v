// MonPro module
// follow this algorithm: http://cs.ucsb.edu/~koc/cs290g/docs/w01/mon1.pdf
`include "_parameter.v"

module MonPro
(	
	input 	wire 					 get_t,
	input 	wire [4:0] 				 RSA_Mode,
	input 	wire [31:0] 			 TOTAL_ADDR_1,
	input 	wire 					 read_mod_n_en,
	output	wire  [`DATA_WIDTH-1:0]  Out_Mod_n,
	//Config t
	output  wire [`DATA_WIDTH-1 : 0] Out_t,
	output  wire  [31:0]		 	 Config_t_Addr,
	output  wire  					 Config_t_valid,
	output  wire [`DATA_WIDTH-1 : 0] Out_r,
	output  wire  [31:0]		 	 Config_r_Addr,
	output  wire  					 Config_r_valid,
	output  wire 					 Config_Done,

	input clk,
	input reset,
	input [0: 0] start,
	input [`DATA_WIDTH - 1 : 0] inp,	// data input pins

	input wire nprime0_valid,
	input wire [`DATA_WIDTH - 1 : 0] nprime0_in,
	input wire mod_n_valid,
	input wire [`DATA_WIDTH - 1 : 0] mod_n_in,

	output reg [4 : 0] state,
	output wire [`DATA_WIDTH - 1 : 0] outp	// data output pins
);

	// reg [`DATA_WIDTH - 1 : 0] x [`TOTAL_ADDR : 0];	
	// reg [`DATA_WIDTH - 1 : 0] y [`TOTAL_ADDR : 0];	// we need one more word for y, because when vector(v) = (m * vector(n) + vector(v)) >> WIDTH, it may have one more word on top that we need to keep to the next loop.
	
	reg [`DATA_WIDTH - 1 : 0] nprime0 [0 : 0];	// a memory must have unpacked array!
	// reg [`DATA_WIDTH - 1 : 0] n [`TOTAL_ADDR - 1 : 0];
	
	reg [`DATA_WIDTH - 1 : 0] c;
	reg [`DATA_WIDTH - 1 : 0] v [`TOTAL_ADDR + 1 : 0];	// v is the temp and final result
	reg [`DATA_WIDTH - 1 : 0] m;
	
	wire [31:0] record_addr_out;
	reg [`DATA_WIDTH - 1 : 0] Get_M_Valid_Data;
	wire 		Mod_N_R_En;
	wire [31:0]	Mod_N_R_Addr;
	wire  [`DATA_WIDTH - 1 : 0] Read_Mod_N_Data;


	integer ii;	// big loop i
	integer jj;	// small loop j
	integer kk;	// clock upper edge and down edge
	reg [31:0] i,j,k;
	reg [31:0] addr_for_n_in;

	// assign Get_M_Valid_Data = n[record_addr_out];

	Mod_Get_t x_Mod_Get_t(
	.CLK(clk),
	.RST_N(!reset),

	.t_param_in(mod_n_in),
	.t_valid(mod_n_valid),
	.addr_message_in(addr_for_n_in),

	.get_t(get_t),
	.Get_M_Valid_Data(Get_M_Valid_Data),
	.record_addr_out(record_addr_out),

	.Mod_N_R_En(Mod_N_R_En),
	.Mod_N_R_Addr(Mod_N_R_Addr),
	.Read_Mod_N_Data(Read_Mod_N_Data),

	//Config t
	.Out_t(Out_t),
	.Config_t_Addr(Config_t_Addr),
	.Config_t_valid(Config_t_valid),
	.Out_r(Out_r),
	.Config_r_Addr(Config_r_Addr),
	.Config_r_valid(Config_r_valid),
	.Config_Done(Config_Done),
	.RSA_Mode(RSA_Mode)	

    );	


	always@(posedge clk or posedge reset) begin
		if(reset)begin
			addr_for_n_in <= 0;
		end
		else if(mod_n_valid || read_mod_n_en)begin
			if(addr_for_n_in == TOTAL_ADDR_1)begin
				addr_for_n_in <= 0;
			end
			else begin
				addr_for_n_in <= addr_for_n_in + 1;
			end
		end
	end

	always@(posedge clk or posedge reset)begin
		if(reset)begin
			nprime0[0] <= 0;
		end
		else if(nprime0_valid)begin
			nprime0[0] <= nprime0_in;
		end
	end
	
	reg [`DATA_WIDTH - 1 : 0] x0;
	reg [`DATA_WIDTH - 1 : 0] y0;
	reg [`DATA_WIDTH - 1 : 0] z0;
	reg [`DATA_WIDTH - 1 : 0] last_c0;
	reg [`DATA_WIDTH - 1 : 0] now_c0;
	wire [`DATA_WIDTH - 1 : 0] s0;
	wire [`DATA_WIDTH - 1 : 0] c0;
	MulAdd MulAdd0 (.clk(clk), .x(x0), .y(y0), .z(z0), .last_c(last_c0), 
                .s(s0), .c(c0));

	//reg [`DATA_WIDTH - 1 : 0] x [`TOTAL_ADDR : 0];
	wire [`DATA_WIDTH - 1 : 0] x_out;
	reg 				      read_x_en;
	reg [6:0] 				  read_x_addr;
	reg 					  write_x_en;
	reg [6:0]				  write_x_addr;
	reg [`DATA_WIDTH - 1 : 0] write_x_data;

	//reg [`DATA_WIDTH - 1 : 0] y [`TOTAL_ADDR : 0];
	wire [`DATA_WIDTH - 1 : 0] y_out;
	reg 				      read_y_en;
	reg [6:0] 				  read_y_addr;
	reg 					  write_y_en;
	reg [6:0]				  write_y_addr;
	reg [`DATA_WIDTH - 1 : 0] write_y_data;

	//reg [`DATA_WIDTH - 1 : 0] n [`TOTAL_ADDR : 0];
	wire [`DATA_WIDTH - 1 : 0] n_out;
	reg 				      read_n_en;
	reg [6:0] 				  read_n_addr;
	reg 					  write_n_en;
	reg [6:0]				  write_n_addr;
	reg [`DATA_WIDTH - 1 : 0] write_n_data;

	//reg [`DATA_WIDTH - 1 : 0] v [`TOTAL_ADDR : 0];
	wire [`DATA_WIDTH - 1 : 0] v_out;
	reg 				      read_v_en;
	reg [6:0] 				  read_v_addr;
	reg 					  write_v_en;
	reg [6:0]				  write_v_addr;
	reg [`DATA_WIDTH - 1 : 0] write_v_data;


	reg [`DATA_WIDTH - 1 : 0] write_x_data_FSM;
	reg [`DATA_WIDTH - 1 : 0] write_y_data_FSM;
	reg [`DATA_WIDTH - 1 : 0] write_v_data_FSM;

	reg read_v_sub;
	reg read_v_sub_reg;
	reg read_v_sub_real;
	reg read_v_sub_real_reg;

	sram_32_65 x_sram (
	  .clka(clk),    // input wire clka
	  .ena(write_x_en),      // input wire ena
	  .wea(write_x_en),      // input wire [0 : 0] wea
	  .addra(write_x_addr),  // input wire [6 : 0] addra
	  .dina(write_x_data),    // input wire [31 : 0] dina
	  
	  .clkb(clk),    // input wire clkb
	  .enb(read_x_en),      // input wire enb
	  .addrb(read_x_addr),  // input wire [6 : 0] addrb
	  .doutb(x_out)  // output wire [31 : 0] doutb
	);
	//read
	// always@(posedge clk or posedge reset)begin
	// 	if(reset)begin
	// 		x_out <= 32'b0;
	// 	end
	// 	else if(read_x_en)begin
	// 		x_out <= x[read_x_addr];
	// 	end
	// 	else begin
	// 		x_out <= x_out;
	// 	end
	// end
	// //write
	// always@(posedge clk)begin
	// 	if(write_x_en)begin
	// 		x[write_x_addr] <= write_x_data;
	// 	end
	// end
	sram_32_65 y_sram (
	  .clka(clk),    // input wire clka
	  .ena(write_y_en),      // input wire ena
	  .wea(write_y_en),      // input wire [0 : 0] wea
	  .addra(write_y_addr),  // input wire [6 : 0] addra
	  .dina(write_y_data),    // input wire [31 : 0] dina
	  
	  .clkb(clk),    // input wire clkb
	  .enb(read_y_en),      // input wire enb
	  .addrb(read_y_addr),  // input wire [6 : 0] addrb
	  .doutb(y_out)  // output wire [31 : 0] doutb
	);
	//read
	// always@(posedge clk or posedge reset)begin
	// 	if(reset)begin
	// 		y_out <= 32'b0;
	// 	end
	// 	else if(read_y_en)begin
	// 		y_out <= y[read_y_addr];
	// 	end
	// 	else begin
	// 		y_out <= y_out;
	// 	end
	// end
	// //write
	// always@(posedge clk)begin
	// 	if(write_y_en)begin
	// 		y[write_y_addr] <= write_y_data;
	// 	end
	// end
	reg [6:0] n_sram_addr;
	reg       n_sram_read_en;

	sram_32_64 n_sram (
	  .clka(clk),    // input wire clka
	  .ena(write_n_en | mod_n_valid),      // input wire ena
	  .wea(write_n_en | mod_n_valid),      // input wire [0 : 0] wea
	  .addra(write_n_en ? write_n_addr : addr_for_n_in),  // input wire [6 : 0] addra
	  .dina(write_n_en ? write_n_data : mod_n_in),    // input wire [31 : 0] dina
	  
	  .clkb(clk),    // input wire clkb
	  .enb(n_sram_read_en),      // input wire enb
	  .addrb(n_sram_addr),  // input wire [6 : 0] addrb
	  .doutb(n_out)  // output wire [31 : 0] doutb
	);
	//read
	wire mod_n_valid_negedge;
	reg  mod_n_valid_reg;
	reg  mod_n_valid_negedge_reg;
	reg  mod_n_valid_negedge_reg_reg;

	always@(posedge clk or posedge reset)begin
		if(reset)begin
			mod_n_valid_reg <= 0;
		end
		else begin
			mod_n_valid_reg <= mod_n_valid;
		end
	end

	always@(posedge clk or posedge reset)begin
		if(reset)begin
			mod_n_valid_negedge_reg <= 0;
			mod_n_valid_negedge_reg_reg <= 0;
		end
		else begin
			mod_n_valid_negedge_reg <= mod_n_valid_negedge;
			mod_n_valid_negedge_reg_reg <= mod_n_valid_negedge_reg;
		end
	end

	assign mod_n_valid_negedge = !mod_n_valid & mod_n_valid_reg;

	always@(*)begin
		if(reset)begin
			n_sram_addr <= 7'b0;
			n_sram_read_en <= 1'b0;
		end
		else if(read_n_en)begin
			n_sram_addr <= read_n_addr;
			n_sram_read_en <= 1'b1;
		end
		else if(read_mod_n_en)begin
			n_sram_addr <= addr_for_n_in;
			n_sram_read_en <= 1'b1;
		end
		else if(Mod_N_R_En)begin
			n_sram_addr <= Mod_N_R_Addr;
			n_sram_read_en <= 1'b1;
		end
		else if(mod_n_valid_negedge_reg)begin
			n_sram_addr <= record_addr_out;
			n_sram_read_en <= 1'b1;
		end
		else begin
			n_sram_addr <= 7'b0;
			n_sram_read_en <= 1'b0;
		end
	end

	always@(posedge clk or posedge reset)begin
		if(reset)begin
			Get_M_Valid_Data <= 0;
		end
		else if(mod_n_valid_negedge_reg_reg)begin
			Get_M_Valid_Data <= n_out;
		end
	end

	assign Read_Mod_N_Data = n_out;

	// always@(posedge clk or posedge reset)begin
	// 	if(reset)begin
	// 		Read_Mod_N_Data <= 0;
	// 	end
	// 	else if(Mod_N_R_En)begin
	// 		Read_Mod_N_Data <= n[Mod_N_R_Addr];
	// 	end
	// 	else if(mod_n_valid_negedge)begin
	// 		Get_M_Valid_Data <= n[record_addr_out];
	// 	end
	// end
	assign Out_Mod_n = n_out;
	
	//write
	// always@(posedge clk)begin
	// 	if(write_n_en)begin
	// 		n[write_n_addr] <= write_n_data;
	// 	end
	// 	else if(mod_n_valid)begin
	// 		n[addr_for_n_in] <= mod_n_in;
	// 	end
	// end
	sram_32_66 v_sram (
	  .clka(clk),    // input wire clka
	  .ena(write_v_en),      // input wire ena
	  .wea(write_v_en),      // input wire [0 : 0] wea
	  .addra(write_v_addr),  // input wire [6 : 0] addra
	  .dina(write_v_data),    // input wire [31 : 0] dina
	  
	  .clkb(clk),    // input wire clkb
	  .enb(read_v_en),      // input wire enb
	  .addrb(read_v_addr),  // input wire [6 : 0] addrb
	  .doutb(v_out)  // output wire [31 : 0] doutb
	);
	//read
	// always@(posedge clk or posedge reset)begin
	// 	if(reset)begin
	// 		v_out <= 32'b0;
	// 	end
	// 	else if(read_v_en)begin
	// 		v_out <= v[read_v_addr];
	// 	end
	// 	else begin
	// 		v_out <= v_out;
	// 	end
	// end
	// //write
	// always@(posedge clk)begin
	// 	if(write_v_en)begin
	// 		v[write_v_addr] <= write_v_data;
	// 	end
	// end

	//x
	always@(*)begin
		case(state)
			`INITIAL: begin read_x_en = 0; write_x_en = 1; write_x_addr = j; write_x_data = write_x_data_FSM; end
			`READINX: begin read_x_en = 0; write_x_en = 1; write_x_addr = j; write_x_data = inp; end 
			`STEP1:	  begin read_x_en = 1; write_x_en = 0; read_x_addr = i;    end
			//`STEP2:	  begin read_x_en = 1; write_x_en = 0; read_x_addr = 0; end  
			default: begin read_x_en = 0; write_x_en = 0; end
		endcase
	end
	//y
	always@(*)begin
		case(state)
			`INITIAL: begin read_y_en = 0; write_y_en = 1; write_y_addr = j; write_y_data = write_y_data_FSM; end
			`READINY: begin read_y_en = 0; write_y_en = 1; write_y_addr = j; write_y_data = inp; end 
			`STEP1:	  begin read_y_en = 1; write_y_en = 0; read_y_addr = j; end
			default: begin read_y_en = 0; write_y_en = 0; end
		endcase
	end
	//n
	always@(*)begin
		case(state)
			 `STEP3AND4: begin read_n_en = 1; write_n_en = 0; read_n_addr = j; end 
			 `STEP5SUBCOND:	begin
								read_n_en = 1; write_n_en = 0; read_n_addr = i;	
							end 
			`STEP5SUBTRACTION:begin
								read_n_en = 1; write_n_en = 0; read_n_addr = i;
							end
			default: 	 begin read_n_en = 0; write_n_en = 0; end
		endcase
	end

	//v
	always@(*)begin
		case(state)
			`INITIAL_V: begin read_v_en = 0; write_v_en = 1; write_v_addr = j; write_v_data = write_v_data_FSM; end
			`STEP1:	  	begin 
								read_v_en = 1; write_v_en = 0; read_v_addr = j;read_v_sub = 0;read_v_sub_real = 0;
								if(k == 1)begin
									read_v_en = 0;
									write_v_en = 1;
									write_v_addr = j;
									write_v_data = s0;
								end    
						end
			`STEP3AND4: begin
								read_v_en = 1; write_v_en = 0; read_v_addr = j;
								if(k == 1)begin
									read_v_en = 0;
									write_v_en = 1;
									write_v_addr = j - 1;
									write_v_data = s0;
								end
						end
			`STEP3AND4LASTV:begin
								read_v_en = 1; write_v_en = 0; read_v_sub = 0;read_v_sub_real = 0;
								case(RSA_Mode)
									0: read_v_addr = 7;
									1: read_v_addr = 9;
									2: read_v_addr = 17;
									3: read_v_addr = 33;
									4: read_v_addr = 65;
									default:;
								endcase
								if(k == 1)begin
									write_v_en = 1;
									read_v_en = 0;
									case(RSA_Mode)
										0: write_v_addr = 6;
										1: write_v_addr = 8;
										2: write_v_addr = 16;
										3: write_v_addr = 32;
										4: write_v_addr = 64;
										default:;
									endcase
									write_v_data = s0;
								end
							end
			`STEP5SUBCOND:	begin
								read_v_en = 1; write_v_en = 0; read_v_addr = i; read_v_sub = 1;		
							end
			`STEP5SUBTRACTION:begin
								read_v_en = 1; write_v_en = 0; read_v_addr = i; read_v_sub_real = 1;
								if(i > 1)begin
									write_v_en = 1;
									write_v_addr = i - 2;
									write_v_data = write_v_data_FSM;
								end
							end
			`STEP2:	  begin read_v_en = 1; write_v_en = 0; read_v_addr = 0; end  
			`WRITEOUT:begin
				read_v_en = 1; write_v_en = 0; read_v_addr = j;
			end
			default: 	begin read_v_en = 0; write_v_en = 0; read_v_sub = 0; read_v_sub_real = 0; end
			
		endcase
	end
	assign outp = v_out;

	always@(posedge clk or posedge reset)begin
		if(reset)begin
			read_v_sub_reg <= 0;
			read_v_sub_real_reg <= 0;
		end
		else begin
			read_v_sub_reg <= read_v_sub;
			read_v_sub_real_reg <= read_v_sub_real;
		end
	end

	always@(*)begin
		case(state)
			`STEP1:		begin x0 = x_out; y0 = y_out; z0 = v_out; end
			`STEP2:		begin x0 = v_out; y0 = nprime0[0]; z0 = 32'b0; end
			`STEP3AND4: begin x0 = m; y0 = j == TOTAL_ADDR_1 + 1 ? 0 :  n_out; z0 = v_out; end
			`STEP3AND4LASTV:begin x0 = 32'b0; y0 = 32'b0; z0 = v_out; end
		endcase
	end

	always @ (posedge clk or posedge reset) begin
		if (reset) begin	// reset state
			//for(jj = 0; jj < `TOTAL_ADDR + 2; jj = jj + 1) begin
			//	v[jj] <= 32'h00000000;
			//end
			// for(jj = 0; jj < `TOTAL_ADDR + 1; jj = jj + 1) begin
			// 	x[jj] <= 32'h00000000;
			// 	y[jj] <= 32'h00000000;
			// end
			//outp <= 32'h00000000;
			c <= 32'h00000000;	// initial C = 0
			i <= 0;
			j <= 0;
			k <= 0;
			state <= `INITIAL;
			write_x_data_FSM <= 32'b0;
			write_y_data_FSM <= 32'b0;
			write_v_data_FSM <= 32'b0;
		end
		else begin
			case (state)
				`INITIAL:begin
					write_x_data_FSM <= 32'b0;
					write_y_data_FSM <= 32'b0;
					write_v_data_FSM <= 32'b0;
					if(j < `TOTAL_ADDR) begin
						j <= j + 1;
					end
					else begin
						j <= 0;
						state <= `INITIAL_V;
					end
				end

				`INITIAL_V:begin
					write_v_data_FSM <= 32'b0;
					if(j < `TOTAL_ADDR + 1) begin
						j <= j + 1;
					end
					else begin
						j <= 0;
						state <= `NONEMONPRO;
					end
				end

				`NONEMONPRO:	// NONEMONPRO state
				begin
					if(start == 1) begin
						state <= `READINX;
					end
				end
				
				`READINX:	// readin state
				begin
					if(j < TOTAL_ADDR_1) begin//6
						// x[j] <= inp;
						
						j <= j + 1;
					end
					else begin
						j <= 0;
						state <= `READINX_TEMP;
					end
				end

				`READINX_TEMP:begin
					state <= `READINX_TEMP_TEMP;
				end

				`READINX_TEMP_TEMP:begin
					state <= `READINY;
				end

				`READINY:	// readin state		There are two full clocks' delay here. ?? No idea about the reason.
				begin
					if(j < TOTAL_ADDR_1) begin
						// y[j] <= inp;
						
						j <= j + 1;
					end
					else begin
						j <= 0;
						state <= `STEP1;
					end
				end	
	
				`STEP1:	// MonPro computation step 1 in ICD document
				begin	// vector(v) <= x[0] * y + prev[vector(v)] + z
					if(k == 0) begin	// first clock: initial input 
						// initial a new multiplier computation
						// x0 <= x[i];
						// y0 <= y[j];
						//z0 <= v[j];
						last_c0 <= c;
						k <= 1;
					end 
					else if(k == 1) begin	// second clock: store output
						// store the output of multiplier
						//v[j] <= s0;
						c <= c0;
						j <= j + 1;
						if(j == TOTAL_ADDR_1 + 1) begin	// loop end
							j <= 0;
							state <= `STEP2;
						end
						k <= 0;
					end 
				end
				
				`STEP2:	// step 2 of ICD document, MonPro section
				begin // m <= (v[0] * n0_prime) mod 2^w
					if(k == 0) begin	// first clock: initial input 
						//x0 <= v[0];
						//y0 <= nprime0[0];
						//z0 <= 32'h00000000;
						last_c0 <= 32'h00000000;
						k <= 1;
					end
					else if(k == 1) begin
						m <= s0;	
						state <= `STEP3AND4;
						k <= 0;
					end
				end
				
				`STEP3AND4:	// step 3 and 4 of ICD document
				begin // vector(v) <= (m * vector(n) + vector(v)) >> WIDTH
				// (C, S) <= v[0] + m * n[0]
					if(k == 0) begin
						//x0 <= m;
						
						if(j == TOTAL_ADDR_1 + 1) begin		// n[`TOTAL_ADDR] <= 0
							//y0 <= 32'h00000000;
						end
						else begin
							//y0 <= n[j];
						end
						
						//z0 <= v[j];
						
						if(j == 0) begin	// initial last_c0 is 0
							last_c0 <= 32'h00000000;
						end
						else begin
							last_c0 <= c;
						end
						
						k <= 1;
					end
					else if(k == 1) begin
						//v[j - 1] <= s0;
						c <= c0;	
						j <= j + 1;	
							
						if(j == TOTAL_ADDR_1 + 1) begin
							j <= 0;
							state <= `STEP3AND4LASTV;
						end
						k <= 0;
					end
				end
				
				`TEST_TRAP:begin

				end

				`STEP3AND4LASTV:	// generate last Z word, and give to V		deal with the last word
				begin // v[s] <= v[s + 1] + C
					if(k == 0) begin
						//x0 <= 32'h00000000;
						//y0 <= 32'h00000000;
						/*case(RSA_Mode)
							0: z0 <= v[7];
							1: z0 <= v[9];
							2: z0 <= v[17];
							3: z0 <= v[33];
							4: z0 <= v[65];
							default:;
						endcase*/

						last_c0 <= c;
						k <= 1;
					end
					else if(k == 1) begin
						/*case(RSA_Mode)
							0:v[6]  <= s0;
							1:v[8]  <= s0;
							2:v[16] <= s0;
							3:v[32] <= s0;
							4:v[64] <= s0;
							default:;
						endcase*/
						// v[`TOTAL_ADDR] <= s0;

						i <= i + 1;		// one turn finished, bigger loop +1
						c <= 32'h00000000;
						state <= `STEP1;
						if(i >= TOTAL_ADDR_1) begin	// end	here is still `TOTAL_ADDR because we only have `TOTAL_ADDR - 1 words of x
							state <= `STEP5SUBCOND;
							i <= TOTAL_ADDR_1;
						end
						k <= 0;
					end
				end
				
				`STEP5SUBCOND:	// if v >= n, v = v - n		first part: subtraction condition 
				begin 
					if(read_v_sub_reg)begin
						if(v_out > n_out) begin	// do v = v - n for all...
							i <= 0;
							last_c0 <= 0;	// carry bit
							state <= `STEP5SUBTRACTION;
						end
						else if(v_out == n_out) begin
							i <= i - 1;
						end
						else begin	// skip subtraction
							i <= 0;
							state <= `WRITEOUT;
						end
					end
					else begin
						i <= i - 1;
					end
				end

				`STEP5SUBTRACTION:	// if v >= n, v = v - n		second part: subtraction 
				begin 	// do v = v - n for all words
					if(read_v_sub_real_reg)begin
						//v[i] <= v[i] - n[i] - last_c0;

						write_v_data_FSM <= v_out - n_out - last_c0;

						if(v_out >= n_out + last_c0) begin	 // last_c0 is the carry bit caused by previous subtraction. now_c0 is carry bit generated by current subtraction.
							now_c0 <= 0;
							last_c0 <= 0;
						end
						else begin	
							now_c0 <= 1;
							last_c0 <= 1;
						end
						
						i <= i + 1;
						if(i == TOTAL_ADDR_1 + 2) begin
							state <= `WRITEOUT;
							i <= 0;
						end
					end
					else begin
						i <= i + 1;
					end
				end
				
				`WRITEOUT:
				begin
					if(j < TOTAL_ADDR_1 + 1) begin
						//outp <= v[j];
						j <= j + 1;
					end
					else begin
						/*for(jj = 0; jj < `TOTAL_ADDR + 2; jj = jj + 1) begin
							v[jj] <= 32'h00000000;
						end
						for(jj = 0; jj < `TOTAL_ADDR; jj = jj + 1) begin
							x[jj] <= 32'h00000000;
							y[jj] <= 32'h00000000;
						end*/
						//outp <= 32'h00000000;
						write_x_data_FSM <= 32'b0;
						write_y_data_FSM <= 32'b0;
						write_v_data_FSM <= 32'b0;
						i <= 0;
						j <= 0;
						state <= `INITIAL_V;
					end
				end
				
			endcase					
		end
	end
	
endmodule