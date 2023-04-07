// MonPro module
// follow this algorithm: http://cs.ucsb.edu/~koc/cs290g/docs/w01/mon1.pdf
// ModExp follows my Master project slides
`include "_parameter.v"

module ModExp	// c ^ d % n		c is the number, d is exponent, n is modulor
(	
	input 			wire 						get_t,
	output 			wire 						Config_Done,

	input 		    wire 						clk,
	input 			wire 						reset,
	input 			wire 						startCompute,	// tell FPGA to start compute
	input 			wire 						getResult,	// tell FPGA to output result
	input 			wire 						message_in_valid,
	input 		    wire [`DATA_WIDTH - 1 : 0]  message_in,
	input 			wire 						exponent_valid,
	input 			wire [`DATA_WIDTH - 1 : 0] 	exponent_in,
	// input 		wire 						r_valid,
	// input 		wire [`DATA_WIDTH - 1 : 0] 	r_param_in,
	// input 		wire t_valid,
	// input 		wire [`DATA_WIDTH - 1 : 0] 	t_param_in,
	input 			wire 						nprime0_valid,
	input 		    wire [`DATA_WIDTH - 1 : 0] 	nprime0_in,
	input 		    wire 						mod_n_valid,
	input 			wire [`DATA_WIDTH - 1 : 0]  mod_n_in,
	output 			reg  [4 : 0] 				stateModExp,	//	for MonExp
	output 			reg  [2 : 0] 				stateModExpSub,

	output 			wire   					 	wait_read,
	input  		    wire     				 	read_en,
	input  			wire 					 	read_mod_n_en,
	input 		    wire [31:0]                 read_addr,
	output 			wire  [`DATA_WIDTH - 1 : 0]  outp,
	output          wire [`DATA_WIDTH - 1 : 0]  Out_Mod_n,
	input  		    wire [4:0] 				    RSA_Mode
);
	// wire [4:0] RSA_Mode = 4;

	// reg [`DATA_WIDTH - 1 : 0] c_in [`TOTAL_ADDR - 1 : 0];	// for c input
	// reg [`DATA_WIDTH - 1 : 0] r_in [`TOTAL_ADDR - 1 : 0];	// for r input
	// reg [`DATA_WIDTH - 1 : 0] t_in [`TOTAL_ADDR - 1 : 0];	// for t input
	reg [`DATA_WIDTH - 1 : 0] d_in [`TOTAL_ADDR - 1 : 0];	// for d input
	reg Slide_Channel_Protect;
	// reg [`DATA_WIDTH - 1 : 0] c_bar [`TOTAL_ADDR - 1 : 0];	// multiple usage, to save regs
	// reg [`DATA_WIDTH - 1 : 0] m_bar [`TOTAL_ADDR - 1 : 0];	// multiple usage, to save regs
	
	reg [31:0] i;	// big loop i
	reg [31:0] k_d1;
	reg [31:0] k_d2;
	
	reg startMonPro;
	reg [`DATA_WIDTH - 1 : 0] inpMonPro;
	wire [4 : 0] stateMonPro;
	wire [`DATA_WIDTH - 1 : 0] outpMonPro;

	wire [`DATA_WIDTH-1 : 0] 		Out_t;
	wire  [31:0]		 		 	Config_t_Addr;
	wire  					 		Config_t_valid;
	wire [`DATA_WIDTH-1 : 0] 		Out_r;
	wire  [31:0]		 		 	Config_r_Addr;
	wire  					 		Config_r_valid;
	reg [31:0] TOTAL_ADDR_1;

	assign wait_read = stateModExp == `COMPLETE;
	
	// MonPro MonPro0 (.clk(clk), .reset(reset), .start(startMonPro), .inp(inpMonPro), .state(stateMonPro), .outp(outpMonPro));
	MonPro MonPro0 (
		.get_t(get_t),
		.RSA_Mode(RSA_Mode),
		.TOTAL_ADDR_1(TOTAL_ADDR_1),
		.read_mod_n_en(read_mod_n_en),
		.Out_Mod_n(Out_Mod_n),
		//Config t
		.Out_t(Out_t),
		.Config_t_Addr(Config_t_Addr),
		.Config_t_valid(Config_t_valid),
		.Out_r(Out_r),
		.Config_r_Addr(Config_r_Addr),
		.Config_r_valid(Config_r_valid),
		.Config_Done(Config_Done),		

		.clk(clk), 
		.reset(reset), 
		.start(startMonPro), 
		.inp(inpMonPro), 

		.nprime0_valid(nprime0_valid),
		.nprime0_in(nprime0_in),
		.mod_n_valid(mod_n_valid),
		.mod_n_in(mod_n_in),
		.state(stateMonPro), 
		.outp(outpMonPro)
	);
	// logic for message_in
	reg [31:0] addr_for_message_in;
	
	always@(posedge clk or posedge reset)begin
		if(reset)begin
			TOTAL_ADDR_1 <= 0;
		end
		else begin
			case(RSA_Mode)
				0: begin TOTAL_ADDR_1 <= 5;  end // 192bit
				1: begin TOTAL_ADDR_1 <= 7;  end // 256bit
				2: begin TOTAL_ADDR_1 <= 15; end // 512bit
				3: begin TOTAL_ADDR_1 <= 31; end // 1024bit
				4: begin TOTAL_ADDR_1 <= 63; end // 2048bit
			endcase
		end
	end

	always@(posedge clk or posedge reset) begin
		if(reset)begin
			addr_for_message_in <= 0;
		end
		else if(message_in_valid | exponent_valid)begin// | r_valid | t_valid
			if(addr_for_message_in == TOTAL_ADDR_1)begin
				addr_for_message_in <= 0;
			end
			else begin
				addr_for_message_in <= addr_for_message_in + 1;
			end
		end
		else if(startCompute)begin
			addr_for_message_in <= 0;
		end
	end

	// // logic for pre_computed parameter

	always@(posedge clk or posedge reset)begin
		if(reset)begin
			d_in[0] <= 0;
		end
		else if(exponent_valid)begin
			d_in[addr_for_message_in] <= exponent_in;
		end
	end

	//////////////////////////////////////////////////////////////////
	//reg [`DATA_WIDTH - 1 : 0] x [`TOTAL_ADDR : 0];
	wire [`DATA_WIDTH - 1 : 0] c_in_out;
	reg 				      read_c_in_en;
	reg [6:0] 				  read_c_in_addr;
	reg 					  write_c_in_en;
	reg [6:0]				  write_c_in_addr;
	reg [`DATA_WIDTH - 1 : 0] write_c_in_data;

	//reg [`DATA_WIDTH - 1 : 0] x [`TOTAL_ADDR : 0];
	wire [`DATA_WIDTH - 1 : 0] d_in_out;
	reg 				      read_d_in_en;
	reg [6:0] 				  read_d_in_addr;
	reg 					  write_d_in_en;
	reg [6:0]				  write_d_in_addr;
	reg [`DATA_WIDTH - 1 : 0] write_d_in_data;

	//reg [`DATA_WIDTH - 1 : 0] x [`TOTAL_ADDR : 0];
	wire [`DATA_WIDTH - 1 : 0] t_in_out;
	reg 				      read_t_in_en;
	reg [6:0] 				  read_t_in_addr;
	reg 					  write_t_in_en;
	reg [6:0]				  write_t_in_addr;
	reg [`DATA_WIDTH - 1 : 0] write_t_in_data;

	//reg [`DATA_WIDTH - 1 : 0] x [`TOTAL_ADDR : 0];
	wire [`DATA_WIDTH - 1 : 0] c_bar_out;
	reg 				      read_c_bar_en;
	reg [6:0] 				  read_c_bar_addr;
	reg 					  write_c_bar_en;
	reg [6:0]				  write_c_bar_addr;
	reg [`DATA_WIDTH - 1 : 0] write_c_bar_data;

	//reg [`DATA_WIDTH - 1 : 0] x [`TOTAL_ADDR : 0];
	wire [`DATA_WIDTH - 1 : 0] m_bar_out;
	reg 				      read_m_bar_en;
	reg [6:0] 				  read_m_bar_addr;
	reg 					  write_m_bar_en;
	reg [6:0]				  write_m_bar_addr;
	reg [`DATA_WIDTH - 1 : 0] write_m_bar_data;

	//reg [`DATA_WIDTH - 1 : 0] x [`TOTAL_ADDR : 0];
	wire [`DATA_WIDTH - 1 : 0] r_in_out;
	reg 				      read_r_in_en;
	reg [6:0] 				  read_r_in_addr;
	reg 					  write_r_in_en;
	reg [6:0]				  write_r_in_addr;
	reg [`DATA_WIDTH - 1 : 0] write_r_in_data;

	sram_32_64 c_in_sram (
	  .clka(clk),    // input wire clka
	  .ena(write_c_in_en | message_in_valid),      // input wire ena
	  .wea(write_c_in_en | message_in_valid),      // input wire [0 : 0] wea
	  .addra(write_c_in_en ? write_c_in_addr : addr_for_message_in),  // input wire [3 : 0] addra
	  .dina(write_c_in_en ? write_c_in_data : message_in),    // input wire [15 : 0] dina
	  
	  .clkb(clk),    // input wire clkb
	  .enb(read_c_in_en),      // input wire enb
	  .addrb(read_c_in_addr),  // input wire [3 : 0] addrb
	  .doutb(c_in_out)  // output wire [15 : 0] doutb
	);
	//read
	/*always@(posedge clk or posedge reset)begin
		if(reset)begin
			c_in_out <= 32'b0;
		end
		else if(read_c_in_en)begin
			c_in_out <= c_in[read_c_in_addr];
		end
		else begin
			c_in_out <= c_in_out;
		end
	end
	//write
	always@(posedge clk)begin
		if(write_c_in_en)begin
			c_in[write_c_in_addr] <= write_c_in_data;
		end
		else if(message_in_valid)begin
			c_in[addr_for_message_in] <= message_in;
		end
	end*/

	sram_32_64 t_in_sram (
	  .clka(clk),    // input wire clka
	  .ena(write_t_in_en | Config_t_valid),      // input wire ena
	  .wea(write_t_in_en | Config_t_valid),      // input wire [0 : 0] wea
	  .addra(write_t_in_en ? write_t_in_addr : Config_t_Addr),  // input wire [3 : 0] addra
	  .dina(write_t_in_en ? write_t_in_data : Out_t),    // input wire [15 : 0] dina
	  
	  .clkb(clk),    // input wire clkb
	  .enb(read_t_in_en),      // input wire enb
	  .addrb(read_t_in_addr),  // input wire [3 : 0] addrb
	  .doutb(t_in_out)  // output wire [15 : 0] doutb
	);
	//read
	/*always@(posedge clk or posedge reset)begin
		if(reset)begin
			t_in_out <= 32'b0;
		end
		else if(read_t_in_en)begin
			t_in_out <= t_in[read_t_in_addr];
		end
		else begin
			t_in_out <= t_in_out;
		end
	end
	//write
	always@(posedge clk)begin
		if(write_t_in_en)begin
			t_in[write_t_in_addr] <= write_t_in_data;
		end
		else if(Config_t_valid)begin
			t_in[Config_t_Addr] <= Out_t;
		end
	end*/

	sram_32_64 c_bar_sram (
	  .clka(clk),    // input wire clka
	  .ena(write_c_bar_en),      // input wire ena
	  .wea(write_c_bar_en),      // input wire [0 : 0] wea
	  .addra(write_c_bar_addr),  // input wire [3 : 0] addra
	  .dina(write_c_bar_data),    // input wire [15 : 0] dina
	  
	  .clkb(clk),    // input wire clkb
	  .enb(read_c_bar_en),      // input wire enb
	  .addrb(read_c_bar_addr),  // input wire [3 : 0] addrb
	  .doutb(c_bar_out)  // output wire [15 : 0] doutb
	);
	//read
	/*always@(posedge clk or posedge reset)begin
		if(reset)begin
			c_bar_out <= 32'b0;
		end
		else if(read_c_bar_en)begin
			c_bar_out <= c_bar[read_c_bar_addr];
		end
		else begin
			c_bar_out <= c_bar_out;
		end
	end
	//write
	always@(posedge clk)begin
		if(write_c_bar_en)begin
			c_bar[write_c_bar_addr] <= write_c_bar_data;
		end
	end*/

	sram_32_64 m_bar_sram (
	  .clka(clk),    // input wire clka
	  .ena(write_m_bar_en),      // input wire ena
	  .wea(write_m_bar_en),      // input wire [0 : 0] wea
	  .addra(write_m_bar_addr),  // input wire [3 : 0] addra
	  .dina(write_m_bar_data),    // input wire [15 : 0] dina
	  
	  .clkb(clk),    // input wire clkb
	  .enb(read_m_bar_en | read_en),      // input wire enb
	  .addrb(read_m_bar_en ? read_m_bar_addr : read_addr),  // input wire [3 : 0] addrb
	  .doutb(m_bar_out)  // output wire [15 : 0] doutb
	);
	assign outp = m_bar_out;
	//read
	/*always@(posedge clk or posedge reset)begin
		if(reset)begin
			m_bar_out <= 32'b0;
		end
		else if(read_m_bar_en)begin
			m_bar_out <= m_bar[read_m_bar_addr];
		end
		else if(read_en)begin
			m_bar_out <= m_bar[read_addr];
		end
		else begin
			m_bar_out <= m_bar_out;
		end
	end
	

	//write
	always@(posedge clk)begin
		if(write_m_bar_en)begin
			m_bar[write_m_bar_addr] <= write_m_bar_data;
		end
	end*/

	sram_32_64 r_in_sram (
	  .clka(clk),    // input wire clka
	  .ena(write_r_in_en | Config_r_valid),      // input wire ena
	  .wea(write_r_in_en | Config_r_valid),      // input wire [0 : 0] wea
	  .addra(write_r_in_en ? write_r_in_addr : Config_r_Addr),  // input wire [3 : 0] addra
	  .dina(write_r_in_en ? write_r_in_data : Out_r),    // input wire [15 : 0] dina
	  
	  .clkb(clk),    // input wire clkb
	  .enb(read_r_in_en),      // input wire enb
	  .addrb(read_r_in_addr),  // input wire [3 : 0] addrb
	  .doutb(r_in_out)  // output wire [15 : 0] doutb
	);
	//read
	/*always@(posedge clk or posedge reset)begin
		if(reset)begin
			r_in_out <= 32'b0;
		end
		else if(read_r_in_en)begin
			r_in_out <= r_in[read_r_in_addr];
		end
		else begin
			r_in_out <= r_in_out;
		end
	end
	//write
	always@(posedge clk)begin
		if(write_r_in_en)begin
			r_in[write_r_in_addr] <= write_r_in_data;
		end
		else if(Config_r_valid)begin
			r_in[Config_r_Addr] <= Out_r;
		end
	end*/

	//inpMonPro
	always@(*)begin
		case(stateModExp)
			`CALC_C_BAR: begin
							case(stateModExpSub)
								`INP1 :begin inpMonPro = c_in_out; end
								`INP2 :begin inpMonPro = t_in_out; end
			 					
			 			 	endcase
			 			 end

			`BIGLOOP:	begin
							case(stateModExpSub)
								`INP1 :begin inpMonPro = m_bar_out; end
								`INP2 :begin inpMonPro = m_bar_out; end
			 					
			 			 	endcase
						end
			`CALC_M_BAR_C_BAR:	begin
							case(stateModExpSub)
								`INP1 :begin inpMonPro = m_bar_out; end
								`INP2 :begin inpMonPro = c_bar_out; end
			 					
			 			 	endcase
						end
			`CALC_M_BAR_1:	begin
							case(stateModExpSub)
								`INP1 :begin inpMonPro = m_bar_out; end
								`INP2 :begin 
										if(i == 2)begin
											inpMonPro = 32'h00000001;
										end
										else begin
											inpMonPro = 32'h00000000;
										end
								 end
			 					
			 			 	endcase
						end
			//`STEP2:	  begin read_x_en = 1; write_x_en = 0; read_x_addr = 0; end  
			default: begin inpMonPro = 32'b0; end
		endcase
	end

	//c_in
	always@(*)begin
		case(stateModExp)
			`CALC_C_BAR: begin
							case(stateModExpSub)
								`INP1 :begin read_c_in_en = 1; write_c_in_en = 0; read_c_in_addr = i; end
			 					default:begin read_c_in_en = 0; write_c_in_en = 0;  end
			 			 	endcase
			 			 end
			
			//`STEP2:	  begin read_x_en = 1; write_x_en = 0; read_x_addr = 0; end  
			default: begin read_c_in_en = 0; write_c_in_en = 0; end
		endcase
	end

	//t_in
	always@(*)begin
		case(stateModExp)
			`CALC_C_BAR: begin
							case(stateModExpSub)
								`INP2 :	begin 
											if(i>0)begin
												read_t_in_en = 1; write_t_in_en = 0; read_t_in_addr = i - 1;
											end 
											else begin
												read_t_in_en = 0; write_t_in_en = 0;
											end
								end
								default:begin  read_t_in_en = 0; write_t_in_en = 0; end

			 			 	endcase
			end
			
			//`STEP2:	  begin read_x_en = 1; write_x_en = 0; read_x_addr = 0; end  
			default: begin read_t_in_en = 0; write_t_in_en = 0; end
		endcase
	end

	//c_bar
	always@(*)begin
		case(stateModExp)
			`CALC_C_BAR: begin
							case(stateModExpSub)
								`OUTPINS :begin 
												if(i<=TOTAL_ADDR_1)begin
													read_c_bar_en = 0; write_c_bar_en = 1; write_c_bar_addr = i; write_c_bar_data = outpMonPro;
												end
												else begin
													read_c_bar_en = 0; write_c_bar_en = 0;
												end
										  end
			 					default: begin read_c_bar_en = 0; write_c_bar_en = 0; end
			 			 	endcase
			 			 end
			 `CALC_M_BAR_C_BAR:begin
							case(stateModExpSub)
								`INP2 :	begin 
											if(i>0)begin
												read_c_bar_en = 1; write_c_bar_en = 0; read_c_bar_addr = i - 1;
											end 
											else begin
												read_c_bar_en = 0; write_c_bar_en = 0;
											end
								end

								default:begin read_c_bar_en = 0; write_c_bar_en = 0; 	end
							endcase
						end
			
			//`STEP2:	  begin read_x_en = 1; write_x_en = 0; read_x_addr = 0; end  
			default: begin read_c_bar_en = 0; write_c_bar_en = 0; end
		endcase
	end

	//m_bar
	always@(*)begin
		case(stateModExp)
			`CALC_C_BAR: begin
							case(stateModExpSub)
								`OUTPINS :begin 
												if(i>0 && i <= TOTAL_ADDR_1 + 1)begin
													read_m_bar_en = 0; write_m_bar_en = 1; write_m_bar_addr = i - 1; write_m_bar_data = r_in_out;
												end
												else begin
													read_m_bar_en = 0; write_m_bar_en = 0;
												end
										  end
			 					default:begin read_m_bar_en = 0; write_m_bar_en = 0; end
			 			 	endcase
			 			 end
			`BIGLOOP: 	begin
							case(stateModExpSub)
								`INP1 :begin read_m_bar_en = 1; write_m_bar_en = 0; read_m_bar_addr = i; end
								`INP2 :	begin 
												if(i>0)begin
													read_m_bar_en = 1; write_m_bar_en = 0; read_m_bar_addr = i - 1;
												end 
												else begin
													read_m_bar_en = 0; write_m_bar_en = 0;
												end
										end
								`OUTPINS: begin
										if(i<=TOTAL_ADDR_1)begin
											read_m_bar_en = 0; write_m_bar_en = 1; write_m_bar_addr = i; write_m_bar_data = outpMonPro;
										end
										else begin
											read_m_bar_en = 0; write_m_bar_en = 0;
										end
								end
								default:begin read_m_bar_en = 0; write_m_bar_en = 0; 	end
							endcase
						end

			`CALC_M_BAR_C_BAR:begin
							case(stateModExpSub)
								`INP1 :begin read_m_bar_en = 1; write_m_bar_en = 0; read_m_bar_addr = i; end
								`OUTPINS: begin
										if(i<=TOTAL_ADDR_1 && !Slide_Channel_Protect)begin
											read_m_bar_en = 0; write_m_bar_en = 1; write_m_bar_addr = i; write_m_bar_data = outpMonPro;
										end
										else begin
											read_m_bar_en = 0; write_m_bar_en = 0;
										end
								end
								default:begin read_m_bar_en = 0; write_m_bar_en = 0; 	end
							endcase
						end

			`CALC_M_BAR_1:begin
							case(stateModExpSub)
								`INP1 :begin read_m_bar_en = 1; write_m_bar_en = 0; read_m_bar_addr = i; end
								`OUTPINS: begin
										if(i<=TOTAL_ADDR_1)begin
											read_m_bar_en = 0; write_m_bar_en = 1; write_m_bar_addr = i; write_m_bar_data = outpMonPro;
										end
										else begin
											read_m_bar_en = 0; write_m_bar_en = 0;
										end
								end
								default:begin read_m_bar_en = 0; write_m_bar_en = 0; 	end
							endcase
						end
			
			//`STEP2:	  begin read_x_en = 1; write_x_en = 0; read_x_addr = 0; end  
			default: begin read_m_bar_en = 0; write_m_bar_en = 0; end
		endcase
	end

	//r_in
	always@(*)begin
		case(stateModExp)
			`CALC_C_BAR: begin
							case(stateModExpSub)
								`OUTPINS :begin 
												if(i<=TOTAL_ADDR_1)begin
													read_r_in_en = 1; write_r_in_en = 0; read_r_in_addr = i;
												end
												else begin
													read_r_in_en = 0; write_r_in_en = 0;
												end
										  end
			 					
			 			 	endcase
			 			 end
			
			//`STEP2:	  begin read_x_en = 1; write_x_en = 0; read_x_addr = 0; end  
			default: begin read_r_in_en = 0; write_r_in_en = 0; end
		endcase
	end

	wire [11:0] rand_num;

	LSFR_Random x_LSFR_Random(
    .CLK(clk),
    .RST_N(!reset),
    .gen_random(1'b1),
    .load_data(1'b0),
    
    .rand_num(rand_num)
);
	always @ (posedge clk or posedge reset) begin
		if (reset) begin	// reset all...
			i <= 0;
			Slide_Channel_Protect <= 0;
			stateModExpSub <= `NOTASK;
			stateModExp <= `NONE;
			k_d1 <= TOTAL_ADDR_1;
			k_d2 <= `DATA_WIDTH - 1;
		end
		else begin
			case (stateModExp)
				`NONE: // initial state
				begin
					if(startCompute) begin
						stateModExp <= `CALC_C_BAR;
						k_d1 <= TOTAL_ADDR_1;
						k_d2 <= `DATA_WIDTH - 1;
					end	
				end
				
				`CALC_C_BAR:	// calculate c_bar <= MonPro(c, t) and copy: m_bar <= r
				begin
					case (stateModExpSub)
						`NOTASK: 
						begin	
							startMonPro <= 1;
							stateModExpSub <= `INP1;

						end
						
						`INP1 :
						begin
							//inpMonPro <= c_in[i];
							startMonPro <= 0;
							i <= i + 1;
							if(i == TOTAL_ADDR_1 + 1) begin
								i <= 0;
								stateModExpSub <= `INP2;
							end
						end
						
						`INP2:
						begin
							if(i <= 0) begin		// need some delay here...
								i <= i + 1;
							end
							else begin
								//inpMonPro <= t_in[i - 1];
								i <= i + 1;
								if(i > TOTAL_ADDR_1 + 1) begin
									i <= 0;
									stateModExpSub <= `WAIT;
								end
							end
						end
						
						`WAIT:
						begin
							if(stateMonPro == `WRITEOUT) begin
								stateModExpSub <= `OUTPINS;
							end
						end
						
						`OUTPINS:
						begin
							//c_bar[i] <= outpMonPro;
							//m_bar[i] <= r_in[i];
							i <= i + 1;
							if(i == TOTAL_ADDR_1 + 1) begin
								//inpMonPro <= 32'h00000000;
								i <= 0;
								stateModExpSub <= `RESET;
								
								startMonPro <= 0;
							end
						end
						`RESET:begin
							if(stateMonPro == `NONEMONPRO) begin
								stateModExpSub <= `NOTASK;
								stateModExp <= `GET_K_D;
							end
						end


					endcase
				end

				`MODEXP_TEST_TRAP:begin
					
				end
			
				`GET_K_D:	// a clock to initial the leftmost 1 in d <= k_d
				begin
					if(d_in[k_d1][k_d2] == 1) begin
						$display("d_in[%d][%d] <= %d", k_d1, k_d2, d_in[k_d1][k_d2]);
						stateModExp <= `BIGLOOP;
					end
					else begin
						if(k_d2 == 0) begin
							k_d1 <= k_d1 - 1;
							k_d2 <= `DATA_WIDTH - 1;
						end
						else begin
							k_d2 <= k_d2 - 1;
						end
					end
				end
			
				`BIGLOOP:	// for i <= k_d1 * `DATA_WIDTH + k_d2 downto 0
				begin
					case (stateModExpSub)	// m_bar <= MonPro(m_bar, m_bar)
						`NOTASK: 
						begin	
							startMonPro <= 1;
							stateModExpSub <= `INP1;
						end
						
						`INP1:
						begin
							//inpMonPro <= m_bar[i];
							startMonPro <= 0;
							i <= i + 1;
							if(i == TOTAL_ADDR_1 + 1) begin
								i <= 0;
								stateModExpSub <= `INP2;
							end
						end
						
						`INP2:
						begin
							if(i <= 0) begin		// need some delay here...
								i <= i + 1;
							end
							else begin
								//inpMonPro <= m_bar[i - 1];
								i <= i + 1;
								if(i > TOTAL_ADDR_1 + 1) begin
									i <= 0;
									stateModExpSub <= `WAIT;
								end
							end
						end
						
						`WAIT:
						begin
							if(stateMonPro == `WRITEOUT) begin
								stateModExpSub <= `OUTPINS;
							end
						end
						
						`OUTPINS:
						begin
							//m_bar[i] <= outpMonPro;
							i <= i + 1;
							if(i == TOTAL_ADDR_1 + 1) begin
								i <= 0;
								//inpMonPro <= 32'h00000000;
								stateModExpSub <= `RESET;
								startMonPro <= 0;
							end
						end

						`RESET:begin
							if(stateMonPro == `NONEMONPRO) begin
								stateModExpSub <= `NOTASK;
								//stateModExp <= `GET_K_D;
								$display("k_d1: %d, k_d2: %d", k_d1, k_d2);
								if(d_in[k_d1][k_d2] == 1) begin
									stateModExp <= `CALC_M_BAR_C_BAR;	// go to m_bar <= MonPro(m_bar, c_bar)
									$display("CALC_M_BAR_C_BAR");
								end
								else if(rand_num > 12'b100000000000)begin
								 	stateModExp <= `CALC_M_BAR_C_BAR;	// go to m_bar <= MonPro(m_bar, c_bar)
								 	Slide_Channel_Protect <= 1;
								 	$display("Slide_Channel_Protect");
								end
								else begin
									if(k_d1 <= 0 && k_d2 <= 0)begin
										stateModExp <= `CALC_M_BAR_1;
										$display("CALC_M_BAR_1");
									end
									else if(k_d2 == 0) begin	// down 1 of d
										k_d1 <= k_d1 - 1;
										k_d2 <= `DATA_WIDTH - 1;
									end 
									else begin
										k_d2 <= k_d2 - 1;
									end
								end
							end
						end

					endcase
				end
				
				`CALC_M_BAR_C_BAR:	// m_bar <= MonPro(m_bar, c_bar)
				begin
					case (stateModExpSub)	
						`NOTASK: 
						begin
							startMonPro <= 1;
							stateModExpSub <= `INP1;
							i <= 0;
						end
						
						`INP1:
						begin
							//inpMonPro <= m_bar[i];
							i <= i + 1;
							startMonPro <= 0;
							if(i == TOTAL_ADDR_1 + 1) begin
								i <= 0;
								stateModExpSub <= `INP2;
							end
						end
						
						`INP2:
						begin
							if(i <= 0) begin		// need some delay here...
								i <= i + 1;
							end
							else begin
								//inpMonPro <= c_bar[i - 1];
								i <= i + 1;
								if(i > TOTAL_ADDR_1 + 1) begin
									i <= 0;
									stateModExpSub <= `WAIT;
								end
							end
						end
						
						`WAIT:
						begin
							if(stateMonPro == `WRITEOUT) begin
								stateModExpSub <= `OUTPINS;
							end
						end
						
						`OUTPINS:
						begin
							//m_bar[i] <= outpMonPro;
							i <= i + 1;
							if(i == TOTAL_ADDR_1 + 1) begin
								i <= 0;
								//inpMonPro <= 32'h00000000;
								stateModExpSub <= `RESET;
								startMonPro <= 0;
								
							end
						end

						`RESET:begin
							if(stateMonPro == `NONEMONPRO) begin
								stateModExpSub <= `NOTASK;
								Slide_Channel_Protect <= 0;
								//stateModExp <= `GET_K_D;
								$display("k_d1: %d, k_d2: %d", k_d1, k_d2);
								if(k_d1 <= 0 && k_d2 <= 0)
									stateModExp <= `CALC_M_BAR_1;
								else if(k_d2 == 0) begin	// down 1 of d
									k_d1 <= k_d1 - 1;
									k_d2 <= `DATA_WIDTH - 1;
									stateModExp <= `BIGLOOP;
								end 
								else begin
									k_d2 <= k_d2 - 1;
									stateModExp <= `BIGLOOP;
								end
							end
						end
					endcase
				end		
	
				
				`CALC_M_BAR_1:	// m = MonPro(1, m_bar)
				begin
					case (stateModExpSub)	
						`NOTASK: 
						begin	
							startMonPro <= 1;
							stateModExpSub <= `INP1;
							i <= 0;
						end
						
						`INP1:
						begin
							//inpMonPro <= m_bar[i];
							startMonPro <= 0;
							i <= i + 1;
							if(i == TOTAL_ADDR_1 + 1) begin
								i <= 0;
								stateModExpSub <= `INP2;
							end
						end
						
						`INP2:
						begin
							if(i <= 0) begin		// need some delay here...
								i <= i + 1;
							end
							else begin
								if(i == 1) begin
									//inpMonPro <= 128'h00000000000000000000000000000001;
								end
								else begin
									//inpMonPro <= 32'h00000000;
								end
								i <= i + 1;
								if(i > TOTAL_ADDR_1 + 1) begin
									i <= 0;
									stateModExpSub <= `WAIT;
								end
							end
						end
						
						`WAIT:
						begin
							if(stateMonPro == `WRITEOUT) begin
								stateModExpSub <= `OUTPINS;
							end
						end
						
						`OUTPINS:
						begin
							//m_bar[i] <= outpMonPro;
							i <= i + 1;
							if(i == TOTAL_ADDR_1 + 1) begin
								i <= 0;
								//inpMonPro <= 32'h00000000;
								stateModExpSub <= `RESET;
								//stateModExp <= `COMPLETE;
								startMonPro <= 0;
							end
						end

						`RESET:begin
							if(stateMonPro == `NONEMONPRO) begin
								stateModExpSub <= `NOTASK;
								stateModExp <= `COMPLETE;
								
							end
						end
					endcase	
				end
				
				`COMPLETE:	// Use a getResult signal to start this output
				begin
					// if(getResult) begin
						stateModExp <= `OUTPUT_RESULT;
					// end				
				end
				
				`OUTPUT_RESULT:	// output 4096 bits result (m_bar) to output buffer!
				begin
					// outp = m_bar[i];
					// $display("outp[%d]: %h", i, outp);
					// i <= i + 1;
					// if(i == `TOTAL_ADDR - 1) begin
						i <= 0;
						stateModExp <= `NONE;
						
					// end
				end
				
				`TERMINAL:
				begin
					//outp <= 32'h00000000;
				end
			endcase
		end
	end
	
endmodule
	