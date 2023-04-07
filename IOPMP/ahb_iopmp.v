`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/15 12:04:03
// Design Name: 
// Module Name: ahb_iopmp
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

module ahb_iopmp #(
	parameter W_SRCID_BASE 		= 32'h40020000,
	parameter W_SRCMD_DATA 		= 32'h40020004,
	parameter W_MD_SEL     		= 32'h40020008,
	parameter INTR_CLEAR        = 32'h4002000C,
	parameter W_MD_ENTRY_BASE   = 32'h400203A0,
	parameter W_MD_ENTRY_OFFSET = 32'h40020BEF

	)(
	//AHB Config Interface
	hclk,
    hrst_b,
    haddr,
    hprot,
    hrdata,
    hready,
    hresp,
    hsel,
    hsize,
    htrans,
    hwdata,
    hwrite,
    intr,

    //Master Port
    haddr_m0,
    hprot_m0,
    hrdata_m0,
    hready_m0,
    hresp_m0,
    hsel_m0,
    hsize_m0,
    htrans_m0,
    hwdata_m0,
    hwrite_m0,

    haddr_m1,
    hprot_m1,
    hrdata_m1,
    hready_m1,
    hresp_m1,
    hsel_m1,
    hsize_m1,
    htrans_m1,
    hwdata_m1,
    hwrite_m1,
    //Slave Port
    haddr_s0,
    hprot_s0,
    hrdata_s0,
    hready_s0,
    hresp_s0,
    hsel_s0,
    hsize_s0,
    htrans_s0,
    hwdata_s0,
    hwrite_s0,

    haddr_s1,
    hprot_s1,
    hrdata_s1,
    hready_s1,
    hresp_s1,
    hsel_s1,
    hsize_s1,
    htrans_s1,
    hwdata_s1,
    hwrite_s1
    );

	input   	 	hclk;
    input 		 	hrst_b;
    input 	[31:0] 	haddr;
    output 		 	hready;
    input 	     	hsel;
    input 	[31:0] 	hwdata;
    input        	hwrite;
    output	[31:0] 	hrdata;
    output       	intr;
    output  [1 :0] 	hresp;
    input   [3 :0]  hprot; 
    input   [2 :0]  hsize;
    input   [1 :0]  htrans;
    wire   	 	    hclk;
    wire 		 	hrst_b;
    wire 	[31:0] 	haddr;
    wire 		 	hready;
    wire 	     	hsel;
    wire 	[31:0] 	hwdata;
    wire        	hwrite;
    wire	[31:0] 	hrdata;
    wire       	    intr;
    wire   [1 :0] 	hresp;
    wire   [3 :0]   hprot; 
    wire   [2 :0]   hsize;
    wire   [1 :0]   htrans;

    input 	[31:0] 	haddr_m0, 	haddr_m1;
    output 		 	hready_m0, 	hready_m1;
    input 	     	hsel_m0, 	hsel_m1;
    input 	[31:0] 	hwdata_m0, 	hwdata_m1;
    input        	hwrite_m0, 	hwrite_m1;
    output	[31:0] 	hrdata_m0, 	hrdata_m1;
    output  [1 :0] 	hresp_m0, 	hresp_m1;
    input   [3 :0]  hprot_m0, 	hprot_m1; 
    input   [2 :0]  hsize_m0, 	hsize_m1;
    input   [1 :0]  htrans_m0, 	htrans_m1;

    output 	[31:0] 	haddr_s0, 	haddr_s1;
    input 		 	hready_s0, 	hready_s1;
    output 	     	hsel_s0, 	hsel_s1;
    output 	[31:0] 	hwdata_s0, 	hwdata_s1;
    output        	hwrite_s0, 	hwrite_s1;
    input	[31:0] 	hrdata_s0, 	hrdata_s1;
    input  	[1 :0] 	hresp_s0, 	hresp_s1;
    output  [3 :0]  hprot_s0, 	hprot_s1; 
    output  [2 :0]  hsize_s0, 	hsize_s1;
    output  [1 :0]  htrans_s0, 	htrans_s1;

	reg        SRCMD_ID_En;
	reg [31:0] SRCMD_Update_ID;
	reg 	   SRCMD_MS32bit;
	reg 	   SRCMD_Update_Valid;
	reg        intr_reg;
    

	always@(posedge hclk or negedge hrst_b)begin
		if(!hrst_b)begin
			SRCMD_ID_En <= 0;
		end
		else if(hsel && hwrite && haddr == W_SRCID_BASE)begin
			SRCMD_ID_En <= 1;
		end
		else begin
			SRCMD_ID_En <= 0;
		end
	end

	always@(posedge hclk or negedge hrst_b)begin
		if(!hrst_b)begin
			SRCMD_Update_ID <= 0;
		end
		else if(SRCMD_ID_En)begin
			SRCMD_Update_ID <= {16'h0,hwdata[15:0]};
		end
	end

	always@(posedge hclk or negedge hrst_b)begin
		if(!hrst_b)begin
			SRCMD_MS32bit <= 0;
		end
		else if(SRCMD_ID_En)begin
			SRCMD_MS32bit <= hwdata[31];
		end
	end

	always@(posedge hclk or negedge hrst_b)begin
		if(!hrst_b)begin
			SRCMD_Update_Valid <= 0;
		end
		else if(hsel && hwrite && haddr == W_SRCMD_DATA)begin
			SRCMD_Update_Valid <= 1;
		end
		else begin
			SRCMD_Update_Valid <= 0;
		end
	end
	reg         iopmp_md_sel_en;
	reg  [3:0]  iopmp_md_sel;
	reg 		iopmp_Memory_Domain_wen;
	reg [11:0]	iopmp_Memory_Domain_Reg_Addr;

	always@(posedge hclk or negedge hrst_b)begin
		if(!hrst_b)begin
			iopmp_md_sel_en <= 0;
		end
		else if(hsel && hwrite && haddr == W_MD_SEL)begin
			iopmp_md_sel_en <= 1;
		end
		else begin
			iopmp_md_sel_en <= 0;
		end
	end

	always@(posedge hclk or negedge hrst_b)begin
		if(!hrst_b)begin
			iopmp_md_sel <= 4'b0;
		end
		else if(iopmp_md_sel_en)begin
			iopmp_md_sel <= hwdata[3:0];
		end
	end

	always@(posedge hclk or negedge hrst_b)begin
		if(!hrst_b)begin
			iopmp_Memory_Domain_wen <= 0;
			iopmp_Memory_Domain_Reg_Addr <= 0;
		end
		else if(hsel && hwrite && haddr >= W_MD_ENTRY_BASE && haddr <= W_MD_ENTRY_OFFSET)begin
			iopmp_Memory_Domain_wen <= 1;
			iopmp_Memory_Domain_Reg_Addr <= haddr[11:0];
		end
		else begin
			iopmp_Memory_Domain_wen <= 0;
		end
	end
	wire input_addr_0_deny;
	wire input_addr_1_deny;

	always@(posedge hclk or negedge hrst_b)begin
		if(!hrst_b)begin
			intr_reg <= 0;
		end
		else if(haddr == INTR_CLEAR && hsel && hwrite)begin
			intr_reg <= 0;
		end
		else if((htrans_m0 == 2 || htrans_m1 == 2) && !intr_reg)begin
			intr_reg <= input_addr_0_deny | input_addr_1_deny;
		end
	end
 	wire [1:0] Source_ID_From_Bus;
	reg [3:0] hprot_m0_reg;


    assign Source_ID_From_Bus = hprot_m0[3:2];
	
	

	always@(posedge hclk or negedge hrst_b)begin
		if(!hrst_b)begin
			hprot_m0_reg <= 0;
		end	
		else if(htrans_m0 == 2)begin
			hprot_m0_reg <= hprot_m0;		
		end

	end
	
	iopmp_top x_iopmp_top(
        .clk(hclk),
        .rst_n(hrst_b),

        .SRCMD_Update_ID(SRCMD_Update_ID),
        .SRCMD_Update_Valid(SRCMD_Update_Valid),
        .SRCMD_MS32bit(SRCMD_MS32bit),
        .Config_Data(hwdata),
///////////////////////////////////////////////////////
//////////////////program iopmp/////////////////////////
//////////////////////////////////////////////////////
        .source_ID({1'b0,Source_ID_From_Bus}),
        .input_addr_0_valid(htrans_m0 == 2),
		.input_addr_1_valid(htrans_m1 == 2),

        .iopmp_update_Memory_Domain_data(hwdata),
        .iopmp_Memory_Domain_wen(iopmp_Memory_Domain_wen),
        .iopmp_Memory_Domain_Reg_Addr(iopmp_Memory_Domain_Reg_Addr),

        .iopmp_md_sel(iopmp_md_sel),
        .iopmp_entry_data(),
        .input_addr_0(haddr_m0),
        .input_addr_1(haddr_m1),
        .input_addr_0_write(hwrite_m0),
        .input_addr_1_write(hwrite_m1),

        .input_addr_0_deny(input_addr_0_deny),
        .input_addr_1_deny(input_addr_1_deny)
    );

	assign hready 			= 1;
    assign hresp 			= 2'b00;

    /////IOPMP Master <===> Slave
    // device 0
    assign haddr_s0 	= haddr_m0;
    assign hprot_s0 	= hprot_m0;
    assign hrdata_m0 	= hrdata_s0;
    assign hready_m0 	= !intr_reg ? hready_s0 : 0;//!input_addr_0_deny ? hready_s0 : 0;
    assign hresp_m0     = hresp_s0;
    assign hsel_s0      = !input_addr_0_deny ? hsel_m0 : 0;
    assign hsize_s0     = hsize_m0;
    assign htrans_s0 	= htrans_m0;
    assign hwdata_s0    = hwdata_m0;
    assign hwrite_s0    = !input_addr_0_deny ? hwrite_m0 : 0;

    // device 1
    assign haddr_s1 	= haddr_m1;
    assign hprot_s1 	= hprot_m1;
    assign hrdata_m1 	= hrdata_s1;
    assign hready_m1 	= !intr_reg ? hready_s1 : 0;//!input_addr_1_deny ? hready_s1 : 0;
    assign hresp_m1     = hresp_s1;
    assign hsel_s1      = !input_addr_1_deny ? hsel_m1 : 0;
    assign hsize_s1     = hsize_m1;
    assign htrans_s1 	= htrans_m1;
    assign hwdata_s1    = hwdata_m1;
    assign hwrite_s1    = !input_addr_1_deny ? hwrite_m1 : 0;

	assign intr = intr_reg;

endmodule
