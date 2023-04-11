`define RAM_USAGE
`define BANK2_SYS_DATA_WIDTH 32
`define BANK2_WE_WIDTH 4
`define BANK2_ADDR_WIDTH 14 
`define BANK2_ADDR_WORDS 16384 
`define BANK2_DATA_WIDTH 32
`define BANK2_ADDR_WIDTH_14
module sms_bank_1M_top(
  big_endian_b,
  mem_haddr,
  mem_hclk,
  mem_hprot,
  mem_hrdata,
  mem_hready,
  mem_hready_resp,
  mem_hresp,
  mem_hrst_b,
  mem_hsel,
  mem_hsize,
  mem_htrans,
  mem_hwdata,
  mem_hwrite,
  region_rd_deny_flag,
  region_wr_deny_flag,
  sms_idle0
);
input           big_endian_b;        
input   [31:0]  mem_haddr;           
input           mem_hclk;            
input   [3 :0]  mem_hprot;           
input           mem_hready;          
input           mem_hrst_b;          
input           mem_hsel;            
input   [2 :0]  mem_hsize;           
input   [1 :0]  mem_htrans;          
input   [31:0]  mem_hwdata;          
input           mem_hwrite;          
input           region_rd_deny_flag; 
input           region_wr_deny_flag; 
output  [31:0]  mem_hrdata;          
output          mem_hready_resp;     
output  [1 :0]  mem_hresp;           
output          sms_idle0;           
reg             rd_deny_resp;        
reg             rd_deny_resp_2_cycle; 
reg             wr_deny_resp;        
reg             wr_deny_resp_2_cycle; 
wire            a_act_burst;         
wire            a_nonseq;            
wire            a_seq;               
wire            big_endian_b;        
wire            deny_hready_resp;    
wire    [1 :0]  deny_hresp;          
wire    [31:0]  mem_haddr;           
wire            mem_hclk;            
wire    [3 :0]  mem_hprot;           
wire    [31:0]  mem_hrdata;          
wire            mem_hready;          
wire            mem_hready_resp;     
wire    [1 :0]  mem_hresp;           
wire            mem_hrst_b;          
wire            mem_hsel;            
wire            mem_hsel_deny;       
wire    [2 :0]  mem_hsize;           
wire    [1 :0]  mem_htrans;          
wire    [1 :0]  mem_htrans_deny;     
wire    [31:0]  mem_hwdata;          
wire            mem_hwrite;          
wire    [31:0]  ram_addr;            
wire    [31:0]  ram_rdata;           
wire            ram_sel;             
wire    [2 :0]  ram_size;            
wire    [31:0]  ram_wdata;           
wire            ram_write;           
wire            region_rd_deny_flag; 
wire            region_wr_deny_flag; 
wire    [3 :0]  resp_cfg;            
wire            sms_idle0;           
parameter  NONSEQ = 2'b10;
parameter  SEQ    = 2'b11;
parameter  ERROR  = 2'b01;  
assign a_nonseq = mem_htrans[1:0] == NONSEQ;
assign a_seq    = mem_htrans[1:0] == SEQ;
assign a_act_burst = (a_nonseq || a_seq) && mem_hsel && mem_hready;
assign mem_hsel_deny =( (a_act_burst&mem_hwrite&region_wr_deny_flag) |
                        (a_act_burst&(~mem_hwrite)&region_rd_deny_flag) )
                        ? 1'b0 : mem_hsel;
assign mem_htrans_deny[1:0] =( (a_act_burst&mem_hwrite&region_wr_deny_flag) |
                               (a_act_burst&(~mem_hwrite)&region_rd_deny_flag) )
                               ? 2'b0 : mem_htrans[1:0];
always @(posedge mem_hclk or negedge mem_hrst_b)
begin
	if(!mem_hrst_b) begin
		wr_deny_resp <= 1'b0;
        end
	else if(wr_deny_resp && wr_deny_resp_2_cycle) begin
		wr_deny_resp <= 1'b0;
        end
	else if(a_act_burst && mem_hwrite && region_wr_deny_flag) begin
		wr_deny_resp <= 1'b1;
        end
end
always @(posedge mem_hclk or negedge mem_hrst_b)
begin
	if(!mem_hrst_b) begin
		wr_deny_resp_2_cycle <= 1'b0;
        end
	else if(wr_deny_resp && wr_deny_resp_2_cycle) begin
		wr_deny_resp_2_cycle <= 1'b0;
        end
	else if(wr_deny_resp) begin
		wr_deny_resp_2_cycle <= 1'b1;
        end
end
always @(posedge mem_hclk or negedge mem_hrst_b)
begin
	if(!mem_hrst_b) begin
		rd_deny_resp <= 1'b0;
        end
	else if(rd_deny_resp && rd_deny_resp_2_cycle) begin
		rd_deny_resp <= 1'b0;
        end
	else if(a_act_burst && (!mem_hwrite) && region_rd_deny_flag) begin
		rd_deny_resp <= 1'b1;
        end
end
always @(posedge mem_hclk or negedge mem_hrst_b)
begin
	if(!mem_hrst_b) begin
		rd_deny_resp_2_cycle <= 1'b0;
        end
	else if(rd_deny_resp && rd_deny_resp_2_cycle) begin
		rd_deny_resp_2_cycle <= 1'b0;
        end
	else if(rd_deny_resp) begin
		rd_deny_resp_2_cycle <= 1'b1;
        end
end
assign mem_hready_resp = rd_deny_resp ? rd_deny_resp_2_cycle : 
                    (wr_deny_resp ? wr_deny_resp_2_cycle : deny_hready_resp);
assign mem_hresp[1:0] = rd_deny_resp ? ERROR : (wr_deny_resp ? ERROR : deny_hresp);
sms_sms_ahbs_bk2  x_sms_sms_ahbs (
  .ahbs_harb_hrdata    (mem_hrdata         ),
  .ahbs_harb_hready    (deny_hready_resp   ),
  .ahbs_harb_hresp     (deny_hresp         ),
  .harb_ahbs_hsel      (mem_hsel_deny      ),
  .harb_xx_haddr       (mem_haddr          ),
  .harb_xx_hready      (mem_hready         ),
  .harb_xx_hsize       (mem_hsize          ),
  .harb_xx_htrans      (mem_htrans_deny    ),
  .harb_xx_hwdata      (mem_hwdata         ),
  .harb_xx_hwrite      (mem_hwrite         ),
  .i_sys_hclk          (mem_hclk           ),
  .i_sys_rst_b         (mem_hrst_b         ),
  .little_endian_trans (big_endian_b       ),
  .mem_hprot           (mem_hprot          ),
  .ram_addr            (ram_addr           ),
  .ram_idle            (sms_idle0          ),
  .ram_rdata           (ram_rdata          ),
  .ram_sel             (ram_sel            ),
  .ram_size            (ram_size           ),
  .ram_wdata           (ram_wdata          ),
  .ram_write           (ram_write          ),
  .resp_cfg            (resp_cfg           )
);
sms_sram_1M_bk2  x_sms_sram_1M (
  .hrst_b     (mem_hrst_b),
  .ram_addr   (ram_addr  ),
  .ram_clk    (mem_hclk  ),
  .ram_rdata  (ram_rdata ),
  .ram_sel    (ram_sel   ),
  .ram_size   (ram_size  ),
  .ram_wdata  (ram_wdata ),
  .ram_write  (ram_write )
);
assign resp_cfg[3:0] = 4'b1000;
endmodule

`define RAM_USAGE

module sms_sram_1M_bk2(
  hrst_b,
  ram_addr,
  ram_clk,
  ram_rdata,
  ram_sel,
  ram_size,
  ram_wdata,
  ram_write
);
input           hrst_b;     
input   [31:0]  ram_addr;   
input           ram_clk;    
input           ram_sel;    
input   [2 :0]  ram_size;   
input   [31:0]  ram_wdata;  
input           ram_write;  
output  [31:0]  ram_rdata;  
reg     [3 :0]  byte_sel_b; 
reg             mbk_cen_f_b; 
reg     [31:0]  ram_rdata;  
wire    [3 :0]  byte_wen_b; 
wire            hrst_b;     
wire            mbk_cen_b;  
wire            mbk_wen_b;  
wire    [31:0]  ram0_rdata; 
wire    [31:0]  ram_addr;   
wire            ram_clk;    
wire            ram_sel;    
wire    [2 :0]  ram_size;   
wire    [31:0]  ram_wdata;  
wire            ram_write;  
parameter[2:0]   BYTE      = 3'b000, 
                 HALFWORD  = 3'b001, 
                 WORD      = 3'b010; 
assign mbk_cen_b = ~ram_sel;
always @( ram_addr[1:0]
       or ram_size[2:0])
begin
  case (ram_size[2:0])   // synopsys parallel_case
    BYTE:
      case (ram_addr[1:0])   // synopsys parallel_case
        2'b00:
          byte_sel_b[3:0] = 4'b1110;    
        2'b01:
          byte_sel_b[3:0] = 4'b1101;
        2'b10:
          byte_sel_b[3:0] = 4'b1011;
        2'b11:
          byte_sel_b[3:0] = 4'b0111;
      endcase
    HALFWORD:
      case (ram_addr[1])     // synopsys parallel_case
        1'b0:
          byte_sel_b[3:0] = 4'b1100;    
        1'b1:
          byte_sel_b[3:0] = 4'b0011;
      endcase
    WORD:
      byte_sel_b[3:0] = 4'b0000;
    default:
      byte_sel_b[3:0] = 4'b1111;
  endcase
end
assign mbk_wen_b = ~ram_write; 
always @( posedge ram_clk or negedge hrst_b)
begin
  if (!hrst_b)
  mbk_cen_f_b <= 1'b0;
  else
  mbk_cen_f_b <= mbk_cen_b;
end
always @( mbk_cen_f_b
       or ram0_rdata[31:0])
begin
  case (mbk_cen_f_b)
    1'b0:
      ram_rdata[31:0] = ram0_rdata[31:0];
    1'b1:
      ram_rdata[31:0] = 32'b0;
  endcase
end
parameter  DATAWIDTH = 32;
parameter  ADDRWIDTH = 18;
parameter  MEMDEPTH  = 2**(ADDRWIDTH);
assign byte_wen_b[3:0] =  byte_sel_b[3:0] | {4{mbk_wen_b}};
fpga_spram #(DATAWIDTH,ADDRWIDTH,MEMDEPTH) x_fpga_spram (
  .A                (ram_addr[19:2]  ),
  .BWEN             (byte_wen_b[3:0] ),
  .CEN              (mbk_cen_b       ),
  .CLK              (ram_clk         ),
  .D                (ram_wdata[31:0] ),
  .Q                (ram0_rdata[31:0])
);
endmodule