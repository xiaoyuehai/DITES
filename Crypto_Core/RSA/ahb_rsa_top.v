`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/11 21:04:07
// Design Name: 
// Module Name: ahb_rsa_top
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
`define MESSAGE_BASE 	32'h20020000
`define MOD_N_BASE   	32'h20020004
// `define R_BASE       	32'h20020000
// `define T_BASE       	32'h20020600
`define E_BASE       	32'h20020008
`define NPRIME0_BASE 	32'h2002000C
`define START_COMPUTE   32'h20020010
`define PARAM_CAL       32'h20020014
`define GET_INTR_STATUS 32'h20020018
`define CLEAR_INTR      32'h2002001C
`define CONFIG_RSA_MODE 32'h20020020
`define RSA_CONFIG_BUSY 32'h20020024
`define RSA_READ_MOD_N  32'h20020028

// `define MESSAGE_OFFSET 	32'h200201ff
// `define MOD_N_OFFSET   	32'h200203ff
// `define R_OFFSET       	32'h200205ff
// `define T_OFFSET       	32'h200207ff
// `define E_OFFSET       	32'h200209ff
`define READ_RES_BASE   32'h20020C00
`define READ_RES_OFFSET 32'h20020Dff

// Register

// `define GET_RESULT_CIT  32'h20020B04  
// `define INTR_FOR_READ   32'h20020B08 


module ahb_rsa_top(
	haddr,
	hclk,
	hprot,
	hrdata,
	hready,
	hresp,
	hrst_b,
	hsel,
	hsize,
	htrans,
	hwdata,
	hwrite,
	intr
    );

	input 	[31:0] 	haddr;
	input   	 	hclk;
	output 		 	hready;
	input 		 	hrst_b;
	input 	     	hsel;
	input 	[31:0] 	hwdata;
	input        	hwrite;
	output	[31:0] 	hrdata;
	output       	intr;
    output  [1 :0] 	hresp;
    input   [3 :0]  hprot; 
    input   [2 :0]  hsize;
    input   [1 :0]  htrans;
	wire 	[31:0] 	haddr;
	wire   	 		hclk;
	wire 		 	hready;
	wire 		 	hrst_b;
	wire 	     	hsel;
	wire 	[31:0] 	hwdata;
	wire        	hwrite;
	wire	[31:0] 	hrdata;
	wire       		intr;
    wire  	[1 :0] 	hresp;
    wire   	[3 :0]  hprot; 
    wire   	[2 :0]  hsize;
    wire   	[1 :0]  htrans;

    wire 	[4 : 0]	stateModExp;	//	for MonExp
	wire 	[2 : 0] stateModExpSub;
    reg      		message_valid;
    reg             mod_n_valid;
    reg    			r_valid;
    reg    			t_valid;
    reg             e_valid;
    reg     		nprime0_valid;
    reg 			startCompute;
    reg    			getResult;
    wire         	read_en;
    wire [6:0]      read_addr = haddr[8:2];
    wire [31:0] 	outp;
    wire [31:0]     Out_Mod_n;
    reg             get_t;
    wire            Config_Done;
    wire            intr_cal;

    reg             Config_RSA_Mode_En;
    reg     [4:0]   RSA_Mode;
    wire            read_mod_n_en;


    reg             intr_reg;
    reg [31:0]      intr_status_reg;
    reg             intr_clear;
    reg             config_busy;

    ModExp ModExp0(
        .get_t(get_t),
        .RSA_Mode(RSA_Mode),
        .Config_Done(Config_Done),
		.clk(hclk), 
		.reset(!hrst_b), 
		// .startInput(startInput), 
		.startCompute(startCompute), 
		.getResult(getResult), 

		.message_in_valid(message_valid),
		.message_in(hwdata),
		.exponent_valid(e_valid),
		.exponent_in(hwdata),
		// .r_valid(r_valid),
		// .r_param_in(hwdata),
		// .t_valid(t_valid),
		// .t_param_in(hwdata),

		.nprime0_valid(nprime0_valid),
		.nprime0_in(hwdata),
		.mod_n_valid(mod_n_valid),
		.mod_n_in(hwdata),

		.stateModExp(stateModExp), 
		.stateModExpSub(stateModExpSub), 
		.wait_read(intr_cal),
		.read_en(read_en),
        .read_mod_n_en(read_mod_n_en),
		.read_addr(read_addr),
		.outp(outp),
        .Out_Mod_n(Out_Mod_n)
	);

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            get_t <= 0;
        end
        else if(haddr == `PARAM_CAL && hwrite && hsel)begin
            get_t <= 1;
        end
        else begin
            get_t <= 0;
        end
    end

    always@(posedge hclk or negedge hrst_b)begin
    	if(!hrst_b)begin
    		message_valid <= 0;
    	end
    	else if(haddr == `MESSAGE_BASE && hwrite && hsel)begin
    		message_valid <= 1;
    	end
    	else begin
    		message_valid <= 0;
    	end
    end

    always@(posedge hclk or negedge hrst_b)begin
    	if(!hrst_b)begin
    		mod_n_valid <= 0;
    	end
    	else if(haddr == `MOD_N_BASE && hwrite && hsel)begin
    		mod_n_valid <= 1;
    	end
    	else begin
    		mod_n_valid <= 0;
    	end
    end

    // always@(posedge hclk or negedge hrst_b)begin
    // 	if(!hrst_b)begin
    // 		r_valid <= 0;
    // 	end
    // 	else if(haddr >= `R_BASE && haddr <= `R_OFFSET && hwrite && hsel)begin
    // 		r_valid <= 1;
    // 	end
    // 	else begin
    // 		r_valid <= 0;
    // 	end
    // end

    // always@(posedge hclk or negedge hrst_b)begin
    // 	if(!hrst_b)begin
    // 		t_valid <= 0;
    // 	end
    // 	else if(haddr >= `T_BASE && haddr <= `T_OFFSET && hwrite && hsel)begin
    // 		t_valid <= 1;
    // 	end
    // 	else begin
    // 		t_valid <= 0;
    // 	end
    // end

    always@(posedge hclk or negedge hrst_b)begin
    	if(!hrst_b)begin
    		e_valid <= 0;
    	end
    	else if(haddr == `E_BASE && hwrite && hsel)begin
    		e_valid <= 1;
    	end
    	else begin
    		e_valid <= 0;
    	end
    end

    always@(posedge hclk or negedge hrst_b)begin
    	if(!hrst_b)begin
    		nprime0_valid <= 0;
    	end
    	else if(haddr == `NPRIME0_BASE && hwrite && hsel)begin
    		nprime0_valid <= 1;
    	end
    	else begin
    		nprime0_valid <= 0;
    	end
    end

    always@(posedge hclk or negedge hrst_b)begin
    	if(!hrst_b)begin
    		startCompute <= 0;
    	end
    	else if(haddr == `START_COMPUTE && hwrite && hsel)begin
    		startCompute <= 1;
    	end
    	else begin
    		startCompute <= 0;
    	end
    end

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            Config_RSA_Mode_En <= 0;
        end
        else if(haddr == `CONFIG_RSA_MODE && hsel && hwrite)begin
            Config_RSA_Mode_En <= 1;
        end
        else begin
            Config_RSA_Mode_En <= 0;
        end
    end

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            RSA_Mode <= 0;
        end
        else if(Config_RSA_Mode_En)begin
            RSA_Mode <= hwdata[4:0];
        end
    end

    // always@(posedge hclk or negedge hrst_b)begin
    // 	if(!hrst_b)begin
    // 		getResult <= 0;
    // 	end
    // 	else if(haddr == `GET_RESULT_CIT && hwrite && hsel)begin
    // 		getResult <= 1;
    // 	end
    // 	else begin
    // 		getResult <= 0;
    // 	end
    // end
    assign read_mod_n_en = hwrite == 1'b0 && hsel == 1'b1 && haddr == `RSA_READ_MOD_N;

    assign read_en = (hwrite == 1'b0) && (hsel == 1'b1) && haddr >= `READ_RES_BASE && haddr <= `READ_RES_OFFSET;

    reg [31:0] ihrdata;
	always @(posedge hclk or negedge hrst_b)
	begin
	if(!hrst_b)
		ihrdata[31:0] <= {32{1'b0}};
	else
		if((hwrite == 1'b0) && (hsel == 1'b1))
		case(haddr)
            `GET_INTR_STATUS:ihrdata <= intr_status_reg;
            `RSA_CONFIG_BUSY:ihrdata <= config_busy;
		
			default:ihrdata <= {32{1'b0}};
		endcase
		else
			ihrdata <= {32{1'b1}};
	end

	reg read_en_reg;
    reg read_mod_n_en_reg;

	always@(posedge hclk or negedge hrst_b)begin
		if(!hrst_b)begin
			read_en_reg <= 0;
		end
		else begin
			read_en_reg <= read_en;
		end
	end

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            read_mod_n_en_reg <= 0;
        end
        else begin
            read_mod_n_en_reg <= read_mod_n_en;
        end
    end

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            intr_clear <= 0;
        end
        else if(haddr == `CLEAR_INTR && hwrite && hsel)begin
            intr_clear <= 1;
        end
        else begin
            intr_clear <= 0;
        end
    end

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            intr_reg <= 0;
        end
        else if(intr_clear)begin
            intr_reg <= 0;
        end
        else if(intr_cal)begin// || Config_Done
            intr_reg <= 1;
        end
    end

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            intr_status_reg <= 0;
        end
        else if(intr_clear)begin
            intr_status_reg <= 0;
        end
        else if(intr_cal)begin
            intr_status_reg <= 1;
        end
        // else if(Config_Done)begin
        //     intr_status_reg <= 2;
        // end
    end

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            config_busy <= 0;
        end
        else if(haddr == `PARAM_CAL && hwrite && hsel)begin
            config_busy <= 1;
        end
        else if(Config_Done)begin
            config_busy <= 0;
        end
    end


    assign intr             = intr_reg;
    assign hready 			= 1;
    assign hresp 			= 2'b00;
    assign hrdata   		= read_en_reg ? outp : 
                              read_mod_n_en_reg ?  Out_Mod_n : ihrdata;
    //assign intr 			= 1'b0;
endmodule
