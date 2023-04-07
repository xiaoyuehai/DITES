`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/26 15:59:49
// Design Name: 
// Module Name: iopmp
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


module iopmp_top(
        input   wire              clk,
        input   wire              rst_n,

        input   wire  [31:0]      SRCMD_Update_ID,
        input   wire              SRCMD_Update_Valid,
        input   wire              SRCMD_MS32bit,
        input   wire  [31:0]      Config_Data,
///////////////////////////////////////////////////////
//////////////////program iopmp/////////////////////////
//////////////////////////////////////////////////////
        input   wire  [2:0]       source_ID,
        input   wire              input_addr_0_valid,
		input   wire  			  input_addr_1_valid,

        input   wire  [31:0]      iopmp_update_Memory_Domain_data,
        input   wire              iopmp_Memory_Domain_wen,
        input   wire  [11:0]      iopmp_Memory_Domain_Reg_Addr,

        input   wire  [3:0]       iopmp_md_sel,
        output  reg   [31:0]      iopmp_entry_data,
        input   wire  [31:0]      input_addr_0,
        input   wire  [31:0]      input_addr_1,
        input   wire              input_addr_0_write,
        input   wire              input_addr_1_write,

        output  wire              input_addr_0_deny,
        output  wire              input_addr_1_deny
    );

reg [63:0] src_md0;
reg [63:0] src_md1;
reg [31:0] md_cfg0;
reg [31:0] md_cfg1;
reg [31:0] md_cfg2;
reg [31:0] md_cfg3;
wire [15:0] md_cfg0_t;
wire [15:0] md_cfg1_t;
wire [15:0] md_cfg2_t;
wire [15:0] md_cfg3_t;

assign  md_cfg0_t=md_cfg0[15:0];
assign  md_cfg1_t=md_cfg1[15:0];
assign  md_cfg2_t=md_cfg2[15:0];
assign  md_cfg3_t=md_cfg3[15:0];

reg Memory_Domain_wen0;
reg Memory_Domain_wen1;
reg Memory_Domain_wen2;
reg Memory_Domain_wen3;

wire [31:0] iopmp_entry_data0;
wire [31:0] iopmp_entry_data1;
wire [31:0] iopmp_entry_data2;
wire [31:0] iopmp_entry_data3;

wire [3:0] md_en;

wire input_addr_0_deny0;
wire input_addr_0_deny1;
wire input_addr_0_deny2;
wire input_addr_0_deny3;

wire input_addr_1_deny0;
wire input_addr_1_deny1;
wire input_addr_1_deny2;
wire input_addr_1_deny3;



///logic step 0: config SRCMD from TEE CPU
reg [63:0] SRCMD [0:1];
wire[63:0] Read_SRCMD;


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        SRCMD[0] <= 64'h0;
        SRCMD[1] <= 64'h0;
    end
    else if(SRCMD_Update_Valid)begin
        if(SRCMD_MS32bit)begin
            SRCMD[SRCMD_Update_ID][63:32] <= Config_Data;
        end
        else begin
            SRCMD[SRCMD_Update_ID][31:0]  <= Config_Data;
        end
    end
end
///logic step 1: Get SRCMD by SRCID
assign Read_SRCMD = SRCMD[source_ID];

assign md_en = Read_SRCMD[3:0];

always@(*)begin
   if(!rst_n) begin
        Memory_Domain_wen0<=0;
        Memory_Domain_wen1<=0;
        Memory_Domain_wen2<=0;
        Memory_Domain_wen3<=0;
   end
   else begin
     case(iopmp_md_sel)
       4'b0001:begin  Memory_Domain_wen0<=iopmp_Memory_Domain_wen;Memory_Domain_wen1<=0;Memory_Domain_wen2<=0;Memory_Domain_wen3<=0;end
       4'b0010:begin  Memory_Domain_wen0<=0;Memory_Domain_wen1<=iopmp_Memory_Domain_wen;Memory_Domain_wen2<=0;Memory_Domain_wen3<=0;end
       4'b0100:begin  Memory_Domain_wen0<=0;Memory_Domain_wen1<=0;Memory_Domain_wen2<=iopmp_Memory_Domain_wen;Memory_Domain_wen3<=0;end
       4'b1000:begin  Memory_Domain_wen0<=0;Memory_Domain_wen1<=0;Memory_Domain_wen2<=0;Memory_Domain_wen3<=iopmp_Memory_Domain_wen;end
       default:begin  Memory_Domain_wen0<=0;Memory_Domain_wen1<=0;Memory_Domain_wen2<=0;Memory_Domain_wen3<=0;end
     endcase
   end 
end

// always@(*)begin
//      case(md_en)
//        4'b0001:begin  iopmp_entry_data<=iopmp_entry_data0;end
//        4'b0010:begin  iopmp_entry_data<=iopmp_entry_data1;end
//        4'b0100:begin  iopmp_entry_data<=iopmp_entry_data2;end
//        4'b1000:begin  iopmp_entry_data<=iopmp_entry_data3;end
//        default:begin  iopmp_entry_data<=iopmp_entry_data0;end
//      endcase
// end 
assign input_addr_0_deny = 	source_ID == 3'b0 ? 1'b0 : 
							input_addr_0_valid ? input_addr_0_deny0 & input_addr_0_deny1 & input_addr_0_deny2 & input_addr_0_deny3 : 1'b0;
assign input_addr_1_deny = 	source_ID == 3'b0 ? 1'b0 : 
							input_addr_1_valid ? input_addr_1_deny0 & input_addr_1_deny1 & input_addr_1_deny2 & input_addr_1_deny3 : 1'b0;

iopmp_meomery_domain  x_iopmp_meomery_domain0(
  .memory_domain_selected(md_en[0]),
  .cp0_pmp_csr_sel(iopmp_Memory_Domain_Reg_Addr),
  .cp0_pmp_csr_wen(Memory_Domain_wen0),
  .cp0_pmp_updt_data(iopmp_update_Memory_Domain_data),
  .cpurst_b(rst_n),
  .forever_cpuclk(clk),
  .input_addr_0(input_addr_0),
  .input_addr_1(input_addr_1),
  .input_addr_0_write(input_addr_0_write),
  .input_addr_1_write(input_addr_1_write),
  .input_addr_0_deny(input_addr_0_deny0),
  .input_addr_1_deny(input_addr_1_deny0),
  .pmp_cp0_data(iopmp_entry_data0)
);


iopmp_meomery_domain  x_iopmp_meomery_domain1(
  .memory_domain_selected(md_en[1]),
  .cp0_pmp_csr_sel(iopmp_Memory_Domain_Reg_Addr),
  .cp0_pmp_csr_wen(Memory_Domain_wen1),
  .cp0_pmp_updt_data(iopmp_update_Memory_Domain_data),
  .cpurst_b(rst_n),
  .forever_cpuclk(clk),
  .input_addr_0(input_addr_0),
  .input_addr_1(input_addr_1),
  .input_addr_0_write(input_addr_0_write),
  .input_addr_1_write(input_addr_1_write),
  .input_addr_0_deny(input_addr_0_deny1),
  .input_addr_1_deny(input_addr_1_deny1),
  .pmp_cp0_data(iopmp_entry_data1)
);


iopmp_meomery_domain  x_iopmp_meomery_domain2(
  .memory_domain_selected(md_en[2]),
  .cp0_pmp_csr_sel(iopmp_Memory_Domain_Reg_Addr),
  .cp0_pmp_csr_wen(Memory_Domain_wen2),
  .cp0_pmp_updt_data(iopmp_update_Memory_Domain_data),
  .cpurst_b(rst_n),
  .forever_cpuclk(clk),
  .input_addr_0(input_addr_0),
  .input_addr_1(input_addr_1),
  .input_addr_0_write(input_addr_0_write),
  .input_addr_1_write(input_addr_1_write),
  .input_addr_0_deny(input_addr_0_deny2),
  .input_addr_1_deny(input_addr_1_deny2),
  .pmp_cp0_data(iopmp_entry_data2)
);


iopmp_meomery_domain  x_iopmp_meomery_domain3(
  .memory_domain_selected(md_en[3]),
  .cp0_pmp_csr_sel(iopmp_Memory_Domain_Reg_Addr),
  .cp0_pmp_csr_wen(Memory_Domain_wen3),
  .cp0_pmp_updt_data(iopmp_update_Memory_Domain_data),
  .cpurst_b(rst_n),
  .forever_cpuclk(clk),
  .input_addr_0(input_addr_0),
  .input_addr_1(input_addr_1),
  .input_addr_0_write(input_addr_0_write),
  .input_addr_1_write(input_addr_1_write),
  .input_addr_0_deny(input_addr_0_deny3),
  .input_addr_1_deny(input_addr_1_deny3),
  .pmp_cp0_data(iopmp_entry_data3)
);

endmodule
