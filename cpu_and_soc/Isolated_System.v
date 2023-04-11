module Isolate_System(
	WMAB_R2T_Interrupt,
  	RMAB_R2T_Interrupt,
  	WMAB_T2R_Interrupt,
  	RMAB_T2R_Interrupt,
	RSA_Intr,
	AES_Intr,
	SHA_Intr,
	REE_IOPMP_Intr,
    CryptoCore_IOPMP_Intr,
	cpu_padmux_jtg_tms_o,
  	cpu_padmux_jtg_tms_oe,
  	cpu_pmu_dfs_ack,
    cpu_pmu_sleep_b,
   	dft_clk,
   	pad_core_clk,
   	pad_core_ctim_refclk,
	pad_core_rst_b,
	padmux_cpu_jtg_tclk,
	padmux_cpu_jtg_tms_i,
	pmu_cpu_dfs_req,
	scan_en,
  	scan_mode,
  	test_mode,
  	tim0_wic_intr,
  	usi1_wic_intr,
	ree_cpu_rst_addr,
	ree_cpu_rst_n,

  	//bus interface 
  	hmain0_dummy3_s11_haddr,    
	hmain0_dummy3_s11_hburst,   
	hmain0_dummy3_s11_hprot,    
	hmain0_dummy3_s11_hsel,     
	hmain0_dummy3_s11_hsize,    
	hmain0_dummy3_s11_htrans,   
	hmain0_dummy3_s11_hwdata,   
	hmain0_dummy3_s11_hwrite,
	dummy3_hmain0_s11_hrdata,   
	dummy3_hmain0_s11_hready,   
	dummy3_hmain0_s11_hresp

	);
output	[31:0] 	ree_cpu_rst_addr;
output       	ree_cpu_rst_n; 
output   [31:0] hmain0_dummy3_s11_haddr;    
output   [2 :0] hmain0_dummy3_s11_hburst;   
output   [3 :0] hmain0_dummy3_s11_hprot;    
output          hmain0_dummy3_s11_hsel;     
output   [2 :0] hmain0_dummy3_s11_hsize;    
output   [1 :0] hmain0_dummy3_s11_htrans;   
output   [31:0] hmain0_dummy3_s11_hwdata;   
output          hmain0_dummy3_s11_hwrite;
input    [31:0] dummy3_hmain0_s11_hrdata;   
input           dummy3_hmain0_s11_hready;   
input    [1 :0] dummy3_hmain0_s11_hresp; 
input  			RSA_Intr;
input  			AES_Intr;
input  			SHA_Intr;
input           WMAB_R2T_Interrupt;
input           RMAB_R2T_Interrupt;
input           WMAB_T2R_Interrupt;
input           RMAB_T2R_Interrupt;
input			REE_IOPMP_Intr;
input		    CryptoCore_IOPMP_Intr;
output          cpu_padmux_jtg_tms_o;  
output          cpu_padmux_jtg_tms_oe; 
output          cpu_pmu_dfs_ack; 
output          cpu_pmu_sleep_b; 
input           dft_clk; 
input           pad_core_clk;          
input           pad_core_ctim_refclk;  
input           pad_core_rst_b;        
input           padmux_cpu_jtg_tclk;   
input           padmux_cpu_jtg_tms_i;  
input           pmu_cpu_dfs_req;  
input           scan_en;               
input           scan_mode;             
input           test_mode;
input   [1 :0]  tim0_wic_intr; 
input           usi1_wic_intr;
//CPU + Isolated System
wire   [31:0]  cpu_hmain0_m0_haddr;        
wire   [2 :0]  cpu_hmain0_m0_hburst;       
wire   [3 :0]  cpu_hmain0_m0_hprot;        
wire   [2 :0]  cpu_hmain0_m0_hsize;        
wire   [1 :0]  cpu_hmain0_m0_htrans;       
wire   [31:0]  cpu_hmain0_m0_hwdata;       
wire           cpu_hmain0_m0_hwrite;       
wire   [31:0]  cpu_hmain0_m1_haddr;        
wire   [2 :0]  cpu_hmain0_m1_hburst;       
wire   [3 :0]  cpu_hmain0_m1_hprot;        
wire   [2 :0]  cpu_hmain0_m1_hsize;        
wire   [1 :0]  cpu_hmain0_m1_htrans;       
wire   [31:0]  cpu_hmain0_m1_hwdata;       
wire           cpu_hmain0_m1_hwrite;       
wire   [31:0]  cpu_hmain0_m2_haddr;        
wire   [2 :0]  cpu_hmain0_m2_hburst;       
wire   [3 :0]  cpu_hmain0_m2_hprot;        
wire   [2 :0]  cpu_hmain0_m2_hsize;        
wire   [1 :0]  cpu_hmain0_m2_htrans;       
wire   [31:0]  cpu_hmain0_m2_hwdata;       
wire           cpu_hmain0_m2_hwrite;   
////////////////////////////////////////////////////
wire    [31:0]  mdummy0_hmain0_m4_haddr;    
wire    [2 :0]  mdummy0_hmain0_m4_hburst;   
wire    [3 :0]  mdummy0_hmain0_m4_hprot;    
wire    [2 :0]  mdummy0_hmain0_m4_hsize;    
wire    [1 :0]  mdummy0_hmain0_m4_htrans;   
wire    [31:0]  mdummy0_hmain0_m4_hwdata;   
wire            mdummy0_hmain0_m4_hwrite;   
wire    [31:0]  mdummy1_hmain0_m5_haddr;    
wire    [2 :0]  mdummy1_hmain0_m5_hburst;   
wire    [3 :0]  mdummy1_hmain0_m5_hprot;     
wire    [2 :0]  mdummy1_hmain0_m5_hsize;    
wire    [1 :0]  mdummy1_hmain0_m5_htrans;   
wire    [31:0]  mdummy1_hmain0_m5_hwdata;   
wire            mdummy1_hmain0_m5_hwrite;   

wire    [31:0]  hmain0_imemdummy0_s1_haddr; 
wire    [2 :0]  hmain0_imemdummy0_s1_hburst; 
wire    [3 :0]  hmain0_imemdummy0_s1_hprot; 
wire            hmain0_imemdummy0_s1_hsel;  
wire    [2 :0]  hmain0_imemdummy0_s1_hsize; 
wire    [1 :0]  hmain0_imemdummy0_s1_htrans; 
wire    [31:0]  hmain0_imemdummy0_s1_hwdata; 
wire            hmain0_imemdummy0_s1_hwrite;
wire    [31:0]  hmain0_dmemdummy0_s5_haddr; 
wire    [2 :0]  hmain0_dmemdummy0_s5_hburst; 
wire    [3 :0]  hmain0_dmemdummy0_s5_hprot; 
wire            hmain0_dmemdummy0_s5_hsel;  
wire    [2 :0]  hmain0_dmemdummy0_s5_hsize; 
wire    [1 :0]  hmain0_dmemdummy0_s5_htrans; 
wire    [31:0]  hmain0_dmemdummy0_s5_hwdata; 
wire            hmain0_dmemdummy0_s5_hwrite; 
wire    [31:0]  hmain0_dummy3_s11_haddr;    
wire    [2 :0]  hmain0_dummy3_s11_hburst;   
wire    [3 :0]  hmain0_dummy3_s11_hprot;    
wire            hmain0_dummy3_s11_hsel;     
wire    [2 :0]  hmain0_dummy3_s11_hsize;    
wire    [1 :0]  hmain0_dummy3_s11_htrans;   
wire    [31:0]  hmain0_dummy3_s11_hwdata;   
wire            hmain0_dummy3_s11_hwrite; 
wire    [31:0]  hmain0_dummy0_s7_haddr;     
wire    [2 :0]  hmain0_dummy0_s7_hburst;    
wire    [3 :0]  hmain0_dummy0_s7_hprot;     
wire            hmain0_dummy0_s7_hsel;      
wire    [2 :0]  hmain0_dummy0_s7_hsize;     
wire    [1 :0]  hmain0_dummy0_s7_htrans;    
wire    [31:0]  hmain0_dummy0_s7_hwdata;    
wire            hmain0_dummy0_s7_hwrite;    
wire    [31:0]  hmain0_dummy1_s8_haddr;     
wire    [2 :0]  hmain0_dummy1_s8_hburst;    
wire    [3 :0]  hmain0_dummy1_s8_hprot;     
wire            hmain0_dummy1_s8_hsel;      
wire    [2 :0]  hmain0_dummy1_s8_hsize;     
wire    [1 :0]  hmain0_dummy1_s8_htrans;    
wire    [31:0]  hmain0_dummy1_s8_hwdata;    
wire            hmain0_dummy1_s8_hwrite;    
wire    [31:0]  hmain0_dummy2_s9_haddr;     
wire    [2 :0]  hmain0_dummy2_s9_hburst;    
wire    [3 :0]  hmain0_dummy2_s9_hprot;     
wire            hmain0_dummy2_s9_hsel;      
wire    [2 :0]  hmain0_dummy2_s9_hsize;     
wire    [1 :0]  hmain0_dummy2_s9_htrans;    
wire    [31:0]  hmain0_dummy2_s9_hwdata;    
wire            hmain0_dummy2_s9_hwrite;
wire            hmain0_mdummy0_m4_hgrant;   
wire    [31:0]  hmain0_mdummy0_m4_hrdata;   
wire            hmain0_mdummy0_m4_hready;   
wire    [1 :0]  hmain0_mdummy0_m4_hresp;    
wire            hmain0_mdummy1_m5_hgrant;   
wire    [31:0]  hmain0_mdummy1_m5_hrdata;   
wire            hmain0_mdummy1_m5_hready;   
wire    [1 :0]  hmain0_mdummy1_m5_hresp;   
wire    [31:0]  imemdummy0_hmain0_s1_hrdata; 
wire            imemdummy0_hmain0_s1_hready; 
wire    [1 :0]  imemdummy0_hmain0_s1_hresp; 
wire    [31:0]  dmemdummy0_hmain0_s5_hrdata; 
wire            dmemdummy0_hmain0_s5_hready; 
wire    [1 :0]  dmemdummy0_hmain0_s5_hresp; 
wire    [31:0]  dummy3_hmain0_s11_hrdata;   
wire            dummy3_hmain0_s11_hready;   
wire    [1 :0]  dummy3_hmain0_s11_hresp; 
wire    [31:0]  dummy0_hmain0_s7_hrdata;    
wire            dummy0_hmain0_s7_hready;    
wire    [1 :0]  dummy0_hmain0_s7_hresp;     
wire    [31:0]  dummy1_hmain0_s8_hrdata;    
wire            dummy1_hmain0_s8_hready;    
wire    [1 :0]  dummy1_hmain0_s8_hresp;     
wire    [31:0]  dummy2_hmain0_s9_hrdata;    
wire            dummy2_hmain0_s9_hready;    
wire    [1 :0]  dummy2_hmain0_s9_hresp;     
/////////////////////////////////////////////
wire   [31:0]  ismc_hmain0_s0_hrdata;      
wire           ismc_hmain0_s0_hready;      
wire   [1 :0]  ismc_hmain0_s0_hresp;       
wire   [31:0]  lsbus_hmain0_s10_hrdata;    
wire           lsbus_hmain0_s10_hready;    
wire   [1 :0]  lsbus_hmain0_s10_hresp;     
wire           pmu_dmac0_hclk;             
wire           pmu_dmac0_hrst_b;           
wire           pmu_dmemdummy0_hclk;        
wire           pmu_dmemdummy0_hrst_b;      
wire           pmu_dummy0_hclk;            
wire           pmu_dummy0_hrst_b;          
wire           pmu_dummy1_hclk;            
wire           pmu_dummy1_hrst_b;          
wire           pmu_dummy2_hclk;            
wire           pmu_dummy2_hrst_b;          
wire           pmu_dummy3_hclk;            
wire           pmu_dummy3_hrst_b;          
wire           pmu_hmain0_hclk;            
wire           pmu_hmain0_hrst_b;          
wire           pmu_imemdummy0_hclk;        
wire           pmu_imemdummy0_hrst_b;      
wire           pmu_mdummy0_hclk;           
wire           pmu_mdummy0_hrst_b;         
wire           pmu_mdummy1_hclk;           
wire           pmu_mdummy1_hrst_b;         
wire           pmu_mdummy2_hclk;           
wire           pmu_mdummy2_hrst_b;         
wire   [31:0]  smc_hmain0_s2_hrdata;       
wire           smc_hmain0_s2_hready;       
wire   [1 :0]  smc_hmain0_s2_hresp;        
wire   [31:0]  smc_hmain0_s3_hrdata;       
wire           smc_hmain0_s3_hready;       
wire   [1 :0]  smc_hmain0_s3_hresp;        
wire   [31:0]  smc_hmain0_s4_hrdata;       
wire           smc_hmain0_s4_hready;       
wire   [1 :0]  smc_hmain0_s4_hresp;        
wire          dmac0_wic_intr;             
wire  [31:0]  hmain0_cpu_m0_hrdata;       
wire          hmain0_cpu_m0_hready;       
wire  [1 :0]  hmain0_cpu_m0_hresp;        
wire  [31:0]  hmain0_cpu_m1_hrdata;       
wire          hmain0_cpu_m1_hready;       
wire  [1 :0]  hmain0_cpu_m1_hresp;        
wire  [31:0]  hmain0_cpu_m2_hrdata;       
wire          hmain0_cpu_m2_hready;       
wire  [1 :0]  hmain0_cpu_m2_hresp;        
wire  [31:0]  hmain0_ismc_s0_haddr;       
wire  [3 :0]  hmain0_ismc_s0_hprot;       
wire          hmain0_ismc_s0_hsel;        
wire  [2 :0]  hmain0_ismc_s0_hsize;       
wire  [1 :0]  hmain0_ismc_s0_htrans;      
wire  [31:0]  hmain0_ismc_s0_hwdata;      
wire          hmain0_ismc_s0_hwrite;      
wire  [31:0]  hmain0_lsbus_s10_haddr;     
wire  [2 :0]  hmain0_lsbus_s10_hburst;    
wire  [3 :0]  hmain0_lsbus_s10_hprot;     
wire          hmain0_lsbus_s10_hsel;      
wire  [2 :0]  hmain0_lsbus_s10_hsize;     
wire  [1 :0]  hmain0_lsbus_s10_htrans;    
wire  [31:0]  hmain0_lsbus_s10_hwdata;    
wire          hmain0_lsbus_s10_hwrite;    
wire  [31:0]  hmain0_smc_s2_haddr;        
wire  [3 :0]  hmain0_smc_s2_hprot;        
wire          hmain0_smc_s2_hsel;         
wire  [2 :0]  hmain0_smc_s2_hsize;        
wire  [1 :0]  hmain0_smc_s2_htrans;       
wire  [31:0]  hmain0_smc_s2_hwdata;       
wire          hmain0_smc_s2_hwrite;       
wire  [31:0]  hmain0_smc_s3_haddr;        
wire  [3 :0]  hmain0_smc_s3_hprot;        
wire          hmain0_smc_s3_hsel;         
wire  [2 :0]  hmain0_smc_s3_hsize;        
wire  [1 :0]  hmain0_smc_s3_htrans;       
wire  [31:0]  hmain0_smc_s3_hwdata;       
wire          hmain0_smc_s3_hwrite;       
wire  [31:0]  hmain0_smc_s4_haddr;        
wire  [3 :0]  hmain0_smc_s4_hprot;        
wire          hmain0_smc_s4_hsel;         
wire  [2 :0]  hmain0_smc_s4_hsize;        
wire  [1 :0]  hmain0_smc_s4_htrans;       
wire  [31:0]  hmain0_smc_s4_hwdata;       
wire          hmain0_smc_s4_hwrite;       
wire          main_dmemdummy0_intr;       
wire          main_dummy0_intr;           
wire          main_dummy1_intr;           
wire          main_dummy2_intr;           
wire          main_dummy3_intr;           
wire          main_imemdummy0_intr;    

ahb_matrix_top  #(
	.base_s0_addr(32'h00000000),
	.base_s1_addr(32'h00040000),
	.base_s2_addr(32'h00060000),
	.base_s3_addr(32'h00070000),
	.base_s4_addr(32'h00080000),
	.base_s5_addr(32'h00090000),
	.base_s6_addr(32'h000A0000),
	.base_s7_addr(32'h000B0000),
	.base_s8_addr(32'h000C0000),
	.base_s9_addr(32'h000D0000),
	.base_s10_addr(32'h000E0000),
	.base_s11_addr(32'h10000000),

	.mask_s0_addr(32'h0003ffff),
	.mask_s1_addr(32'h0005ffff),
	.mask_s2_addr(32'h0006ffff),
	.mask_s3_addr(32'h0007ffff),
	.mask_s4_addr(32'h0008ffff),
	.mask_s5_addr(32'h0009ffff),
	.mask_s6_addr(32'h000Affff),
	.mask_s7_addr(32'h000Bffff),
	.mask_s8_addr(32'h000Cffff),
	.mask_s9_addr(32'h000Dffff),
	.mask_s10_addr(32'h00Efffff),
	.mask_s11_addr(32'hffffffff)
	)

x_main_bus_top_isolated_bus (
  .cpu_hmain0_m0_haddr     (cpu_hmain0_m0_haddr    ),
  .cpu_hmain0_m0_hburst    (cpu_hmain0_m0_hburst   ),
  .cpu_hmain0_m0_hprot     (cpu_hmain0_m0_hprot    ),
  .cpu_hmain0_m0_hsize     (cpu_hmain0_m0_hsize    ),
  .cpu_hmain0_m0_htrans    (cpu_hmain0_m0_htrans   ),
  .cpu_hmain0_m0_hwdata    (cpu_hmain0_m0_hwdata   ),
  .cpu_hmain0_m0_hwrite    (cpu_hmain0_m0_hwrite   ),
  .cpu_hmain0_m1_haddr     (cpu_hmain0_m1_haddr    ),
  .cpu_hmain0_m1_hburst    (cpu_hmain0_m1_hburst   ),
  .cpu_hmain0_m1_hprot     (cpu_hmain0_m1_hprot    ),
  .cpu_hmain0_m1_hsize     (cpu_hmain0_m1_hsize    ),
  .cpu_hmain0_m1_htrans    (cpu_hmain0_m1_htrans   ),
  .cpu_hmain0_m1_hwdata    (cpu_hmain0_m1_hwdata   ),
  .cpu_hmain0_m1_hwrite    (cpu_hmain0_m1_hwrite   ),
  .cpu_hmain0_m2_haddr     (cpu_hmain0_m2_haddr    ),
  .cpu_hmain0_m2_hburst    (cpu_hmain0_m2_hburst   ),
  .cpu_hmain0_m2_hprot     (cpu_hmain0_m2_hprot    ),
  .cpu_hmain0_m2_hsize     (cpu_hmain0_m2_hsize    ),
  .cpu_hmain0_m2_htrans    (cpu_hmain0_m2_htrans   ),
  .cpu_hmain0_m2_hwdata    (cpu_hmain0_m2_hwdata   ),
  .cpu_hmain0_m2_hwrite    (cpu_hmain0_m2_hwrite   ),
  .dmac0_wic_intr          (dmac0_wic_intr         ),
  .hmain0_cpu_m0_hrdata    (hmain0_cpu_m0_hrdata   ),
  .hmain0_cpu_m0_hready    (hmain0_cpu_m0_hready   ),
  .hmain0_cpu_m0_hresp     (hmain0_cpu_m0_hresp    ),
  .hmain0_cpu_m1_hrdata    (hmain0_cpu_m1_hrdata   ),
  .hmain0_cpu_m1_hready    (hmain0_cpu_m1_hready   ),
  .hmain0_cpu_m1_hresp     (hmain0_cpu_m1_hresp    ),
  .hmain0_cpu_m2_hrdata    (hmain0_cpu_m2_hrdata   ),
  .hmain0_cpu_m2_hready    (hmain0_cpu_m2_hready   ),
  .hmain0_cpu_m2_hresp     (hmain0_cpu_m2_hresp    ),
  .hmain0_ismc_s0_haddr    (hmain0_ismc_s0_haddr   ),
  .hmain0_ismc_s0_hprot    (hmain0_ismc_s0_hprot   ),
  .hmain0_ismc_s0_hsel     (hmain0_ismc_s0_hsel    ),
  .hmain0_ismc_s0_hsize    (hmain0_ismc_s0_hsize   ),
  .hmain0_ismc_s0_htrans   (hmain0_ismc_s0_htrans  ),
  .hmain0_ismc_s0_hwdata   (hmain0_ismc_s0_hwdata  ),
  .hmain0_ismc_s0_hwrite   (hmain0_ismc_s0_hwrite  ),
  .hmain0_lsbus_s10_haddr  (hmain0_lsbus_s10_haddr ),
  .hmain0_lsbus_s10_hburst (hmain0_lsbus_s10_hburst),
  .hmain0_lsbus_s10_hprot  (hmain0_lsbus_s10_hprot ),
  .hmain0_lsbus_s10_hsel   (hmain0_lsbus_s10_hsel  ),
  .hmain0_lsbus_s10_hsize  (hmain0_lsbus_s10_hsize ),
  .hmain0_lsbus_s10_htrans (hmain0_lsbus_s10_htrans),
  .hmain0_lsbus_s10_hwdata (hmain0_lsbus_s10_hwdata),
  .hmain0_lsbus_s10_hwrite (hmain0_lsbus_s10_hwrite),
  .hmain0_smc_s2_haddr     (hmain0_smc_s2_haddr    ),
  .hmain0_smc_s2_hprot     (hmain0_smc_s2_hprot    ),
  .hmain0_smc_s2_hsel      (hmain0_smc_s2_hsel     ),
  .hmain0_smc_s2_hsize     (hmain0_smc_s2_hsize    ),
  .hmain0_smc_s2_htrans    (hmain0_smc_s2_htrans   ),
  .hmain0_smc_s2_hwdata    (hmain0_smc_s2_hwdata   ),
  .hmain0_smc_s2_hwrite    (hmain0_smc_s2_hwrite   ),
  .hmain0_smc_s3_haddr     (hmain0_smc_s3_haddr    ),
  .hmain0_smc_s3_hprot     (hmain0_smc_s3_hprot    ),
  .hmain0_smc_s3_hsel      (hmain0_smc_s3_hsel     ),
  .hmain0_smc_s3_hsize     (hmain0_smc_s3_hsize    ),
  .hmain0_smc_s3_htrans    (hmain0_smc_s3_htrans   ),
  .hmain0_smc_s3_hwdata    (hmain0_smc_s3_hwdata   ),
  .hmain0_smc_s3_hwrite    (hmain0_smc_s3_hwrite   ),
  .hmain0_smc_s4_haddr     (hmain0_smc_s4_haddr    ),
  .hmain0_smc_s4_hprot     (hmain0_smc_s4_hprot    ),
  .hmain0_smc_s4_hsel      (hmain0_smc_s4_hsel     ),
  .hmain0_smc_s4_hsize     (hmain0_smc_s4_hsize    ),
  .hmain0_smc_s4_htrans    (hmain0_smc_s4_htrans   ),
  .hmain0_smc_s4_hwdata    (hmain0_smc_s4_hwdata   ),
  .hmain0_smc_s4_hwrite    (hmain0_smc_s4_hwrite   ),
  .ismc_hmain0_s0_hrdata   (ismc_hmain0_s0_hrdata  ),
  .ismc_hmain0_s0_hready   (ismc_hmain0_s0_hready  ),
  .ismc_hmain0_s0_hresp    (ismc_hmain0_s0_hresp   ),
  .lsbus_hmain0_s10_hrdata (lsbus_hmain0_s10_hrdata),
  .lsbus_hmain0_s10_hready (lsbus_hmain0_s10_hready),
  .lsbus_hmain0_s10_hresp  (lsbus_hmain0_s10_hresp ),
  .main_dmemdummy0_intr    (main_dmemdummy0_intr   ),
  .main_dummy0_intr        (main_dummy0_intr       ),
  .main_dummy1_intr        (main_dummy1_intr       ),
  .main_dummy2_intr        (main_dummy2_intr       ),
  .main_dummy3_intr        (main_dummy3_intr       ),
  .main_imemdummy0_intr    (main_imemdummy0_intr   ),
  .pmu_dmac0_hclk          (pad_core_clk         ),
  .pmu_dmac0_hrst_b        (pad_core_rst_b       ),
  .pmu_dmemdummy0_hclk     (pad_core_clk    ),
  .pmu_dmemdummy0_hrst_b   (pad_core_rst_b  ),
  .pmu_dummy0_hclk         (pad_core_clk        ),
  .pmu_dummy0_hrst_b       (pad_core_rst_b      ),
  .pmu_dummy1_hclk         (pad_core_clk        ),
  .pmu_dummy1_hrst_b       (pad_core_rst_b      ),
  .pmu_dummy2_hclk         (pad_core_clk        ),
  .pmu_dummy2_hrst_b       (pad_core_rst_b      ),
  .pmu_dummy3_hclk         (pad_core_clk        ),
  .pmu_dummy3_hrst_b       (pad_core_rst_b      ),
  .pmu_hmain0_hclk         (pad_core_clk        ),
  .pmu_hmain0_hrst_b       (pad_core_rst_b      ),
  .pmu_imemdummy0_hclk     (pad_core_clk    ),
  .pmu_imemdummy0_hrst_b   (pad_core_rst_b  ),
  .pmu_mdummy0_hclk        (pad_core_clk       ),
  .pmu_mdummy0_hrst_b      (pad_core_rst_b     ),
  .pmu_mdummy1_hclk        (pad_core_clk       ),
  .pmu_mdummy1_hrst_b      (pad_core_rst_b     ),
  .pmu_mdummy2_hclk        (pad_core_clk       ),
  .pmu_mdummy2_hrst_b      (pad_core_rst_b     ),
  .smc_hmain0_s2_hrdata    (smc_hmain0_s2_hrdata   ),
  .smc_hmain0_s2_hready    (smc_hmain0_s2_hready   ),
  .smc_hmain0_s2_hresp     (smc_hmain0_s2_hresp    ),
  .smc_hmain0_s3_hrdata    (smc_hmain0_s3_hrdata   ),
  .smc_hmain0_s3_hready    (smc_hmain0_s3_hready   ),
  .smc_hmain0_s3_hresp     (smc_hmain0_s3_hresp    ),
  .smc_hmain0_s4_hrdata    (smc_hmain0_s4_hrdata   ),
  .smc_hmain0_s4_hready    (smc_hmain0_s4_hready   ),
  .smc_hmain0_s4_hresp     (smc_hmain0_s4_hresp    ),
  //////////////////////////////////////////////////////
  .mdummy0_hmain0_m4_haddr (mdummy0_hmain0_m4_haddr),    
  .mdummy0_hmain0_m4_hburst (mdummy0_hmain0_m4_hburst),   
  .mdummy0_hmain0_m4_hprot (mdummy0_hmain0_m4_hprot),    
  .mdummy0_hmain0_m4_hsize (mdummy0_hmain0_m4_hsize),    
  .mdummy0_hmain0_m4_htrans (mdummy0_hmain0_m4_htrans),   
  .mdummy0_hmain0_m4_hwdata (mdummy0_hmain0_m4_hwdata),   
  .mdummy0_hmain0_m4_hwrite (mdummy0_hmain0_m4_hwrite),   
  .mdummy1_hmain0_m5_haddr (mdummy1_hmain0_m5_haddr),    
  .mdummy1_hmain0_m5_hburst (mdummy1_hmain0_m5_hburst),   
  .mdummy1_hmain0_m5_hprot (mdummy1_hmain0_m5_hprot),    
  .mdummy1_hmain0_m5_hsize (mdummy1_hmain0_m5_hsize),    
  .mdummy1_hmain0_m5_htrans (mdummy1_hmain0_m5_htrans),   
  .mdummy1_hmain0_m5_hwdata (mdummy1_hmain0_m5_hwdata),   
  .mdummy1_hmain0_m5_hwrite (mdummy1_hmain0_m5_hwrite),

  .hmain0_imemdummy0_s1_haddr(hmain0_imemdummy0_s1_haddr), 
  .hmain0_imemdummy0_s1_hburst(hmain0_imemdummy0_s1_hburst), 
  .hmain0_imemdummy0_s1_hprot(hmain0_imemdummy0_s1_hprot), 
  .hmain0_imemdummy0_s1_hsel(hmain0_imemdummy0_s1_hsel),  
  .hmain0_imemdummy0_s1_hsize(hmain0_imemdummy0_s1_hsize), 
  .hmain0_imemdummy0_s1_htrans(hmain0_imemdummy0_s1_htrans), 
  .hmain0_imemdummy0_s1_hwdata(hmain0_imemdummy0_s1_hwdata), 
  .hmain0_imemdummy0_s1_hwrite(hmain0_imemdummy0_s1_hwrite),
  .hmain0_dmemdummy0_s5_haddr(hmain0_dmemdummy0_s5_haddr), 
  .hmain0_dmemdummy0_s5_hburst(hmain0_dmemdummy0_s5_hburst), 
  .hmain0_dmemdummy0_s5_hprot(hmain0_dmemdummy0_s5_hprot), 
  .hmain0_dmemdummy0_s5_hsel(hmain0_dmemdummy0_s5_hsel),  
  .hmain0_dmemdummy0_s5_hsize(hmain0_dmemdummy0_s5_hsize), 
  .hmain0_dmemdummy0_s5_htrans(hmain0_dmemdummy0_s5_htrans), 
  .hmain0_dmemdummy0_s5_hwdata(hmain0_dmemdummy0_s5_hwdata), 
  .hmain0_dmemdummy0_s5_hwrite(hmain0_dmemdummy0_s5_hwrite),
  .hmain0_dummy3_s11_haddr(hmain0_dummy3_s11_haddr),    
  .hmain0_dummy3_s11_hburst(hmain0_dummy3_s11_hburst),   
  .hmain0_dummy3_s11_hprot(hmain0_dummy3_s11_hprot),    
  .hmain0_dummy3_s11_hsel(hmain0_dummy3_s11_hsel),     
  .hmain0_dummy3_s11_hsize(hmain0_dummy3_s11_hsize),    
  .hmain0_dummy3_s11_htrans(hmain0_dummy3_s11_htrans),   
  .hmain0_dummy3_s11_hwdata(hmain0_dummy3_s11_hwdata),   
  .hmain0_dummy3_s11_hwrite(hmain0_dummy3_s11_hwrite),
  .hmain0_dummy0_s7_haddr(hmain0_dummy0_s7_haddr),     
  .hmain0_dummy0_s7_hburst(hmain0_dummy0_s7_hburst),    
  .hmain0_dummy0_s7_hprot(hmain0_dummy0_s7_hprot),     
  .hmain0_dummy0_s7_hsel(hmain0_dummy0_s7_hsel),      
  .hmain0_dummy0_s7_hsize(hmain0_dummy0_s7_hsize),     
  .hmain0_dummy0_s7_htrans(hmain0_dummy0_s7_htrans),    
  .hmain0_dummy0_s7_hwdata(hmain0_dummy0_s7_hwdata),    
  .hmain0_dummy0_s7_hwrite(hmain0_dummy0_s7_hwrite),    
  .hmain0_dummy1_s8_haddr(hmain0_dummy1_s8_haddr),     
  .hmain0_dummy1_s8_hburst(hmain0_dummy1_s8_hburst),    
  .hmain0_dummy1_s8_hprot(hmain0_dummy1_s8_hprot),     
  .hmain0_dummy1_s8_hsel(hmain0_dummy1_s8_hsel),      
  .hmain0_dummy1_s8_hsize(hmain0_dummy1_s8_hsize),     
  .hmain0_dummy1_s8_htrans(hmain0_dummy1_s8_htrans),    
  .hmain0_dummy1_s8_hwdata(hmain0_dummy1_s8_hwdata),    
  .hmain0_dummy1_s8_hwrite(hmain0_dummy1_s8_hwrite),    
  .hmain0_dummy2_s9_haddr(hmain0_dummy2_s9_haddr),     
  .hmain0_dummy2_s9_hburst(hmain0_dummy2_s9_hburst),    
  .hmain0_dummy2_s9_hprot(hmain0_dummy2_s9_hprot),     
  .hmain0_dummy2_s9_hsel(hmain0_dummy2_s9_hsel),      
  .hmain0_dummy2_s9_hsize(hmain0_dummy2_s9_hsize),     
  .hmain0_dummy2_s9_htrans(hmain0_dummy2_s9_htrans),    
  .hmain0_dummy2_s9_hwdata(hmain0_dummy2_s9_hwdata),    
  .hmain0_dummy2_s9_hwrite(hmain0_dummy2_s9_hwrite),

  .hmain0_mdummy0_m4_hgrant (hmain0_mdummy0_m4_hgrant),   
  .hmain0_mdummy0_m4_hrdata (hmain0_mdummy0_m4_hrdata),   
  .hmain0_mdummy0_m4_hready (hmain0_mdummy0_m4_hready),   
  .hmain0_mdummy0_m4_hresp (hmain0_mdummy0_m4_hresp),    
  .hmain0_mdummy1_m5_hgrant (hmain0_mdummy1_m5_hgrant),   
  .hmain0_mdummy1_m5_hrdata (hmain0_mdummy1_m5_hrdata),   
  .hmain0_mdummy1_m5_hready (hmain0_mdummy1_m5_hready),   
  .hmain0_mdummy1_m5_hresp  (hmain0_mdummy1_m5_hresp),

  .imemdummy0_hmain0_s1_hrdata(imemdummy0_hmain0_s1_hrdata),
  .imemdummy0_hmain0_s1_hready(imemdummy0_hmain0_s1_hready), 
  .imemdummy0_hmain0_s1_hresp(imemdummy0_hmain0_s1_hresp),
  .dmemdummy0_hmain0_s5_hrdata(dmemdummy0_hmain0_s5_hrdata), 
  .dmemdummy0_hmain0_s5_hready(dmemdummy0_hmain0_s5_hready), 
  .dmemdummy0_hmain0_s5_hresp(dmemdummy0_hmain0_s5_hresp), 
  .dummy3_hmain0_s11_hrdata(dummy3_hmain0_s11_hrdata),   
  .dummy3_hmain0_s11_hready(dummy3_hmain0_s11_hready),   
  .dummy3_hmain0_s11_hresp(dummy3_hmain0_s11_hresp), 
  .dummy0_hmain0_s7_hrdata(dummy0_hmain0_s7_hrdata),    
  .dummy0_hmain0_s7_hready(dummy0_hmain0_s7_hready),    
  .dummy0_hmain0_s7_hresp(dummy0_hmain0_s7_hresp),     
  .dummy1_hmain0_s8_hrdata(dummy1_hmain0_s8_hrdata),    
  .dummy1_hmain0_s8_hready(dummy1_hmain0_s8_hready),    
  .dummy1_hmain0_s8_hresp(dummy1_hmain0_s8_hresp),     
  .dummy2_hmain0_s9_hrdata(dummy2_hmain0_s9_hrdata),    
  .dummy2_hmain0_s9_hready(dummy2_hmain0_s9_hready),    
  .dummy2_hmain0_s9_hresp(dummy2_hmain0_s9_hresp)
);

core_top  #(
	.CPU_ID(2'b00)	
)
   TEE_CPU (
  .WMAB_R2T_Interrupt	 (WMAB_R2T_Interrupt),
  .RMAB_R2T_Interrupt	 (0),
  .WMAB_T2R_Interrupt	 (0),
  .RMAB_T2R_Interrupt	 (RMAB_T2R_Interrupt),
  .RSA_Intr   			 (RSA_Intr),
  .AES_Intr				 (AES_Intr),
  .SHA_Intr   			 (SHA_Intr),
  .REE_IOPMP_Intr		 (REE_IOPMP_Intr),
  .CryptoCore_IOPMP_Intr (CryptoCore_IOPMP_Intr),
  .apb0_dummy1_intr      (0     ),
  .apb0_dummy2_intr      (0     ),
  .apb0_dummy3_intr      (0     ),
  .apb0_dummy4_intr      (0     ),
  .apb0_dummy5_intr      (0     ),
  .apb0_dummy7_intr      (0     ),
  .apb0_dummy8_intr      (0     ),
  .apb0_dummy9_intr      (0     ),
  .apb1_dummy1_intr      (0     ),
  .apb1_dummy2_intr      (0     ),
  .apb1_dummy3_intr      (0     ),
  .apb1_dummy4_intr      (0     ),
  .apb1_dummy5_intr      (0     ),
  .apb1_dummy6_intr      (0     ),
  .apb1_dummy7_intr      (0     ),
  .apb1_dummy8_intr      (0     ),
  .bist0_mode            (0           ),
  .cpu_hmain0_m0_haddr   (cpu_hmain0_m0_haddr  ),
  .cpu_hmain0_m0_hburst  (cpu_hmain0_m0_hburst ),
  .cpu_hmain0_m0_hprot   (cpu_hmain0_m0_hprot  ),
  .cpu_hmain0_m0_hsize   (cpu_hmain0_m0_hsize  ),
  .cpu_hmain0_m0_htrans  (cpu_hmain0_m0_htrans ),
  .cpu_hmain0_m0_hwdata  (cpu_hmain0_m0_hwdata ),
  .cpu_hmain0_m0_hwrite  (cpu_hmain0_m0_hwrite ),
  .cpu_hmain0_m1_haddr   (cpu_hmain0_m1_haddr),
  .cpu_hmain0_m1_hburst  (cpu_hmain0_m1_hburst),
  .cpu_hmain0_m1_hprot   (cpu_hmain0_m1_hprot),
  .cpu_hmain0_m1_hsize   (cpu_hmain0_m1_hsize),
  .cpu_hmain0_m1_htrans  (cpu_hmain0_m1_htrans),
  .cpu_hmain0_m1_hwdata  (cpu_hmain0_m1_hwdata),
  .cpu_hmain0_m1_hwrite  (cpu_hmain0_m1_hwrite),
  .cpu_hmain0_m2_haddr   (cpu_hmain0_m2_haddr  ),
  .cpu_hmain0_m2_hburst  (cpu_hmain0_m2_hburst ),
  .cpu_hmain0_m2_hprot   (cpu_hmain0_m2_hprot  ),
  .cpu_hmain0_m2_hsize   (cpu_hmain0_m2_hsize  ),
  .cpu_hmain0_m2_htrans  (cpu_hmain0_m2_htrans ),
  .cpu_hmain0_m2_hwdata  (cpu_hmain0_m2_hwdata ),
  .cpu_hmain0_m2_hwrite  (cpu_hmain0_m2_hwrite ),
  .cpu_padmux_jtg_tms_o  (cpu_padmux_jtg_tms_o ),
  .cpu_padmux_jtg_tms_oe (cpu_padmux_jtg_tms_oe),
  .cpu_pmu_dfs_ack       (cpu_pmu_dfs_ack      ),
  .cpu_pmu_sleep_b       (cpu_pmu_sleep_b      ),
  .dft_clk               (dft_clk              ),
  .dmac0_wic_intr        (0       ),
  .gpio_wic_intr         (0        ),
  .hmain0_cpu_m0_hrdata  (hmain0_cpu_m0_hrdata ),
  .hmain0_cpu_m0_hready  (hmain0_cpu_m0_hready ),
  .hmain0_cpu_m0_hresp   (hmain0_cpu_m0_hresp  ),
  .hmain0_cpu_m1_hrdata  (hmain0_cpu_m1_hrdata),
  .hmain0_cpu_m1_hready  (hmain0_cpu_m1_hready),
  .hmain0_cpu_m1_hresp   (hmain0_cpu_m1_hresp),
  .hmain0_cpu_m2_hrdata  (hmain0_cpu_m2_hrdata ),
  .hmain0_cpu_m2_hready  (hmain0_cpu_m2_hready ),
  .hmain0_cpu_m2_hresp   (hmain0_cpu_m2_hresp  ),
  .lsbus_dummy0_intr     (0    ),
  .lsbus_dummy1_intr     (0    ),
  .lsbus_dummy2_intr     (0    ),
  .lsbus_dummy3_intr     (0    ),
  .main_dmemdummy0_intr  (0 ),
  .main_dummy0_intr      (0     ),
  .main_dummy1_intr      (0     ),
  .main_dummy2_intr      (0     ),
  .main_dummy3_intr      (0     ),
  .main_imemdummy0_intr  (0 ),
  .pad_core_clk          (pad_core_clk         ),
  .pad_core_ctim_refclk  (pad_core_ctim_refclk ),
  .pad_core_rst_b        (pad_core_rst_b       ),
  .padmux_cpu_jtg_tclk   (padmux_cpu_jtg_tclk  ),
  .padmux_cpu_jtg_tms_i  (padmux_cpu_jtg_tms_i ),
  .pmu_cpu_dfs_req       (pmu_cpu_dfs_req      ),
  .pmu_wic_intr          (0         ),
  .pwm_wic_intr          (0         ),
  .rtc_wic_intr          (0         ),
  .scan_en               (scan_en              ),
  .scan_mode             (scan_mode            ),
  .test_mode             (test_mode            ),
  .tim0_wic_intr         (tim0_wic_intr        ),
  .tim1_wic_intr         (0        ),
  .tim2_wic_intr         (0        ),
  .tim3_wic_intr         (0        ),
  .tim4_wic_intr         (0        ),
  .tim5_wic_intr         (0        ),
  .tim6_wic_intr         (0        ),
  .tim7_wic_intr         (0        ),
  .usi0_wic_intr         (0        ),
  .usi1_wic_intr         (usi1_wic_intr        ),
  .usi2_wic_intr         (0        ),
  .wdt_wic_intr          (0         ),
  .cpu_rst_addr_set      (32'h00000000)//32'h00010000
);

retu_top_BootRom  BootRom (
  .hmain0_ismc_s0_haddr  (hmain0_ismc_s0_haddr ),
  .hmain0_ismc_s0_hprot  (hmain0_ismc_s0_hprot ),
  .hmain0_ismc_s0_hsel   (hmain0_ismc_s0_hsel  ),
  .hmain0_ismc_s0_hsize  (hmain0_ismc_s0_hsize ),
  .hmain0_ismc_s0_htrans (hmain0_ismc_s0_htrans),
  .hmain0_ismc_s0_hwdata (hmain0_ismc_s0_hwdata),
  .hmain0_ismc_s0_hwrite (hmain0_ismc_s0_hwrite),
  .hmain0_smc_s2_haddr   (  ),
  .hmain0_smc_s2_hprot   (  ),
  .hmain0_smc_s2_hsel    (  ),
  .hmain0_smc_s2_hsize   (  ),
  .hmain0_smc_s2_htrans  ( ),
  .hmain0_smc_s2_hwdata  ( ),
  .hmain0_smc_s2_hwrite  ( ),
  .hmain0_smc_s3_haddr   (  ),
  .hmain0_smc_s3_hprot   (  ),
  .hmain0_smc_s3_hsel    (   ),
  .hmain0_smc_s3_hsize   (  ),
  .hmain0_smc_s3_htrans  ( ),
  .hmain0_smc_s3_hwdata  ( ),
  .hmain0_smc_s3_hwrite  (),
  .hmain0_smc_s4_haddr   (  ),
  .hmain0_smc_s4_hprot   ( ),
  .hmain0_smc_s4_hsel    (   ),
  .hmain0_smc_s4_hsize   (  ),
  .hmain0_smc_s4_htrans  ( ),
  .hmain0_smc_s4_hwdata  ( ),
  .hmain0_smc_s4_hwrite  ( ),
  .ismc_hmain0_s0_hrdata (ismc_hmain0_s0_hrdata),
  .ismc_hmain0_s0_hready (ismc_hmain0_s0_hready),
  .ismc_hmain0_s0_hresp  (ismc_hmain0_s0_hresp ),
  .pmu_smc_hclk          (pad_core_clk         ),
  .pmu_smc_hrst_b        (pad_core_rst_b       ),
  .smc_hmain0_s2_hrdata  ( ),
  .smc_hmain0_s2_hready  ( ),
  .smc_hmain0_s2_hresp   ( ),
  .smc_hmain0_s3_hrdata  ( ),
  .smc_hmain0_s3_hready  ( ),
  .smc_hmain0_s3_hresp   (  ),
  .smc_hmain0_s4_hrdata  (),
  .smc_hmain0_s4_hready  ( ),
  .smc_hmain0_s4_hresp   (  )
);

retu_top_BootRom  ZSBL_RAM (
  .hmain0_ismc_s0_haddr  (hmain0_imemdummy0_s1_haddr ),
  .hmain0_ismc_s0_hprot  (hmain0_imemdummy0_s1_hprot ),
  .hmain0_ismc_s0_hsel   (hmain0_imemdummy0_s1_hsel  ),
  .hmain0_ismc_s0_hsize  (hmain0_imemdummy0_s1_hsize ),
  .hmain0_ismc_s0_htrans (hmain0_imemdummy0_s1_htrans),
  .hmain0_ismc_s0_hwdata (hmain0_imemdummy0_s1_hwdata),
  .hmain0_ismc_s0_hwrite (hmain0_imemdummy0_s1_hwrite),
  .hmain0_smc_s2_haddr   (  ),
  .hmain0_smc_s2_hprot   (  ),
  .hmain0_smc_s2_hsel    (  ),
  .hmain0_smc_s2_hsize   (  ),
  .hmain0_smc_s2_htrans  ( ),
  .hmain0_smc_s2_hwdata  ( ),
  .hmain0_smc_s2_hwrite  ( ),
  .hmain0_smc_s3_haddr   (  ),
  .hmain0_smc_s3_hprot   (  ),
  .hmain0_smc_s3_hsel    (   ),
  .hmain0_smc_s3_hsize   (  ),
  .hmain0_smc_s3_htrans  ( ),
  .hmain0_smc_s3_hwdata  ( ),
  .hmain0_smc_s3_hwrite  (),
  .hmain0_smc_s4_haddr   (  ),
  .hmain0_smc_s4_hprot   ( ),
  .hmain0_smc_s4_hsel    (   ),
  .hmain0_smc_s4_hsize   (  ),
  .hmain0_smc_s4_htrans  ( ),
  .hmain0_smc_s4_hwdata  ( ),
  .hmain0_smc_s4_hwrite  ( ),
  .ismc_hmain0_s0_hrdata (imemdummy0_hmain0_s1_hrdata),
  .ismc_hmain0_s0_hready (imemdummy0_hmain0_s1_hready),
  .ismc_hmain0_s0_hresp  (imemdummy0_hmain0_s1_hresp ),
  .pmu_smc_hclk          (pad_core_clk         ),
  .pmu_smc_hrst_b        (pad_core_rst_b       ),
  .smc_hmain0_s2_hrdata  ( ),
  .smc_hmain0_s2_hready  ( ),
  .smc_hmain0_s2_hresp   ( ),
  .smc_hmain0_s3_hrdata  ( ),
  .smc_hmain0_s3_hready  ( ),
  .smc_hmain0_s3_hresp   (  ),
  .smc_hmain0_s4_hrdata  (),
  .smc_hmain0_s4_hready  ( ),
  .smc_hmain0_s4_hresp   (  )
);

Start_REE_CPU x_Start_REE_CPU(  
  .haddr(hmain0_smc_s2_haddr),
  .hclk(pad_core_clk),
  .hprot(hmain0_smc_s2_hprot),
  .hrdata(smc_hmain0_s2_hrdata),
  .hready(smc_hmain0_s2_hready),
  .hresp(smc_hmain0_s2_hresp),
  .hrst_b(pad_core_rst_b),
  .hsel(hmain0_smc_s2_hsel),
  .hsize(hmain0_smc_s2_hsize),
  .htrans(hmain0_smc_s2_htrans),
  .hwdata(hmain0_smc_s2_hwdata),
  .hwrite(hmain0_smc_s2_hwrite),
  .intr(),

  .ree_cpu_rst_addr(ree_cpu_rst_addr),
  .ree_cpu_rst_n(ree_cpu_rst_n)
); 
/*
ahb_dummy_top  x_main_imemdummy_top0 (
  .haddr                       (hmain0_imemdummy0_s1_haddr ),
  .hclk                        (pad_core_clk        ),
  .hprot                       (hmain0_imemdummy0_s1_hprot ),
  .hrdata                      (imemdummy0_hmain0_s1_hrdata),
  .hready                      (imemdummy0_hmain0_s1_hready),
  .hresp                       (imemdummy0_hmain0_s1_hresp ),
  .hrst_b                      (pad_core_rst_b      ),
  .hsel                        (hmain0_imemdummy0_s1_hsel  ),
  .hsize                       (hmain0_imemdummy0_s1_hsize ),
  .htrans                      (hmain0_imemdummy0_s1_htrans),
  .hwdata                      (hmain0_imemdummy0_s1_hwdata),
  .hwrite                      (hmain0_imemdummy0_s1_hwrite),
  .intr                        (main_imemdummy0_intr       )
);*/
ahb_dummy_top  x_main_dmemdummy_top0 (
  .haddr                       (hmain0_dmemdummy0_s5_haddr ),
  .hclk                        (pad_core_clk        ),
  .hprot                       (hmain0_dmemdummy0_s5_hprot ),
  .hrdata                      (dmemdummy0_hmain0_s5_hrdata),
  .hready                      (dmemdummy0_hmain0_s5_hready),
  .hresp                       (dmemdummy0_hmain0_s5_hresp ),
  .hrst_b                      (pad_core_rst_b      ),
  .hsel                        (hmain0_dmemdummy0_s5_hsel  ),
  .hsize                       (hmain0_dmemdummy0_s5_hsize ),
  .htrans                      (hmain0_dmemdummy0_s5_htrans),
  .hwdata                      (hmain0_dmemdummy0_s5_hwdata),
  .hwrite                      (hmain0_dmemdummy0_s5_hwrite),
  .intr                        (main_dmemdummy0_intr       )
);
ahb_dummy_top  x_main_dummy_top0 (
  .haddr                   (hmain0_dummy0_s7_haddr ),
  .hclk                    (pad_core_clk           ),
  .hprot                   (hmain0_dummy0_s7_hprot ),
  .hrdata                  (dummy0_hmain0_s7_hrdata),
  .hready                  (dummy0_hmain0_s7_hready),
  .hresp                   (dummy0_hmain0_s7_hresp ),
  .hrst_b                  (pad_core_rst_b      ),
  .hsel                    (hmain0_dummy0_s7_hsel  ),
  .hsize                   (hmain0_dummy0_s7_hsize ),
  .htrans                  (hmain0_dummy0_s7_htrans),
  .hwdata                  (hmain0_dummy0_s7_hwdata),
  .hwrite                  (hmain0_dummy0_s7_hwrite),
  .intr                    (main_dummy0_intr       )
);

ahb_dummy_top  x_main_dummy_top1 (
  .haddr                   (hmain0_dummy1_s8_haddr ),
  .hclk                    (pad_core_clk       ),
  .hprot                   (hmain0_dummy1_s8_hprot ),
  .hrdata                  (dummy1_hmain0_s8_hrdata),
  .hready                  (dummy1_hmain0_s8_hready),
  .hresp                   (dummy1_hmain0_s8_hresp ),
  .hrst_b                  (pad_core_rst_b      ),
  .hsel                    (hmain0_dummy1_s8_hsel  ),
  .hsize                   (hmain0_dummy1_s8_hsize ),
  .htrans                  (hmain0_dummy1_s8_htrans),
  .hwdata                  (hmain0_dummy1_s8_hwdata),
  .hwrite                  (hmain0_dummy1_s8_hwrite),
  .intr                    (main_dummy1_intr       )
);
ahb_dummy_top  x_main_dummy_top2 (
  .haddr                   (hmain0_dummy2_s9_haddr ),
  .hclk                    (pad_core_clk           ),
  .hprot                   (hmain0_dummy2_s9_hprot ),
  .hrdata                  (dummy2_hmain0_s9_hrdata),
  .hready                  (dummy2_hmain0_s9_hready),
  .hresp                   (dummy2_hmain0_s9_hresp ),
  .hrst_b                  (pad_core_rst_b      ),
  .hsel                    (hmain0_dummy2_s9_hsel  ),
  .hsize                   (hmain0_dummy2_s9_hsize ),
  .htrans                  (hmain0_dummy2_s9_htrans),
  .hwdata                  (hmain0_dummy2_s9_hwdata),
  .hwrite                  (hmain0_dummy2_s9_hwrite),
  .intr                    (main_dummy2_intr       )
);
ahbm_dummy_top  x_main_mdummy_top0 (
  .hclk                     (pad_core_clk       ),
  .hrst_b                   (pad_core_rst_b      ),
  .mhaddr                   (mdummy0_hmain0_m4_haddr ),
  .mhburst                  (mdummy0_hmain0_m4_hburst),
  .mhgrant                  (hmain0_mdummy0_m4_hgrant),
  .mhprot                   (mdummy0_hmain0_m4_hprot ),
  .mhrdata                  (hmain0_mdummy0_m4_hrdata),
  .mhready                  (hmain0_mdummy0_m4_hready),
  .mhresp                   (hmain0_mdummy0_m4_hresp ),
  .mhsize                   (mdummy0_hmain0_m4_hsize ),
  .mhtrans                  (mdummy0_hmain0_m4_htrans),
  .mhwdata                  (mdummy0_hmain0_m4_hwdata),
  .mhwrite                  (mdummy0_hmain0_m4_hwrite)
);
ahbm_dummy_top  x_main_mdummy_top1 (
  .hclk                     (pad_core_clk        ),
  .hrst_b                   (pad_core_rst_b      ),
  .mhaddr                   (mdummy1_hmain0_m5_haddr ),
  .mhburst                  (mdummy1_hmain0_m5_hburst),
  .mhgrant                  (hmain0_mdummy1_m5_hgrant),
  .mhprot                   (mdummy1_hmain0_m5_hprot ),
  .mhrdata                  (hmain0_mdummy1_m5_hrdata),
  .mhready                  (hmain0_mdummy1_m5_hready),
  .mhresp                   (hmain0_mdummy1_m5_hresp ),
  .mhsize                   (mdummy1_hmain0_m5_hsize ),
  .mhtrans                  (mdummy1_hmain0_m5_htrans),
  .mhwdata                  (mdummy1_hmain0_m5_hwdata),
  .mhwrite                  (mdummy1_hmain0_m5_hwrite)
);
/*ahbm_dummy_top  x_main_mdummy_top2 (
  .hclk                     (pad_core_clk        ),
  .hrst_b                   (pad_core_rst_b      ),
  .mhaddr                   (mdummy2_hmain0_m6_haddr ),
  .mhburst                  (mdummy2_hmain0_m6_hburst),
  .mhgrant                  (hmain0_mdummy2_m6_hgrant),
  .mhprot                   (mdummy2_hmain0_m6_hprot ),
  .mhrdata                  (hmain0_mdummy2_m6_hrdata),
  .mhready                  (hmain0_mdummy2_m6_hready),
  .mhresp                   (hmain0_mdummy2_m6_hresp ),
  .mhsize                   (mdummy2_hmain0_m6_hsize ),
  .mhtrans                  (mdummy2_hmain0_m6_htrans),
  .mhwdata                  (mdummy2_hmain0_m6_hwdata),
  .mhwrite                  (mdummy2_hmain0_m6_hwrite)
);*/
endmodule
