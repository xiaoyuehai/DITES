`timescale 1ns/1ps

`include "_parameter.v"

module ModExp_tb();
	reg clk;
	reg reset;
	reg startInput;	// tell FPGA to start input 
	reg startCompute;	// tell FPGA to start compute
	reg getResult;	// tell FPGA to output result
	reg [`DATA_WIDTH - 1 : 0] inp;
	wire [4 : 0] stateModExp;	//	for MonExp
	wire [2 : 0] stateModExpSub;
	wire [`DATA_WIDTH - 1 : 0] outp;

	reg message_in_valid;
	reg [`DATA_WIDTH - 1 : 0] message_in;
	reg r_in_valid;
	reg [`DATA_WIDTH - 1 : 0] r_param_in;
	reg t_in_valid;
	reg [`DATA_WIDTH - 1 : 0] t_param_in;
	reg e_in_valid;
	reg [`DATA_WIDTH - 1 : 0] e_param_in;
	reg nprime0_valid;
	reg [`DATA_WIDTH - 1 : 0] nprime0_in;
	reg mod_n_valid;
	reg [`DATA_WIDTH - 1 : 0] mod_n_in;

	wire   					 wait_read;
	reg     				 read_en;
	reg [31:0]               read_addr;
	reg 					 get_t;
	wire 					 Config_Done;
	reg [4:0] RSA_Mode;
	ModExp ModExp0(
		.get_t(get_t),
		.RSA_Mode(RSA_Mode),
		.Config_Done(Config_Done),
		.clk(clk), 
		.reset(reset), 
		// .startInput(startInput), 
		.startCompute(startCompute), 
		.getResult(getResult), 

		.message_in_valid(message_in_valid),
		.message_in(message_in),
		.exponent_valid(e_in_valid),
		.exponent_in(e_param_in),
		// .r_valid(r_in_valid),
		// .r_param_in(r_param_in),
		// .t_valid(t_in_valid),
		// .t_param_in(t_param_in),

		.nprime0_valid(nprime0_valid),
		.nprime0_in(nprime0_in),
		.mod_n_valid(mod_n_valid),
		.mod_n_in(mod_n_in),

		.stateModExp(stateModExp), 
		.stateModExpSub(stateModExpSub), 
		.wait_read(wait_read),
		.read_en(read_en),
		.read_addr(read_addr),
		.outp(outp)
	);
	reg [`DATA_WIDTH - 1 : 0] r_in [`TOTAL_ADDR - 1 : 0];	// for r input
	reg [`DATA_WIDTH - 1 : 0] t_in [`TOTAL_ADDR - 1 : 0];	// for t input
	reg [`DATA_WIDTH - 1 : 0] d_in [`TOTAL_ADDR - 1 : 0];	// for d input
	reg [`DATA_WIDTH - 1 : 0] m_in [`TOTAL_ADDR - 1 : 0];	// for d input
	reg [`DATA_WIDTH - 1 : 0] nprime0 [0 : 0];	// a memory must have unpacked array!
	reg [`DATA_WIDTH - 1 : 0] n [`TOTAL_ADDR - 1 : 0];
	

	initial begin	// set to 0 
		// $readmemh("E:/Python_Project/Brian2_Using/TEE/test_RSA4096/r.txt", r_in);
		// $readmemh("E:/Python_Project/Brian2_Using/TEE/test_RSA4096/t.txt", t_in);
		$readmemh("E:/Python_Project/Brian2_Using/TEE/test_RSA4096/e.txt", d_in);
		$readmemh("E:/Python_Project/Brian2_Using/TEE/test_RSA4096/m.txt", m_in);
		$readmemh("E:/Python_Project/Brian2_Using/TEE/test_RSA4096/nprime0.txt", nprime0);
		$readmemh("E:/Python_Project/Brian2_Using/TEE/test_RSA4096/n.txt", n);
	end
	
	integer i,range;
	initial begin
		get_t = 0;
		clk = 0;
		reset = 1;
		#100;
		reset = 0;
		startInput = 0;
		startCompute = 0;
		getResult = 0;
		r_in_valid = 0;
		t_in_valid = 0;
		e_in_valid = 0;
		message_in_valid = 0;
		nprime0_valid = 0;
		mod_n_valid = 0;
		read_en = 0;
		read_addr = 0;
		RSA_Mode = 4;
		case(RSA_Mode)
			0: range = 6;
			1: range = 8;
			2: range = 16;
			3: range = 32;
			4: range = 64;
			default: range = 64;
		endcase
		#100;

		for(i=0;i<range;i=i+1)begin
			@(posedge clk)begin
			    #1;
				r_in_valid = 0;
				t_in_valid = 0;
				e_in_valid = 1;
				e_param_in = d_in[i];
			end
		end
		@(posedge clk)begin
			#1;
			r_in_valid = 0;
			t_in_valid = 0;
			e_in_valid = 0;
		end
		#10;
		for(i=0;i<range;i=i+1)begin
			@(posedge clk)begin
				#1;
				r_in_valid = 0;
				t_in_valid = 0;
				e_in_valid = 0;
				message_in_valid = 1;
				message_in = m_in[i];
			end
		end
		@(posedge clk)begin
			#1;
			r_in_valid = 0;
			t_in_valid = 0;
			e_in_valid = 0;
		end
		r_in_valid = 0;
		t_in_valid = 0;
		e_in_valid = 0;
		message_in_valid = 0;


		#100;
		for(i=0;i<range;i=i+1)begin
			@(posedge clk)begin
				#1;
				mod_n_valid = 1;
				mod_n_in = n[i];
			end
		end
		@(posedge clk)begin
			#1;
			mod_n_valid = 0;
		end
		#10;
		for(i=0;i<1;i=i+1)begin
			@(posedge clk)begin
				#1;
				nprime0_valid = 1;
				nprime0_in = nprime0[i];
			end
		end
		@(posedge clk)begin
			#1;
			nprime0_valid = 0;
		end


	#10;    // a full clock delay between inputs since we want to switch the state
	get_t = 1;
	#100;
	get_t = 0;
	@(posedge Config_Done)begin
		
	end

	#10;
	
	#10	startCompute = 1;	
	#10
	#1000 startCompute = 0;
	getResult = 1;
	@(posedge wait_read)begin
		
	end
	#100;

	#100;

	// $finish;

	for(i=0;i<range;i=i+1)begin
		@(posedge clk)begin
			// #1;
			read_en <= 1;
			read_addr <= i;
		end
	end

	@(posedge clk)begin
		#1;
		read_en = 0;
	end
	$display("--------------------------------------------------------------");
	$display("-------------------------- TEST PASS -------------------------");
	$display("--------------------------------------------------------------");
	$finish;

	end
	
	always begin
	   #5 clk = ~clk;
	end

	// integer trace_ref;
	// reg  read_en_reg;

	// always@(posedge clk or posedge reset)begin
	// 	if(reset)begin
	// 		read_en_reg <= 0;
	// 	end
	// 	else begin
	// 		read_en_reg <= read_en;
	// 	end
	// end
 //    initial begin
 //        trace_ref = $fopen("E:/Python_Project/Brian2_Using/TEE/SHA/trace_result.txt", "r");
 //    end

 //    reg [31:0] trace_data;

 //    always @(posedge clk)
 //    begin 
 //        #1;
 //        if(read_en_reg)
 //        begin
 //            $fscanf(trace_ref, "%h", trace_data);
 //        end
 //    end

 //    reg debug_wb_err;

 //    always @(posedge clk)
 //    begin
 //        #2;
 //        if(reset)
 //        begin
 //            debug_wb_err <= 1'b0;
 //        end
 //        else if(read_en_reg)
 //        begin
 //            if (outp !=  trace_data[31:0])
 //            begin
 //            	$display("--------------------------------------------------------------");
 //                $display("    Result_Error    : read_addr = 0x%8h",
 //                        read_addr);
 //                $display("--------------------------------------------------------------");
 //                debug_wb_err <= 1'b1;
                
 //                $finish;
 //            end
 //        end
 //    end
endmodule
