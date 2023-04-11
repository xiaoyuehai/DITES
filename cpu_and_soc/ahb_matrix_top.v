/*
Copyright (c) 2019 Alibaba Group Holding Limited

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/
module ahb_matrix_top(
  cpu_hmain0_m0_haddr,
  cpu_hmain0_m0_hburst,
  cpu_hmain0_m0_hprot,
  cpu_hmain0_m0_hsize,
  cpu_hmain0_m0_htrans,
  cpu_hmain0_m0_hwdata,
  cpu_hmain0_m0_hwrite,
  cpu_hmain0_m1_haddr,
  cpu_hmain0_m1_hburst,
  cpu_hmain0_m1_hprot,
  cpu_hmain0_m1_hsize,
  cpu_hmain0_m1_htrans,
  cpu_hmain0_m1_hwdata,
  cpu_hmain0_m1_hwrite,
  cpu_hmain0_m2_haddr,
  cpu_hmain0_m2_hburst,
  cpu_hmain0_m2_hprot,
  cpu_hmain0_m2_hsize,
  cpu_hmain0_m2_htrans,
  cpu_hmain0_m2_hwdata,
  cpu_hmain0_m2_hwrite,
  dmac0_wic_intr,
  hmain0_cpu_m0_hrdata,
  hmain0_cpu_m0_hready,
  hmain0_cpu_m0_hresp,
  hmain0_cpu_m1_hrdata,
  hmain0_cpu_m1_hready,
  hmain0_cpu_m1_hresp,
  hmain0_cpu_m2_hrdata,
  hmain0_cpu_m2_hready,
  hmain0_cpu_m2_hresp,
  hmain0_ismc_s0_haddr,
  hmain0_ismc_s0_hprot,
  hmain0_ismc_s0_hsel,
  hmain0_ismc_s0_hsize,
  hmain0_ismc_s0_htrans,
  hmain0_ismc_s0_hwdata,
  hmain0_ismc_s0_hwrite,
  hmain0_lsbus_s10_haddr,
  hmain0_lsbus_s10_hburst,
  hmain0_lsbus_s10_hprot,
  hmain0_lsbus_s10_hsel,
  hmain0_lsbus_s10_hsize,
  hmain0_lsbus_s10_htrans,
  hmain0_lsbus_s10_hwdata,
  hmain0_lsbus_s10_hwrite,
  hmain0_smc_s2_haddr,
  hmain0_smc_s2_hprot,
  hmain0_smc_s2_hsel,
  hmain0_smc_s2_hsize,
  hmain0_smc_s2_htrans,
  hmain0_smc_s2_hwdata,
  hmain0_smc_s2_hwrite,
  hmain0_smc_s3_haddr,
  hmain0_smc_s3_hprot,
  hmain0_smc_s3_hsel,
  hmain0_smc_s3_hsize,
  hmain0_smc_s3_htrans,
  hmain0_smc_s3_hwdata,
  hmain0_smc_s3_hwrite,
  hmain0_smc_s4_haddr,
  hmain0_smc_s4_hprot,
  hmain0_smc_s4_hsel,
  hmain0_smc_s4_hsize,
  hmain0_smc_s4_htrans,
  hmain0_smc_s4_hwdata,
  hmain0_smc_s4_hwrite,
  ismc_hmain0_s0_hrdata,
  ismc_hmain0_s0_hready,
  ismc_hmain0_s0_hresp,
  lsbus_hmain0_s10_hrdata,
  lsbus_hmain0_s10_hready,
  lsbus_hmain0_s10_hresp,
  main_dmemdummy0_intr,
  main_dummy0_intr,
  main_dummy1_intr,
  main_dummy2_intr,
  main_dummy3_intr,
  main_imemdummy0_intr,
  pmu_dmac0_hclk,
  pmu_dmac0_hrst_b,
  pmu_dmemdummy0_hclk,
  pmu_dmemdummy0_hrst_b,
  pmu_dummy0_hclk,
  pmu_dummy0_hrst_b,
  pmu_dummy1_hclk,
  pmu_dummy1_hrst_b,
  pmu_dummy2_hclk,
  pmu_dummy2_hrst_b,
  pmu_dummy3_hclk,
  pmu_dummy3_hrst_b,
  pmu_hmain0_hclk,
  pmu_hmain0_hrst_b,
  pmu_imemdummy0_hclk,
  pmu_imemdummy0_hrst_b,
  pmu_mdummy0_hclk,
  pmu_mdummy0_hrst_b,
  pmu_mdummy1_hclk,
  pmu_mdummy1_hrst_b,
  pmu_mdummy2_hclk,
  pmu_mdummy2_hrst_b,
  smc_hmain0_s2_hrdata,
  smc_hmain0_s2_hready,
  smc_hmain0_s2_hresp,
  smc_hmain0_s3_hrdata,
  smc_hmain0_s3_hready,
  smc_hmain0_s3_hresp,
  smc_hmain0_s4_hrdata,
  smc_hmain0_s4_hready,
  smc_hmain0_s4_hresp,
/////////////////////////////////
  mdummy0_hmain0_m4_haddr,    
  mdummy0_hmain0_m4_hburst,   
  mdummy0_hmain0_m4_hprot,    
  mdummy0_hmain0_m4_hsize,    
  mdummy0_hmain0_m4_htrans,   
  mdummy0_hmain0_m4_hwdata,   
  mdummy0_hmain0_m4_hwrite,   
  mdummy1_hmain0_m5_haddr,    
  mdummy1_hmain0_m5_hburst,   
  mdummy1_hmain0_m5_hprot,    
  mdummy1_hmain0_m5_hsize,    
  mdummy1_hmain0_m5_htrans,   
  mdummy1_hmain0_m5_hwdata,   
  mdummy1_hmain0_m5_hwrite,

  hmain0_imemdummy0_s1_haddr, 
  hmain0_imemdummy0_s1_hburst, 
  hmain0_imemdummy0_s1_hprot, 
  hmain0_imemdummy0_s1_hsel,  
  hmain0_imemdummy0_s1_hsize, 
  hmain0_imemdummy0_s1_htrans, 
  hmain0_imemdummy0_s1_hwdata, 
  hmain0_imemdummy0_s1_hwrite,
  hmain0_dmemdummy0_s5_haddr, 
  hmain0_dmemdummy0_s5_hburst, 
  hmain0_dmemdummy0_s5_hprot, 
  hmain0_dmemdummy0_s5_hsel,  
  hmain0_dmemdummy0_s5_hsize, 
  hmain0_dmemdummy0_s5_htrans, 
  hmain0_dmemdummy0_s5_hwdata, 
  hmain0_dmemdummy0_s5_hwrite,
  hmain0_dummy3_s11_haddr,    
  hmain0_dummy3_s11_hburst,   
  hmain0_dummy3_s11_hprot,    
  hmain0_dummy3_s11_hsel,     
  hmain0_dummy3_s11_hsize,    
  hmain0_dummy3_s11_htrans,   
  hmain0_dummy3_s11_hwdata,   
  hmain0_dummy3_s11_hwrite, 
  hmain0_dummy0_s7_haddr,     
  hmain0_dummy0_s7_hburst,    
  hmain0_dummy0_s7_hprot,     
  hmain0_dummy0_s7_hsel,      
  hmain0_dummy0_s7_hsize,     
  hmain0_dummy0_s7_htrans,    
  hmain0_dummy0_s7_hwdata,    
  hmain0_dummy0_s7_hwrite,    
  hmain0_dummy1_s8_haddr,     
  hmain0_dummy1_s8_hburst,    
  hmain0_dummy1_s8_hprot,     
  hmain0_dummy1_s8_hsel,      
  hmain0_dummy1_s8_hsize,     
  hmain0_dummy1_s8_htrans,    
  hmain0_dummy1_s8_hwdata,    
  hmain0_dummy1_s8_hwrite,    
  hmain0_dummy2_s9_haddr,     
  hmain0_dummy2_s9_hburst,    
  hmain0_dummy2_s9_hprot,     
  hmain0_dummy2_s9_hsel,      
  hmain0_dummy2_s9_hsize,     
  hmain0_dummy2_s9_htrans,    
  hmain0_dummy2_s9_hwdata,    
  hmain0_dummy2_s9_hwrite,

  hmain0_mdummy0_m4_hgrant,   
  hmain0_mdummy0_m4_hrdata,   
  hmain0_mdummy0_m4_hready,   
  hmain0_mdummy0_m4_hresp,    
  hmain0_mdummy1_m5_hgrant,   
  hmain0_mdummy1_m5_hrdata,   
  hmain0_mdummy1_m5_hready,   
  hmain0_mdummy1_m5_hresp,

  imemdummy0_hmain0_s1_hrdata,
  imemdummy0_hmain0_s1_hready, 
  imemdummy0_hmain0_s1_hresp,
  dmemdummy0_hmain0_s5_hrdata, 
  dmemdummy0_hmain0_s5_hready, 
  dmemdummy0_hmain0_s5_hresp, 
  dummy3_hmain0_s11_hrdata,   
  dummy3_hmain0_s11_hready,   
  dummy3_hmain0_s11_hresp, 
  dummy0_hmain0_s7_hrdata,    
  dummy0_hmain0_s7_hready,    
  dummy0_hmain0_s7_hresp,     
  dummy1_hmain0_s8_hrdata,    
  dummy1_hmain0_s8_hready,    
  dummy1_hmain0_s8_hresp,     
  dummy2_hmain0_s9_hrdata,    
  dummy2_hmain0_s9_hready,    
  dummy2_hmain0_s9_hresp


);
////Address Map
parameter base_s0_addr = 32'h00000000;
parameter base_s1_addr = 32'h10000000;
parameter base_s2_addr = 32'h20100000;
parameter base_s3_addr = 32'h20010000;
parameter base_s4_addr = 32'h20020000;
parameter base_s5_addr = 32'h30000000;
parameter base_s6_addr = 32'h40000000;
parameter base_s7_addr = 32'h40010000;
parameter base_s8_addr = 32'h40020000;
parameter base_s9_addr = 32'h40030000;
parameter base_s10_addr = 32'h40200000;
parameter base_s11_addr = 32'h80000000;

parameter mask_s0_addr = 32'h0003ffff;
parameter mask_s1_addr = 32'h100fffff;
parameter mask_s2_addr = 32'h2010ffff;
parameter mask_s3_addr = 32'h2001ffff;
parameter mask_s4_addr = 32'h2004ffff;
parameter mask_s5_addr = 32'h3fffffff;
parameter mask_s6_addr = 32'h40003fff;
parameter mask_s7_addr = 32'h4001ffff;
parameter mask_s8_addr = 32'h4002ffff;
parameter mask_s9_addr = 32'h4003ffff;
parameter mask_s10_addr = 32'h7fffffff;
parameter mask_s11_addr = 32'h9fffffff;
input   [31:0]  cpu_hmain0_m0_haddr;        
input   [2 :0]  cpu_hmain0_m0_hburst;       
input   [3 :0]  cpu_hmain0_m0_hprot;        
input   [2 :0]  cpu_hmain0_m0_hsize;        
input   [1 :0]  cpu_hmain0_m0_htrans;       
input   [31:0]  cpu_hmain0_m0_hwdata;       
input           cpu_hmain0_m0_hwrite;       
input   [31:0]  cpu_hmain0_m1_haddr;        
input   [2 :0]  cpu_hmain0_m1_hburst;       
input   [3 :0]  cpu_hmain0_m1_hprot;        
input   [2 :0]  cpu_hmain0_m1_hsize;        
input   [1 :0]  cpu_hmain0_m1_htrans;       
input   [31:0]  cpu_hmain0_m1_hwdata;       
input           cpu_hmain0_m1_hwrite;       
input   [31:0]  cpu_hmain0_m2_haddr;        
input   [2 :0]  cpu_hmain0_m2_hburst;       
input   [3 :0]  cpu_hmain0_m2_hprot;        
input   [2 :0]  cpu_hmain0_m2_hsize;        
input   [1 :0]  cpu_hmain0_m2_htrans;       
input   [31:0]  cpu_hmain0_m2_hwdata;       
input           cpu_hmain0_m2_hwrite;   
////////////////////////////////////////////////////
input    [31:0]  mdummy0_hmain0_m4_haddr;    
input    [2 :0]  mdummy0_hmain0_m4_hburst;   
input    [3 :0]  mdummy0_hmain0_m4_hprot;    
input    [2 :0]  mdummy0_hmain0_m4_hsize;    
input    [1 :0]  mdummy0_hmain0_m4_htrans;   
input    [31:0]  mdummy0_hmain0_m4_hwdata;   
input            mdummy0_hmain0_m4_hwrite;   
input    [31:0]  mdummy1_hmain0_m5_haddr;    
input    [2 :0]  mdummy1_hmain0_m5_hburst;   
input    [3 :0]  mdummy1_hmain0_m5_hprot;     
input    [2 :0]  mdummy1_hmain0_m5_hsize;    
input    [1 :0]  mdummy1_hmain0_m5_htrans;   
input    [31:0]  mdummy1_hmain0_m5_hwdata;   
input            mdummy1_hmain0_m5_hwrite;   

output    [31:0]  hmain0_imemdummy0_s1_haddr; 
output    [2 :0]  hmain0_imemdummy0_s1_hburst; 
output    [3 :0]  hmain0_imemdummy0_s1_hprot; 
output            hmain0_imemdummy0_s1_hsel;  
output    [2 :0]  hmain0_imemdummy0_s1_hsize; 
output    [1 :0]  hmain0_imemdummy0_s1_htrans; 
output    [31:0]  hmain0_imemdummy0_s1_hwdata; 
output            hmain0_imemdummy0_s1_hwrite;
output    [31:0]  hmain0_dmemdummy0_s5_haddr; 
output    [2 :0]  hmain0_dmemdummy0_s5_hburst; 
output    [3 :0]  hmain0_dmemdummy0_s5_hprot; 
output            hmain0_dmemdummy0_s5_hsel;  
output    [2 :0]  hmain0_dmemdummy0_s5_hsize; 
output    [1 :0]  hmain0_dmemdummy0_s5_htrans; 
output    [31:0]  hmain0_dmemdummy0_s5_hwdata; 
output            hmain0_dmemdummy0_s5_hwrite; 
output    [31:0]  hmain0_dummy3_s11_haddr;    
output    [2 :0]  hmain0_dummy3_s11_hburst;   
output    [3 :0]  hmain0_dummy3_s11_hprot;    
output            hmain0_dummy3_s11_hsel;     
output    [2 :0]  hmain0_dummy3_s11_hsize;    
output    [1 :0]  hmain0_dummy3_s11_htrans;   
output    [31:0]  hmain0_dummy3_s11_hwdata;   
output            hmain0_dummy3_s11_hwrite; 
output    [31:0]  hmain0_dummy0_s7_haddr;     
output    [2 :0]  hmain0_dummy0_s7_hburst;    
output    [3 :0]  hmain0_dummy0_s7_hprot;     
output            hmain0_dummy0_s7_hsel;      
output    [2 :0]  hmain0_dummy0_s7_hsize;     
output    [1 :0]  hmain0_dummy0_s7_htrans;    
output    [31:0]  hmain0_dummy0_s7_hwdata;    
output            hmain0_dummy0_s7_hwrite;    
output    [31:0]  hmain0_dummy1_s8_haddr;     
output    [2 :0]  hmain0_dummy1_s8_hburst;    
output    [3 :0]  hmain0_dummy1_s8_hprot;     
output            hmain0_dummy1_s8_hsel;      
output    [2 :0]  hmain0_dummy1_s8_hsize;     
output    [1 :0]  hmain0_dummy1_s8_htrans;    
output    [31:0]  hmain0_dummy1_s8_hwdata;    
output            hmain0_dummy1_s8_hwrite;    
output    [31:0]  hmain0_dummy2_s9_haddr;     
output    [2 :0]  hmain0_dummy2_s9_hburst;    
output    [3 :0]  hmain0_dummy2_s9_hprot;     
output            hmain0_dummy2_s9_hsel;      
output    [2 :0]  hmain0_dummy2_s9_hsize;     
output    [1 :0]  hmain0_dummy2_s9_htrans;    
output    [31:0]  hmain0_dummy2_s9_hwdata;    
output            hmain0_dummy2_s9_hwrite;
    
output            hmain0_mdummy0_m4_hgrant;   
output    [31:0]  hmain0_mdummy0_m4_hrdata;   
output            hmain0_mdummy0_m4_hready;   
output    [1 :0]  hmain0_mdummy0_m4_hresp;    
output            hmain0_mdummy1_m5_hgrant;   
output    [31:0]  hmain0_mdummy1_m5_hrdata;   
output            hmain0_mdummy1_m5_hready;   
output    [1 :0]  hmain0_mdummy1_m5_hresp;   
 
input    [31:0]  imemdummy0_hmain0_s1_hrdata; 
input            imemdummy0_hmain0_s1_hready; 
input    [1 :0]  imemdummy0_hmain0_s1_hresp; 
input    [31:0]  dmemdummy0_hmain0_s5_hrdata; 
input            dmemdummy0_hmain0_s5_hready; 
input    [1 :0]  dmemdummy0_hmain0_s5_hresp; 
input    [31:0]  dummy3_hmain0_s11_hrdata;   
input            dummy3_hmain0_s11_hready;   
input    [1 :0]  dummy3_hmain0_s11_hresp; 
input    [31:0]  dummy0_hmain0_s7_hrdata;    
input            dummy0_hmain0_s7_hready;    
input    [1 :0]  dummy0_hmain0_s7_hresp;     
input    [31:0]  dummy1_hmain0_s8_hrdata;    
input            dummy1_hmain0_s8_hready;    
input    [1 :0]  dummy1_hmain0_s8_hresp;     
input    [31:0]  dummy2_hmain0_s9_hrdata;    
input            dummy2_hmain0_s9_hready;    
input    [1 :0]  dummy2_hmain0_s9_hresp;     
/////////////////////////////////////////////
input   [31:0]  ismc_hmain0_s0_hrdata;      
input           ismc_hmain0_s0_hready;      
input   [1 :0]  ismc_hmain0_s0_hresp;       
input   [31:0]  lsbus_hmain0_s10_hrdata;    
input           lsbus_hmain0_s10_hready;    
input   [1 :0]  lsbus_hmain0_s10_hresp;     
input           pmu_dmac0_hclk;             
input           pmu_dmac0_hrst_b;           
input           pmu_dmemdummy0_hclk;        
input           pmu_dmemdummy0_hrst_b;      
input           pmu_dummy0_hclk;            
input           pmu_dummy0_hrst_b;          
input           pmu_dummy1_hclk;            
input           pmu_dummy1_hrst_b;          
input           pmu_dummy2_hclk;            
input           pmu_dummy2_hrst_b;          
input           pmu_dummy3_hclk;            
input           pmu_dummy3_hrst_b;          
input           pmu_hmain0_hclk;            
input           pmu_hmain0_hrst_b;          
input           pmu_imemdummy0_hclk;        
input           pmu_imemdummy0_hrst_b;      
input           pmu_mdummy0_hclk;           
input           pmu_mdummy0_hrst_b;         
input           pmu_mdummy1_hclk;           
input           pmu_mdummy1_hrst_b;         
input           pmu_mdummy2_hclk;           
input           pmu_mdummy2_hrst_b;         
input   [31:0]  smc_hmain0_s2_hrdata;       
input           smc_hmain0_s2_hready;       
input   [1 :0]  smc_hmain0_s2_hresp;        
input   [31:0]  smc_hmain0_s3_hrdata;       
input           smc_hmain0_s3_hready;       
input   [1 :0]  smc_hmain0_s3_hresp;        
input   [31:0]  smc_hmain0_s4_hrdata;       
input           smc_hmain0_s4_hready;       
input   [1 :0]  smc_hmain0_s4_hresp;        
output          dmac0_wic_intr;             
output  [31:0]  hmain0_cpu_m0_hrdata;       
output          hmain0_cpu_m0_hready;       
output  [1 :0]  hmain0_cpu_m0_hresp;        
output  [31:0]  hmain0_cpu_m1_hrdata;       
output          hmain0_cpu_m1_hready;       
output  [1 :0]  hmain0_cpu_m1_hresp;        
output  [31:0]  hmain0_cpu_m2_hrdata;       
output          hmain0_cpu_m2_hready;       
output  [1 :0]  hmain0_cpu_m2_hresp;        
output  [31:0]  hmain0_ismc_s0_haddr;       
output  [3 :0]  hmain0_ismc_s0_hprot;       
output          hmain0_ismc_s0_hsel;        
output  [2 :0]  hmain0_ismc_s0_hsize;       
output  [1 :0]  hmain0_ismc_s0_htrans;      
output  [31:0]  hmain0_ismc_s0_hwdata;      
output          hmain0_ismc_s0_hwrite;      
output  [31:0]  hmain0_lsbus_s10_haddr;     
output  [2 :0]  hmain0_lsbus_s10_hburst;    
output  [3 :0]  hmain0_lsbus_s10_hprot;     
output          hmain0_lsbus_s10_hsel;      
output  [2 :0]  hmain0_lsbus_s10_hsize;     
output  [1 :0]  hmain0_lsbus_s10_htrans;    
output  [31:0]  hmain0_lsbus_s10_hwdata;    
output          hmain0_lsbus_s10_hwrite;    
output  [31:0]  hmain0_smc_s2_haddr;        
output  [3 :0]  hmain0_smc_s2_hprot;        
output          hmain0_smc_s2_hsel;         
output  [2 :0]  hmain0_smc_s2_hsize;        
output  [1 :0]  hmain0_smc_s2_htrans;       
output  [31:0]  hmain0_smc_s2_hwdata;       
output          hmain0_smc_s2_hwrite;       
output  [31:0]  hmain0_smc_s3_haddr;        
output  [3 :0]  hmain0_smc_s3_hprot;        
output          hmain0_smc_s3_hsel;         
output  [2 :0]  hmain0_smc_s3_hsize;        
output  [1 :0]  hmain0_smc_s3_htrans;       
output  [31:0]  hmain0_smc_s3_hwdata;       
output          hmain0_smc_s3_hwrite;       
output  [31:0]  hmain0_smc_s4_haddr;        
output  [3 :0]  hmain0_smc_s4_hprot;        
output          hmain0_smc_s4_hsel;         
output  [2 :0]  hmain0_smc_s4_hsize;        
output  [1 :0]  hmain0_smc_s4_htrans;       
output  [31:0]  hmain0_smc_s4_hwdata;       
output          hmain0_smc_s4_hwrite;       
output          main_dmemdummy0_intr;       
output          main_dummy0_intr;           
output          main_dummy1_intr;           
output          main_dummy2_intr;           
output          main_dummy3_intr;           
output          main_imemdummy0_intr;       
wire            ch0_etb_evtdone;            
wire            ch0_etb_htfrdone;           
wire            ch0_etb_tfrdone;            
wire            ch10_etb_evtdone;           
wire            ch10_etb_htfrdone;          
wire            ch10_etb_tfrdone;           
wire            ch11_etb_evtdone;           
wire            ch11_etb_htfrdone;          
wire            ch11_etb_tfrdone;           
wire            ch12_etb_evtdone;           
wire            ch12_etb_htfrdone;          
wire            ch12_etb_tfrdone;           
wire            ch13_etb_evtdone;           
wire            ch13_etb_htfrdone;          
wire            ch13_etb_tfrdone;           
wire            ch14_etb_evtdone;           
wire            ch14_etb_htfrdone;          
wire            ch14_etb_tfrdone;           
wire            ch15_etb_evtdone;           
wire            ch15_etb_htfrdone;          
wire            ch15_etb_tfrdone;           
wire            ch1_etb_evtdone;            
wire            ch1_etb_htfrdone;           
wire            ch1_etb_tfrdone;            
wire            ch2_etb_evtdone;            
wire            ch2_etb_htfrdone;           
wire            ch2_etb_tfrdone;            
wire            ch3_etb_evtdone;            
wire            ch3_etb_htfrdone;           
wire            ch3_etb_tfrdone;            
wire            ch4_etb_evtdone;            
wire            ch4_etb_htfrdone;           
wire            ch4_etb_tfrdone;            
wire            ch5_etb_evtdone;            
wire            ch5_etb_htfrdone;           
wire            ch5_etb_tfrdone;            
wire            ch6_etb_evtdone;            
wire            ch6_etb_htfrdone;           
wire            ch6_etb_tfrdone;            
wire            ch7_etb_evtdone;            
wire            ch7_etb_htfrdone;           
wire            ch7_etb_tfrdone;            
wire            ch8_etb_evtdone;            
wire            ch8_etb_htfrdone;           
wire            ch8_etb_tfrdone;            
wire            ch9_etb_evtdone;            
wire            ch9_etb_htfrdone;           
wire            ch9_etb_tfrdone;            
wire    [31:0]  cpu_hmain0_m0_haddr;        
wire    [2 :0]  cpu_hmain0_m0_hburst;       
wire    [3 :0]  cpu_hmain0_m0_hprot;        
wire    [3 :0]  cpu_hmain0_m0_hprot_tmp;    
wire    [2 :0]  cpu_hmain0_m0_hsize;        
wire    [1 :0]  cpu_hmain0_m0_htrans;       
wire    [31:0]  cpu_hmain0_m0_hwdata;       
wire            cpu_hmain0_m0_hwrite;       
wire    [31:0]  cpu_hmain0_m1_haddr;        
wire    [2 :0]  cpu_hmain0_m1_hburst;       
wire    [3 :0]  cpu_hmain0_m1_hprot;        
wire    [3 :0]  cpu_hmain0_m1_hprot_tmp;    
wire    [2 :0]  cpu_hmain0_m1_hsize;        
wire    [1 :0]  cpu_hmain0_m1_htrans;       
wire    [31:0]  cpu_hmain0_m1_hwdata;       
wire            cpu_hmain0_m1_hwrite;       
wire    [31:0]  cpu_hmain0_m2_haddr;        
wire    [2 :0]  cpu_hmain0_m2_hburst;       
wire    [3 :0]  cpu_hmain0_m2_hprot;        
wire    [3 :0]  cpu_hmain0_m2_hprot_tmp;    
wire    [2 :0]  cpu_hmain0_m2_hsize;        
wire    [1 :0]  cpu_hmain0_m2_htrans;       
wire    [31:0]  cpu_hmain0_m2_hwdata;       
wire            cpu_hmain0_m2_hwrite;       
wire    [31:0]  dmac0_hmain0_m3_haddr;      
wire    [2 :0]  dmac0_hmain0_m3_hburst;     
wire            dmac0_hmain0_m3_hbusreq;    
wire            dmac0_hmain0_m3_hlock;      
wire    [3 :0]  dmac0_hmain0_m3_hprot;      
wire    [3 :0]  dmac0_hmain0_m3_hprot_tmp;  
wire    [2 :0]  dmac0_hmain0_m3_hsize;      
wire    [1 :0]  dmac0_hmain0_m3_htrans;     
wire    [31:0]  dmac0_hmain0_m3_hwdata;     
wire            dmac0_hmain0_m3_hwrite;     
wire    [31:0]  dmac0_hmain0_s6_hrdata;     
wire            dmac0_hmain0_s6_hready;     
wire    [1 :0]  dmac0_hmain0_s6_hresp;      
wire            dmac0_wic_intr;             
wire            dmacch0_etb_prot;           
wire            dmacch10_etb_prot;          
wire            dmacch11_etb_prot;          
wire            dmacch12_etb_prot;          
wire            dmacch13_etb_prot;          
wire            dmacch14_etb_prot;          
wire            dmacch15_etb_prot;          
wire            dmacch1_etb_prot;           
wire            dmacch2_etb_prot;           
wire            dmacch3_etb_prot;           
wire            dmacch4_etb_prot;           
wire            dmacch5_etb_prot;           
wire            dmacch6_etb_prot;           
wire            dmacch7_etb_prot;           
wire            dmacch8_etb_prot;           
wire            dmacch9_etb_prot;           
wire    [31:0]  dmemdummy0_hmain0_s5_hrdata; 
wire            dmemdummy0_hmain0_s5_hready; 
wire    [1 :0]  dmemdummy0_hmain0_s5_hresp; 
wire    [31:0]  dummy0_hmain0_s7_hrdata;    
wire            dummy0_hmain0_s7_hready;    
wire    [1 :0]  dummy0_hmain0_s7_hresp;     
wire    [31:0]  dummy1_hmain0_s8_hrdata;    
wire            dummy1_hmain0_s8_hready;    
wire    [1 :0]  dummy1_hmain0_s8_hresp;     
wire    [31:0]  dummy2_hmain0_s9_hrdata;    
wire            dummy2_hmain0_s9_hready;    
wire    [1 :0]  dummy2_hmain0_s9_hresp;     
wire    [31:0]  dummy3_hmain0_s11_hrdata;   
wire            dummy3_hmain0_s11_hready;   
wire    [1 :0]  dummy3_hmain0_s11_hresp;    
wire            etb_dmacch0_trg;            
wire            etb_dmacch10_trg;           
wire            etb_dmacch11_trg;           
wire            etb_dmacch12_trg;           
wire            etb_dmacch13_trg;           
wire            etb_dmacch14_trg;           
wire            etb_dmacch15_trg;           
wire            etb_dmacch1_trg;            
wire            etb_dmacch2_trg;            
wire            etb_dmacch3_trg;            
wire            etb_dmacch4_trg;            
wire            etb_dmacch5_trg;            
wire            etb_dmacch6_trg;            
wire            etb_dmacch7_trg;            
wire            etb_dmacch8_trg;            
wire            etb_dmacch9_trg;            
wire            hmain0_cpu_m0_hgrant;       
wire    [31:0]  hmain0_cpu_m0_hrdata;       
wire            hmain0_cpu_m0_hready;       
wire    [1 :0]  hmain0_cpu_m0_hresp;        
wire            hmain0_cpu_m1_hgrant;       
wire    [31:0]  hmain0_cpu_m1_hrdata;       
wire            hmain0_cpu_m1_hready;       
wire    [1 :0]  hmain0_cpu_m1_hresp;        
wire            hmain0_cpu_m2_hgrant;       
wire    [31:0]  hmain0_cpu_m2_hrdata;       
wire            hmain0_cpu_m2_hready;       
wire    [1 :0]  hmain0_cpu_m2_hresp;        
wire            hmain0_dmac0_m3_hgrant;     
wire    [31:0]  hmain0_dmac0_m3_hrdata;     
wire            hmain0_dmac0_m3_hready;     
wire    [1 :0]  hmain0_dmac0_m3_hresp;      
wire    [31:0]  hmain0_dmac0_s6_haddr;      
wire    [2 :0]  hmain0_dmac0_s6_hburst;     
wire    [3 :0]  hmain0_dmac0_s6_hprot;      
wire            hmain0_dmac0_s6_hsel;       
wire    [2 :0]  hmain0_dmac0_s6_hsize;      
wire    [1 :0]  hmain0_dmac0_s6_htrans;     
wire    [31:0]  hmain0_dmac0_s6_hwdata;     
wire            hmain0_dmac0_s6_hwrite;     
wire    [31:0]  hmain0_dmemdummy0_s5_haddr; 
wire    [2 :0]  hmain0_dmemdummy0_s5_hburst; 
wire    [3 :0]  hmain0_dmemdummy0_s5_hprot; 
wire            hmain0_dmemdummy0_s5_hsel;  
wire    [2 :0]  hmain0_dmemdummy0_s5_hsize; 
wire    [1 :0]  hmain0_dmemdummy0_s5_htrans; 
wire    [31:0]  hmain0_dmemdummy0_s5_hwdata; 
wire            hmain0_dmemdummy0_s5_hwrite; 
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
wire    [31:0]  hmain0_dummy3_s11_haddr;    
wire    [2 :0]  hmain0_dummy3_s11_hburst;   
wire    [3 :0]  hmain0_dummy3_s11_hprot;    
wire            hmain0_dummy3_s11_hsel;     
wire    [2 :0]  hmain0_dummy3_s11_hsize;    
wire    [1 :0]  hmain0_dummy3_s11_htrans;   
wire    [31:0]  hmain0_dummy3_s11_hwdata;   
wire            hmain0_dummy3_s11_hwrite;   
wire    [31:0]  hmain0_imemdummy0_s1_haddr; 
wire    [2 :0]  hmain0_imemdummy0_s1_hburst; 
wire    [3 :0]  hmain0_imemdummy0_s1_hprot; 
wire            hmain0_imemdummy0_s1_hsel;  
wire    [2 :0]  hmain0_imemdummy0_s1_hsize; 
wire    [1 :0]  hmain0_imemdummy0_s1_htrans; 
wire    [31:0]  hmain0_imemdummy0_s1_hwdata; 
wire            hmain0_imemdummy0_s1_hwrite; 
wire    [31:0]  hmain0_ismc_s0_haddr;       
wire    [2 :0]  hmain0_ismc_s0_hburst;      
wire    [3 :0]  hmain0_ismc_s0_hprot;       
wire            hmain0_ismc_s0_hsel;        
wire    [2 :0]  hmain0_ismc_s0_hsize;       
wire    [1 :0]  hmain0_ismc_s0_htrans;      
wire    [31:0]  hmain0_ismc_s0_hwdata;      
wire            hmain0_ismc_s0_hwrite;      
wire    [31:0]  hmain0_lsbus_s10_haddr;     
wire    [2 :0]  hmain0_lsbus_s10_hburst;    
wire    [3 :0]  hmain0_lsbus_s10_hprot;     
wire            hmain0_lsbus_s10_hsel;      
wire    [2 :0]  hmain0_lsbus_s10_hsize;     
wire    [1 :0]  hmain0_lsbus_s10_htrans;    
wire    [31:0]  hmain0_lsbus_s10_hwdata;    
wire            hmain0_lsbus_s10_hwrite;    
wire            hmain0_mdummy0_m4_hgrant;   
wire    [31:0]  hmain0_mdummy0_m4_hrdata;   
wire            hmain0_mdummy0_m4_hready;   
wire    [1 :0]  hmain0_mdummy0_m4_hresp;    
wire            hmain0_mdummy1_m5_hgrant;   
wire    [31:0]  hmain0_mdummy1_m5_hrdata;   
wire            hmain0_mdummy1_m5_hready;   
wire    [1 :0]  hmain0_mdummy1_m5_hresp;    
wire            hmain0_mdummy2_m6_hgrant;   
wire    [31:0]  hmain0_mdummy2_m6_hrdata;   
wire            hmain0_mdummy2_m6_hready;   
wire    [1 :0]  hmain0_mdummy2_m6_hresp;    
wire    [31:0]  hmain0_smc_s2_haddr;        
wire    [2 :0]  hmain0_smc_s2_hburst;       
wire    [3 :0]  hmain0_smc_s2_hprot;        
wire            hmain0_smc_s2_hsel;         
wire    [2 :0]  hmain0_smc_s2_hsize;        
wire    [1 :0]  hmain0_smc_s2_htrans;       
wire    [31:0]  hmain0_smc_s2_hwdata;       
wire            hmain0_smc_s2_hwrite;       
wire    [31:0]  hmain0_smc_s3_haddr;        
wire    [2 :0]  hmain0_smc_s3_hburst;       
wire    [3 :0]  hmain0_smc_s3_hprot;        
wire            hmain0_smc_s3_hsel;         
wire    [2 :0]  hmain0_smc_s3_hsize;        
wire    [1 :0]  hmain0_smc_s3_htrans;       
wire    [31:0]  hmain0_smc_s3_hwdata;       
wire            hmain0_smc_s3_hwrite;       
wire    [31:0]  hmain0_smc_s4_haddr;        
wire    [2 :0]  hmain0_smc_s4_hburst;       
wire    [3 :0]  hmain0_smc_s4_hprot;        
wire            hmain0_smc_s4_hsel;         
wire    [2 :0]  hmain0_smc_s4_hsize;        
wire    [1 :0]  hmain0_smc_s4_htrans;       
wire    [31:0]  hmain0_smc_s4_hwdata;       
wire            hmain0_smc_s4_hwrite;       
wire    [31:0]  imemdummy0_hmain0_s1_hrdata; 
wire            imemdummy0_hmain0_s1_hready; 
wire    [1 :0]  imemdummy0_hmain0_s1_hresp; 
wire    [31:0]  ismc_hmain0_s0_hrdata;      
wire            ismc_hmain0_s0_hready;      
wire    [1 :0]  ismc_hmain0_s0_hresp;       
wire    [31:0]  lsbus_hmain0_s10_hrdata;    
wire            lsbus_hmain0_s10_hready;    
wire    [1 :0]  lsbus_hmain0_s10_hresp;     
wire            main_dmemdummy0_intr;       
wire            main_dummy0_intr;           
wire            main_dummy1_intr;           
wire            main_dummy2_intr;           
wire            main_dummy3_intr;           
wire            main_imemdummy0_intr;       
wire    [31:0]  mdummy0_hmain0_m4_haddr;    
wire    [2 :0]  mdummy0_hmain0_m4_hburst;   
wire    [3 :0]  mdummy0_hmain0_m4_hprot;    
wire    [3 :0]  mdummy0_hmain0_m4_hprot_tmp; 
wire    [2 :0]  mdummy0_hmain0_m4_hsize;    
wire    [1 :0]  mdummy0_hmain0_m4_htrans;   
wire    [31:0]  mdummy0_hmain0_m4_hwdata;   
wire            mdummy0_hmain0_m4_hwrite;   
wire    [31:0]  mdummy1_hmain0_m5_haddr;    
wire    [2 :0]  mdummy1_hmain0_m5_hburst;   
wire    [3 :0]  mdummy1_hmain0_m5_hprot;    
wire    [3 :0]  mdummy1_hmain0_m5_hprot_tmp; 
wire    [2 :0]  mdummy1_hmain0_m5_hsize;    
wire    [1 :0]  mdummy1_hmain0_m5_htrans;   
wire    [31:0]  mdummy1_hmain0_m5_hwdata;   
wire            mdummy1_hmain0_m5_hwrite;   
wire    [31:0]  mdummy2_hmain0_m6_haddr;    
wire    [2 :0]  mdummy2_hmain0_m6_hburst;   
wire    [3 :0]  mdummy2_hmain0_m6_hprot;    
wire    [3 :0]  mdummy2_hmain0_m6_hprot_tmp; 
wire    [2 :0]  mdummy2_hmain0_m6_hsize;    
wire    [1 :0]  mdummy2_hmain0_m6_htrans;   
wire    [31:0]  mdummy2_hmain0_m6_hwdata;   
wire            mdummy2_hmain0_m6_hwrite;   
wire            pmu_dmac0_hclk;             
wire            pmu_dmac0_hrst_b;           
wire            pmu_dmemdummy0_hclk;        
wire            pmu_dmemdummy0_hrst_b;      
wire            pmu_dummy0_hclk;            
wire            pmu_dummy0_hrst_b;          
wire            pmu_dummy1_hclk;            
wire            pmu_dummy1_hrst_b;          
wire            pmu_dummy2_hclk;            
wire            pmu_dummy2_hrst_b;          
wire            pmu_dummy3_hclk;            
wire            pmu_dummy3_hrst_b;          
wire            pmu_hmain0_hclk;            
wire            pmu_hmain0_hrst_b;          
wire            pmu_imemdummy0_hclk;        
wire            pmu_imemdummy0_hrst_b;      
wire            pmu_mdummy0_hclk;           
wire            pmu_mdummy0_hrst_b;         
wire            pmu_mdummy1_hclk;           
wire            pmu_mdummy1_hrst_b;         
wire            pmu_mdummy2_hclk;           
wire            pmu_mdummy2_hrst_b;         
wire    [31:0]  smc_hmain0_s2_hrdata;       
wire            smc_hmain0_s2_hready;       
wire    [1 :0]  smc_hmain0_s2_hresp;        
wire    [31:0]  smc_hmain0_s3_hrdata;       
wire            smc_hmain0_s3_hready;       
wire    [1 :0]  smc_hmain0_s3_hresp;        
wire    [31:0]  smc_hmain0_s4_hrdata;       
wire            smc_hmain0_s4_hready;       
wire    [1 :0]  smc_hmain0_s4_hresp;        
assign cpu_hmain0_m0_hprot_tmp[3:0] = cpu_hmain0_m0_hprot[3:0];
assign cpu_hmain0_m1_hprot_tmp[3:0] = cpu_hmain0_m1_hprot[3:0];
assign cpu_hmain0_m2_hprot_tmp[3:0] = cpu_hmain0_m2_hprot[3:0];
assign dmac0_hmain0_m3_hprot_tmp[3:0] = dmac0_hmain0_m3_hprot[3:0];
assign mdummy0_hmain0_m4_hprot_tmp[3:0] = mdummy0_hmain0_m4_hprot[3:0];
assign mdummy1_hmain0_m5_hprot_tmp[3:0] = mdummy1_hmain0_m5_hprot[3:0];
assign mdummy2_hmain0_m6_hprot_tmp[3:0] = mdummy2_hmain0_m6_hprot[3:0];

parameter MASTERS = 7;
parameter SLAVES = 12;
parameter MASTERS_BIT = 3;

//master  bus-lite
wire [31:0] M_HADDR     [0:MASTERS-1];
wire [ 2:0] M_HBURST    [0:MASTERS-1];
wire [ 3:0] M_HPROT     [0:MASTERS-1];
wire [ 2:0] M_HSIZE     [0:MASTERS-1];
wire [ 1:0] M_HTRANS    [0:MASTERS-1];
wire [31:0] M_HWDATA    [0:MASTERS-1];
wire        M_HWRITE    [0:MASTERS-1];
wire        M_HREADY    [0:MASTERS-1];
wire        M_HSEL      [0:MASTERS-1];
wire        M_HMASTLOCK [0:MASTERS-1];
wire [31:0] M_HRDATA    [0:MASTERS-1];
wire        M_HRESP     [0:MASTERS-1];
wire        M_HREADYOUT [0:MASTERS-1];
wire [MASTERS_BIT-1:0] M_PRIORITY[0:MASTERS-1];

//slave bus-lite
wire        S_HSEL       [0:SLAVES-1];
wire [ 1:0] S_HTRANS     [0:SLAVES-1];
wire        S_HWRITE     [0:SLAVES-1];
wire        S_HMASTLOCK  [0:SLAVES-1];
wire [ 2:0] S_HSIZE      [0:SLAVES-1];
wire [ 2:0] S_HBURST     [0:SLAVES-1];
wire [ 3:0] S_HPROT      [0:SLAVES-1];
wire [31:0] S_HADDR      [0:SLAVES-1];
wire [31:0] S_HWDATA     [0:SLAVES-1];
wire        S_HREADY     [0:SLAVES-1];
wire        S_HREADYOUT  [0:SLAVES-1];
wire [31:0] S_HRDATA     [0:SLAVES-1];
wire        S_HRESP      [0:SLAVES-1];


wire [31:0] S_HADDR_BASE [0:SLAVES-1];
wire [31:0] S_HADDR_MASK [0:SLAVES-1];




assign M_PRIORITY[0]=0; //: Level0 Single Group Highest
assign M_PRIORITY[1]=0; //: Level1 Round-Robin Group among [1][2][3]
assign M_PRIORITY[2]=0; //: Level1 Round-Robin Group among [1][2][3]
assign M_PRIORITY[3]=0; //: Level1 Round-Robin Group among [1][2][3]
assign M_PRIORITY[4]=0; //: Level2 Round-Robin Group among [4][5]
assign M_PRIORITY[5]=1; //: Level2 Round-Robin Group among [4][5]
assign M_PRIORITY[6]=1; //: Level3 Single Group
  
// width = 32bit
assign M_HADDR[0] = cpu_hmain0_m0_haddr;
assign M_HADDR[1] = cpu_hmain0_m1_haddr;
assign M_HADDR[2] = cpu_hmain0_m2_haddr;
assign M_HADDR[3] = dmac0_hmain0_m3_haddr;
assign M_HADDR[4] = mdummy0_hmain0_m4_haddr;
assign M_HADDR[5] = mdummy1_hmain0_m5_haddr;
assign M_HADDR[6] = mdummy2_hmain0_m6_haddr;
// width = 3bit
assign M_HBURST[0] = cpu_hmain0_m0_hburst;
assign M_HBURST[1] = cpu_hmain0_m1_hburst;
assign M_HBURST[2] = cpu_hmain0_m2_hburst;
assign M_HBURST[3] = dmac0_hmain0_m3_hburst;
assign M_HBURST[4] = mdummy0_hmain0_m4_hburst;
assign M_HBURST[5] = mdummy1_hmain0_m5_hburst;
assign M_HBURST[6] = mdummy2_hmain0_m6_hburst;
// width = 4bit
assign M_HPROT[0] = cpu_hmain0_m0_hprot;
assign M_HPROT[1] = cpu_hmain0_m1_hprot;
assign M_HPROT[2] = cpu_hmain0_m2_hprot;
assign M_HPROT[3] = dmac0_hmain0_m3_hprot;
assign M_HPROT[4] = mdummy0_hmain0_m4_hprot;
assign M_HPROT[5] = mdummy1_hmain0_m5_hprot;
assign M_HPROT[6] = mdummy2_hmain0_m6_hprot;
// width = 3bit
assign M_HSIZE[0] = cpu_hmain0_m0_hsize;
assign M_HSIZE[1] = cpu_hmain0_m1_hsize;
assign M_HSIZE[2] = cpu_hmain0_m2_hsize;
assign M_HSIZE[3] = dmac0_hmain0_m3_hsize;
assign M_HSIZE[4] = mdummy0_hmain0_m4_hsize;
assign M_HSIZE[5] = mdummy1_hmain0_m5_hsize;
assign M_HSIZE[6] = mdummy2_hmain0_m6_hsize;
// width = 2bit
assign M_HTRANS[0] = cpu_hmain0_m0_htrans;
assign M_HTRANS[1] = cpu_hmain0_m1_htrans;
assign M_HTRANS[2] = cpu_hmain0_m2_htrans;
assign M_HTRANS[3] = dmac0_hmain0_m3_htrans;
assign M_HTRANS[4] = mdummy0_hmain0_m4_htrans;
assign M_HTRANS[5] = mdummy1_hmain0_m5_htrans;
assign M_HTRANS[6] = mdummy2_hmain0_m6_htrans;
// width = 32bit
assign M_HWDATA[0] = cpu_hmain0_m0_hwdata;
assign M_HWDATA[1] = cpu_hmain0_m1_hwdata;
assign M_HWDATA[2] = cpu_hmain0_m2_hwdata;
assign M_HWDATA[3] = dmac0_hmain0_m3_hwdata;
assign M_HWDATA[4] = mdummy0_hmain0_m4_hwdata;
assign M_HWDATA[5] = mdummy1_hmain0_m5_hwdata;
assign M_HWDATA[6] = mdummy2_hmain0_m6_hwdata;
// width = 1bit
assign M_HWRITE[0] = cpu_hmain0_m0_hwrite;
assign M_HWRITE[1] = cpu_hmain0_m1_hwrite;
assign M_HWRITE[2] = cpu_hmain0_m2_hwrite;
assign M_HWRITE[3] = dmac0_hmain0_m3_hwrite;
assign M_HWRITE[4] = mdummy0_hmain0_m4_hwrite;
assign M_HWRITE[5] = mdummy1_hmain0_m5_hwrite;
assign M_HWRITE[6] = mdummy2_hmain0_m6_hwrite;

genvar i;
generate
    for(i=0;i<MASTERS;i=i+1)begin
    // width = 1bit
        assign M_HREADY[i] = 1'b1;
    // width = 1bit
        assign M_HMASTLOCK[i] = 1'b0;
    end 
endgenerate
// width = 1bit
assign M_HSEL[0] = cpu_hmain0_m0_htrans[1];
assign M_HSEL[1] = cpu_hmain0_m1_htrans[1];
assign M_HSEL[2] = cpu_hmain0_m2_htrans[1];
assign M_HSEL[3] = dmac0_hmain0_m3_htrans[1];
assign M_HSEL[4] = mdummy0_hmain0_m4_htrans[1];
assign M_HSEL[5] = mdummy1_hmain0_m5_htrans[1];
assign M_HSEL[6] = mdummy2_hmain0_m6_htrans[1];
// width = 32bit
assign hmain0_cpu_m0_hrdata = M_HRDATA[0];
assign hmain0_cpu_m1_hrdata = M_HRDATA[1];
assign hmain0_cpu_m2_hrdata = M_HRDATA[2];
assign hmain0_dmac0_m3_hrdata = M_HRDATA[3];
assign hmain0_mdummy0_m4_hrdata = M_HRDATA[4];
assign hmain0_mdummy1_m5_hrdata = M_HRDATA[5];
assign hmain0_mdummy2_m6_hrdata = M_HRDATA[6];
// width = 1bit
assign hmain0_cpu_m0_hresp = {M_HRESP[0],M_HRESP[0]};
assign hmain0_cpu_m1_hresp = {M_HRESP[1],M_HRESP[1]};
assign hmain0_cpu_m2_hresp = {M_HRESP[2],M_HRESP[2]};
assign hmain0_dmac0_m3_hresp = {M_HRESP[3],M_HRESP[3]};
assign hmain0_mdummy0_m4_hresp = {M_HRESP[4],M_HRESP[4]};
assign hmain0_mdummy1_m5_hresp = {M_HRESP[5],M_HRESP[5]};
assign hmain0_mdummy2_m6_hresp = {M_HRESP[6],M_HRESP[6]};
// width = 1bit
assign hmain0_cpu_m0_hready = M_HREADYOUT[0];
assign hmain0_cpu_m1_hready = M_HREADYOUT[1];
assign hmain0_cpu_m2_hready = M_HREADYOUT[2];
assign hmain0_dmac0_m3_hready = M_HREADYOUT[3];
assign hmain0_mdummy0_m4_hready = M_HREADYOUT[4];
assign hmain0_mdummy1_m5_hready = M_HREADYOUT[5];
assign hmain0_mdummy2_m6_hready = M_HREADYOUT[6];

AHB_MATRIX #(
        .MASTERS(MASTERS),
        .SLAVES(SLAVES),
        .MASTERS_BIT(MASTERS_BIT)
     )
x_ahb_matrix_7_12_main(
    // Global Signals
    .HCLK(pmu_hmain0_hclk),
    .HRESETn(pmu_hmain0_hrst_b),
    // Master Ports
    .M_HADDR         (M_HADDR),
    .M_HBURST        (M_HBURST),
    .M_HPROT         (M_HPROT),
    .M_HSIZE         (M_HSIZE),
    .M_HTRANS        (M_HTRANS),
    .M_HWDATA        (M_HWDATA),
    .M_HWRITE        (M_HWRITE),
    .M_HRDATA        (M_HRDATA),
    .M_HREADY        (M_HREADY),
    .M_HRESP         (M_HRESP),

    .M_HSEL          (M_HSEL),
    .M_HMASTLOCK     (M_HMASTLOCK),
    .M_HREADYOUT     (M_HREADYOUT),
    
    .M_PRIORITY      (M_PRIORITY),
        // (ex) MASTERS=8
        //      M_PRIORITY[0]=0 : Level0 Single Group Highest
        //      M_PRIORITY[1]=1 : Level1 Round-Robin Group among [1][2][3]
        //      M_PRIORITY[2]=1 : Level1 Round-Robin Group among [1][2][3]
        //      M_PRIORITY[3]=1 : Level1 Round-Robin Group among [1][2][3]
        //      M_PRIORITY[4]=2 : Level2 Round-Robin Group among [4][5]
        //      M_PRIORITY[5]=2 : Level2 Round-Robin Group among [4][5]
        //      M_PRIORITY[6]=3 : Level3 Single Group
        //      M_PRIORITY[7]=4 : Level4 Single Group Lowest    
    // Slave Ports
    .S_HSEL       (S_HSEL),
    .S_HTRANS     (S_HTRANS),
    .S_HWRITE     (S_HWRITE),
    .S_HMASTLOCK  (),
    .S_HSIZE      (S_HSIZE),
    .S_HBURST     (S_HBURST),
    .S_HPROT      (S_HPROT),
    .S_HADDR      (S_HADDR),
    .S_HWDATA     (S_HWDATA),
    .S_HREADY     (),
    .S_HREADYOUT  (S_HREADYOUT),
    .S_HRDATA     (S_HRDATA),
    .S_HRESP      (S_HRESP),

    .S_HADDR_BASE (S_HADDR_BASE),
    .S_HADDR_MASK (S_HADDR_MASK)
        // (ex) S_HADDR_BASE[]=0x01000000, S_HADDR_BASE[]=0xfff00000
        //      Slave Address Range=0x01000000-0x010fffff
);
// width = 32bit
assign S_HADDR_BASE[0] = base_s0_addr;
assign S_HADDR_BASE[1] = base_s1_addr;
assign S_HADDR_BASE[2] = base_s2_addr;
assign S_HADDR_BASE[3] = base_s3_addr;
assign S_HADDR_BASE[4] = base_s4_addr;
assign S_HADDR_BASE[5] = base_s5_addr;
assign S_HADDR_BASE[6] = base_s6_addr;
assign S_HADDR_BASE[7] = base_s7_addr;
assign S_HADDR_BASE[8] = base_s8_addr;
assign S_HADDR_BASE[9] = base_s9_addr;
assign S_HADDR_BASE[10] = base_s10_addr;
assign S_HADDR_BASE[11] = base_s11_addr;

assign S_HADDR_MASK[0] = mask_s0_addr;
assign S_HADDR_MASK[1] = mask_s1_addr;
assign S_HADDR_MASK[2] = mask_s2_addr;
assign S_HADDR_MASK[3] = mask_s3_addr;
assign S_HADDR_MASK[4] = mask_s4_addr;
assign S_HADDR_MASK[5] = mask_s5_addr;
assign S_HADDR_MASK[6] = mask_s6_addr;
assign S_HADDR_MASK[7] = mask_s7_addr;
assign S_HADDR_MASK[8] = mask_s8_addr;
assign S_HADDR_MASK[9] = mask_s9_addr;
assign S_HADDR_MASK[10] = mask_s10_addr;
assign S_HADDR_MASK[11] = mask_s11_addr;

//input 
// width = 1bit
assign S_HREADYOUT[0] = ismc_hmain0_s0_hready;
assign S_HREADYOUT[1] = imemdummy0_hmain0_s1_hready;
assign S_HREADYOUT[2] = smc_hmain0_s2_hready;
assign S_HREADYOUT[3] = smc_hmain0_s3_hready;
assign S_HREADYOUT[4] = smc_hmain0_s4_hready;
assign S_HREADYOUT[5] = dmemdummy0_hmain0_s5_hready;
assign S_HREADYOUT[6] = dmac0_hmain0_s6_hready;
assign S_HREADYOUT[7] = dummy0_hmain0_s7_hready;
assign S_HREADYOUT[8] = dummy1_hmain0_s8_hready;
assign S_HREADYOUT[9] = dummy2_hmain0_s9_hready;
assign S_HREADYOUT[10] = lsbus_hmain0_s10_hready;
assign S_HREADYOUT[11] = dummy3_hmain0_s11_hready;
// width = 32bit
assign S_HRDATA[0] = ismc_hmain0_s0_hrdata;
assign S_HRDATA[1] = imemdummy0_hmain0_s1_hrdata;
assign S_HRDATA[2] = smc_hmain0_s2_hrdata;
assign S_HRDATA[3] = smc_hmain0_s3_hrdata;
assign S_HRDATA[4] = smc_hmain0_s4_hrdata;
assign S_HRDATA[5] = dmemdummy0_hmain0_s5_hrdata;
assign S_HRDATA[6] = dmac0_hmain0_s6_hrdata;
assign S_HRDATA[7] = dummy0_hmain0_s7_hrdata;
assign S_HRDATA[8] = dummy1_hmain0_s8_hrdata;
assign S_HRDATA[9] = dummy2_hmain0_s9_hrdata;
assign S_HRDATA[10] = lsbus_hmain0_s10_hrdata;
assign S_HRDATA[11] = dummy3_hmain0_s11_hrdata;
// width = 1bit
assign S_HRESP[0] = ismc_hmain0_s0_hresp[0];
assign S_HRESP[1] = imemdummy0_hmain0_s1_hresp[0];
assign S_HRESP[2] = smc_hmain0_s2_hresp[0];
assign S_HRESP[3] = smc_hmain0_s3_hresp[0];
assign S_HRESP[4] = smc_hmain0_s4_hresp[0];
assign S_HRESP[5] = dmemdummy0_hmain0_s5_hresp[0];
assign S_HRESP[6] = dmac0_hmain0_s6_hresp[0];
assign S_HRESP[7] = dummy0_hmain0_s7_hresp[0];
assign S_HRESP[8] = dummy1_hmain0_s8_hresp[0];
assign S_HRESP[9] = dummy2_hmain0_s9_hresp[0];
assign S_HRESP[10] = lsbus_hmain0_s10_hresp[0];
assign S_HRESP[11] = dummy3_hmain0_s11_hresp[0];
//output 
// width = 32bit
assign hmain0_ismc_s0_haddr       = S_HADDR[0];
assign hmain0_imemdummy0_s1_haddr = S_HADDR[1];
assign hmain0_smc_s2_haddr        = S_HADDR[2];
assign hmain0_smc_s3_haddr        = S_HADDR[3];
assign hmain0_smc_s4_haddr        = S_HADDR[4];
assign hmain0_dmemdummy0_s5_haddr = S_HADDR[5];
assign hmain0_dmac0_s6_haddr      = S_HADDR[6];
assign hmain0_dummy0_s7_haddr     = S_HADDR[7];
assign hmain0_dummy1_s8_haddr     = S_HADDR[8];
assign hmain0_dummy2_s9_haddr     = S_HADDR[9];
assign hmain0_lsbus_s10_haddr     = S_HADDR[10];
assign hmain0_dummy3_s11_haddr    = S_HADDR[11];
// width = 3bit
assign hmain0_ismc_s0_hburst       = S_HBURST[0];
assign hmain0_imemdummy0_s1_hburst = S_HBURST[1];
assign hmain0_smc_s2_hburst        = S_HBURST[2];
assign hmain0_smc_s3_hburst        = S_HBURST[3];
assign hmain0_smc_s4_hburst        = S_HBURST[4];
assign hmain0_dmemdummy0_s5_hburst = S_HBURST[5];
assign hmain0_dmac0_s6_hburst      = S_HBURST[6];
assign hmain0_dummy0_s7_hburst     = S_HBURST[7];
assign hmain0_dummy1_s8_hburst     = S_HBURST[8];
assign hmain0_dummy2_s9_hburst     = S_HBURST[9];
assign hmain0_lsbus_s10_hburst     = S_HBURST[10];
assign hmain0_dummy3_s11_hburst    = S_HBURST[11];
// width = 4bit
assign hmain0_ismc_s0_hprot       = S_HPROT[0];
assign hmain0_imemdummy0_s1_hprot = S_HPROT[1];
assign hmain0_smc_s2_hprot        = S_HPROT[2];
assign hmain0_smc_s3_hprot        = S_HPROT[3];
assign hmain0_smc_s4_hprot        = S_HPROT[4];
assign hmain0_dmemdummy0_s5_hprot = S_HPROT[5];
assign hmain0_dmac0_s6_hprot      = S_HPROT[6];
assign hmain0_dummy0_s7_hprot     = S_HPROT[7];
assign hmain0_dummy1_s8_hprot     = S_HPROT[8];
assign hmain0_dummy2_s9_hprot     = S_HPROT[9];
assign hmain0_lsbus_s10_hprot     = S_HPROT[10];
assign hmain0_dummy3_s11_hprot    = S_HPROT[11];
// width = 1bit
assign hmain0_ismc_s0_hsel       = S_HSEL[0];
assign hmain0_imemdummy0_s1_hsel = S_HSEL[1];
assign hmain0_smc_s2_hsel        = S_HSEL[2];
assign hmain0_smc_s3_hsel        = S_HSEL[3];
assign hmain0_smc_s4_hsel        = S_HSEL[4];
assign hmain0_dmemdummy0_s5_hsel = S_HSEL[5];
assign hmain0_dmac0_s6_hsel      = S_HSEL[6];
assign hmain0_dummy0_s7_hsel     = S_HSEL[7];
assign hmain0_dummy1_s8_hsel     = S_HSEL[8];
assign hmain0_dummy2_s9_hsel     = S_HSEL[9];
assign hmain0_lsbus_s10_hsel     = S_HSEL[10];
assign hmain0_dummy3_s11_hsel    = S_HSEL[11];
// width = 3bit
assign hmain0_ismc_s0_hsize       = S_HSIZE[0];
assign hmain0_imemdummy0_s1_hsize = S_HSIZE[1];
assign hmain0_smc_s2_hsize        = S_HSIZE[2];
assign hmain0_smc_s3_hsize        = S_HSIZE[3];
assign hmain0_smc_s4_hsize        = S_HSIZE[4];
assign hmain0_dmemdummy0_s5_hsize = S_HSIZE[5];
assign hmain0_dmac0_s6_hsize      = S_HSIZE[6];
assign hmain0_dummy0_s7_hsize     = S_HSIZE[7];
assign hmain0_dummy1_s8_hsize     = S_HSIZE[8];
assign hmain0_dummy2_s9_hsize     = S_HSIZE[9];
assign hmain0_lsbus_s10_hsize     = S_HSIZE[10];
assign hmain0_dummy3_s11_hsize    = S_HSIZE[11];
// width = 2bit
assign hmain0_ismc_s0_htrans       = S_HTRANS[0];
assign hmain0_imemdummy0_s1_htrans = S_HTRANS[1];
assign hmain0_smc_s2_htrans        = S_HTRANS[2];
assign hmain0_smc_s3_htrans        = S_HTRANS[3];
assign hmain0_smc_s4_htrans        = S_HTRANS[4];
assign hmain0_dmemdummy0_s5_htrans = S_HTRANS[5];
assign hmain0_dmac0_s6_htrans      = S_HTRANS[6];
assign hmain0_dummy0_s7_htrans     = S_HTRANS[7];
assign hmain0_dummy1_s8_htrans     = S_HTRANS[8];
assign hmain0_dummy2_s9_htrans     = S_HTRANS[9];
assign hmain0_lsbus_s10_htrans     = S_HTRANS[10];
assign hmain0_dummy3_s11_htrans    = S_HTRANS[11];
// width = 32bit
assign hmain0_ismc_s0_hwdata       = S_HWDATA[0];
assign hmain0_imemdummy0_s1_hwdata = S_HWDATA[1];
assign hmain0_smc_s2_hwdata        = S_HWDATA[2];
assign hmain0_smc_s3_hwdata        = S_HWDATA[3];
assign hmain0_smc_s4_hwdata        = S_HWDATA[4];
assign hmain0_dmemdummy0_s5_hwdata = S_HWDATA[5];
assign hmain0_dmac0_s6_hwdata      = S_HWDATA[6];
assign hmain0_dummy0_s7_hwdata     = S_HWDATA[7];
assign hmain0_dummy1_s8_hwdata     = S_HWDATA[8];
assign hmain0_dummy2_s9_hwdata     = S_HWDATA[9];
assign hmain0_lsbus_s10_hwdata     = S_HWDATA[10];
assign hmain0_dummy3_s11_hwdata    = S_HWDATA[11];
// width = 1bit
assign hmain0_ismc_s0_hwrite       = S_HWRITE[0];
assign hmain0_imemdummy0_s1_hwrite = S_HWRITE[1];
assign hmain0_smc_s2_hwrite        = S_HWRITE[2];
assign hmain0_smc_s3_hwrite        = S_HWRITE[3];
assign hmain0_smc_s4_hwrite        = S_HWRITE[4];
assign hmain0_dmemdummy0_s5_hwrite = S_HWRITE[5];
assign hmain0_dmac0_s6_hwrite      = S_HWRITE[6];
assign hmain0_dummy0_s7_hwrite     = S_HWRITE[7];
assign hmain0_dummy1_s8_hwrite     = S_HWRITE[8];
assign hmain0_dummy2_s9_hwrite     = S_HWRITE[9];
assign hmain0_lsbus_s10_hwrite     = S_HWRITE[10];
assign hmain0_dummy3_s11_hwrite    = S_HWRITE[11];

// ahb_matrix_7_12_main  x_ahb_matrix_7_12_main (
//   .hclk                        (pmu_hmain0_hclk            ),
//   .hresetn                     (pmu_hmain0_hrst_b          ),
//   .m0_haddr                    (cpu_hmain0_m0_haddr        ),
//   .m0_hburst                   (cpu_hmain0_m0_hburst       ),
//   .m0_hgrant                   (hmain0_cpu_m0_hgrant       ),
//   .m0_hprot                    (cpu_hmain0_m0_hprot_tmp    ),
//   .m0_hrdata                   (hmain0_cpu_m0_hrdata       ),
//   .m0_hready                   (hmain0_cpu_m0_hready       ),
//   .m0_hresp                    (hmain0_cpu_m0_hresp        ),
//   .m0_hsize                    (cpu_hmain0_m0_hsize        ),
//   .m0_htrans                   (cpu_hmain0_m0_htrans       ),
//   .m0_hwdata                   (cpu_hmain0_m0_hwdata       ),
//   .m0_hwrite                   (cpu_hmain0_m0_hwrite       ),
//   .m1_haddr                    (cpu_hmain0_m1_haddr        ),
//   .m1_hburst                   (cpu_hmain0_m1_hburst       ),
//   .m1_hgrant                   (hmain0_cpu_m1_hgrant       ),
//   .m1_hprot                    (cpu_hmain0_m1_hprot_tmp    ),
//   .m1_hrdata                   (hmain0_cpu_m1_hrdata       ),
//   .m1_hready                   (hmain0_cpu_m1_hready       ),
//   .m1_hresp                    (hmain0_cpu_m1_hresp        ),
//   .m1_hsize                    (cpu_hmain0_m1_hsize        ),
//   .m1_htrans                   (cpu_hmain0_m1_htrans       ),
//   .m1_hwdata                   (cpu_hmain0_m1_hwdata       ),
//   .m1_hwrite                   (cpu_hmain0_m1_hwrite       ),
//   .m2_haddr                    (cpu_hmain0_m2_haddr        ),
//   .m2_hburst                   (cpu_hmain0_m2_hburst       ),
//   .m2_hgrant                   (hmain0_cpu_m2_hgrant       ),
//   .m2_hprot                    (cpu_hmain0_m2_hprot_tmp    ),
//   .m2_hrdata                   (hmain0_cpu_m2_hrdata       ),
//   .m2_hready                   (hmain0_cpu_m2_hready       ),
//   .m2_hresp                    (hmain0_cpu_m2_hresp        ),
//   .m2_hsize                    (cpu_hmain0_m2_hsize        ),
//   .m2_htrans                   (cpu_hmain0_m2_htrans       ),
//   .m2_hwdata                   (cpu_hmain0_m2_hwdata       ),
//   .m2_hwrite                   (cpu_hmain0_m2_hwrite       ),
//   .m3_haddr                    (dmac0_hmain0_m3_haddr      ),
//   .m3_hburst                   (dmac0_hmain0_m3_hburst     ),
//   .m3_hgrant                   (hmain0_dmac0_m3_hgrant     ),
//   .m3_hprot                    (dmac0_hmain0_m3_hprot_tmp  ),
//   .m3_hrdata                   (hmain0_dmac0_m3_hrdata     ),
//   .m3_hready                   (hmain0_dmac0_m3_hready     ),
//   .m3_hresp                    (hmain0_dmac0_m3_hresp      ),
//   .m3_hsize                    (dmac0_hmain0_m3_hsize      ),
//   .m3_htrans                   (dmac0_hmain0_m3_htrans     ),
//   .m3_hwdata                   (dmac0_hmain0_m3_hwdata     ),
//   .m3_hwrite                   (dmac0_hmain0_m3_hwrite     ),
//   .m4_haddr                    (mdummy0_hmain0_m4_haddr    ),
//   .m4_hburst                   (mdummy0_hmain0_m4_hburst   ),
//   .m4_hgrant                   (hmain0_mdummy0_m4_hgrant   ),
//   .m4_hprot                    (mdummy0_hmain0_m4_hprot_tmp),
//   .m4_hrdata                   (hmain0_mdummy0_m4_hrdata   ),
//   .m4_hready                   (hmain0_mdummy0_m4_hready   ),
//   .m4_hresp                    (hmain0_mdummy0_m4_hresp    ),
//   .m4_hsize                    (mdummy0_hmain0_m4_hsize    ),
//   .m4_htrans                   (mdummy0_hmain0_m4_htrans   ),
//   .m4_hwdata                   (mdummy0_hmain0_m4_hwdata   ),
//   .m4_hwrite                   (mdummy0_hmain0_m4_hwrite   ),
//   .m5_haddr                    (mdummy1_hmain0_m5_haddr    ),
//   .m5_hburst                   (mdummy1_hmain0_m5_hburst   ),
//   .m5_hgrant                   (hmain0_mdummy1_m5_hgrant   ),
//   .m5_hprot                    (mdummy1_hmain0_m5_hprot_tmp),
//   .m5_hrdata                   (hmain0_mdummy1_m5_hrdata   ),
//   .m5_hready                   (hmain0_mdummy1_m5_hready   ),
//   .m5_hresp                    (hmain0_mdummy1_m5_hresp    ),
//   .m5_hsize                    (mdummy1_hmain0_m5_hsize    ),
//   .m5_htrans                   (mdummy1_hmain0_m5_htrans   ),
//   .m5_hwdata                   (mdummy1_hmain0_m5_hwdata   ),
//   .m5_hwrite                   (mdummy1_hmain0_m5_hwrite   ),
//   .m6_haddr                    (mdummy2_hmain0_m6_haddr    ),
//   .m6_hburst                   (mdummy2_hmain0_m6_hburst   ),
//   .m6_hgrant                   (hmain0_mdummy2_m6_hgrant   ),
//   .m6_hprot                    (mdummy2_hmain0_m6_hprot_tmp),
//   .m6_hrdata                   (hmain0_mdummy2_m6_hrdata   ),
//   .m6_hready                   (hmain0_mdummy2_m6_hready   ),
//   .m6_hresp                    (hmain0_mdummy2_m6_hresp    ),
//   .m6_hsize                    (mdummy2_hmain0_m6_hsize    ),
//   .m6_htrans                   (mdummy2_hmain0_m6_htrans   ),
//   .m6_hwdata                   (mdummy2_hmain0_m6_hwdata   ),
//   .m6_hwrite                   (mdummy2_hmain0_m6_hwrite   ),
//   .s0_haddr                    (hmain0_ismc_s0_haddr       ),
//   .s0_hburst                   (hmain0_ismc_s0_hburst      ),
//   .s0_hprot                    (hmain0_ismc_s0_hprot       ),
//   .s0_hrdata                   (ismc_hmain0_s0_hrdata      ),
//   .s0_hready                   (ismc_hmain0_s0_hready      ),
//   .s0_hresp                    (ismc_hmain0_s0_hresp       ),
//   .s0_hselx                    (hmain0_ismc_s0_hsel        ),
//   .s0_hsize                    (hmain0_ismc_s0_hsize       ),
//   .s0_htrans                   (hmain0_ismc_s0_htrans      ),
//   .s0_hwdata                   (hmain0_ismc_s0_hwdata      ),
//   .s0_hwrite                   (hmain0_ismc_s0_hwrite      ),
//   .s10_haddr                   (hmain0_lsbus_s10_haddr     ),
//   .s10_hburst                  (hmain0_lsbus_s10_hburst    ),
//   .s10_hprot                   (hmain0_lsbus_s10_hprot     ),
//   .s10_hrdata                  (lsbus_hmain0_s10_hrdata    ),
//   .s10_hready                  (lsbus_hmain0_s10_hready    ),
//   .s10_hresp                   (lsbus_hmain0_s10_hresp     ),
//   .s10_hselx                   (hmain0_lsbus_s10_hsel      ),
//   .s10_hsize                   (hmain0_lsbus_s10_hsize     ),
//   .s10_htrans                  (hmain0_lsbus_s10_htrans    ),
//   .s10_hwdata                  (hmain0_lsbus_s10_hwdata    ),
//   .s10_hwrite                  (hmain0_lsbus_s10_hwrite    ),
//   .s11_haddr                   (hmain0_dummy3_s11_haddr    ),
//   .s11_hburst                  (hmain0_dummy3_s11_hburst   ),
//   .s11_hprot                   (hmain0_dummy3_s11_hprot    ),
//   .s11_hrdata                  (dummy3_hmain0_s11_hrdata   ),
//   .s11_hready                  (dummy3_hmain0_s11_hready   ),
//   .s11_hresp                   (dummy3_hmain0_s11_hresp    ),
//   .s11_hselx                   (hmain0_dummy3_s11_hsel     ),
//   .s11_hsize                   (hmain0_dummy3_s11_hsize    ),
//   .s11_htrans                  (hmain0_dummy3_s11_htrans   ),
//   .s11_hwdata                  (hmain0_dummy3_s11_hwdata   ),
//   .s11_hwrite                  (hmain0_dummy3_s11_hwrite   ),
//   .s1_haddr                    (hmain0_imemdummy0_s1_haddr ),
//   .s1_hburst                   (hmain0_imemdummy0_s1_hburst),
//   .s1_hprot                    (hmain0_imemdummy0_s1_hprot ),
//   .s1_hrdata                   (imemdummy0_hmain0_s1_hrdata),
//   .s1_hready                   (imemdummy0_hmain0_s1_hready),
//   .s1_hresp                    (imemdummy0_hmain0_s1_hresp ),
//   .s1_hselx                    (hmain0_imemdummy0_s1_hsel  ),
//   .s1_hsize                    (hmain0_imemdummy0_s1_hsize ),
//   .s1_htrans                   (hmain0_imemdummy0_s1_htrans),
//   .s1_hwdata                   (hmain0_imemdummy0_s1_hwdata),
//   .s1_hwrite                   (hmain0_imemdummy0_s1_hwrite),
//   .s2_haddr                    (hmain0_smc_s2_haddr        ),
//   .s2_hburst                   (hmain0_smc_s2_hburst       ),
//   .s2_hprot                    (hmain0_smc_s2_hprot        ),
//   .s2_hrdata                   (smc_hmain0_s2_hrdata       ),
//   .s2_hready                   (smc_hmain0_s2_hready       ),
//   .s2_hresp                    (smc_hmain0_s2_hresp        ),
//   .s2_hselx                    (hmain0_smc_s2_hsel         ),
//   .s2_hsize                    (hmain0_smc_s2_hsize        ),
//   .s2_htrans                   (hmain0_smc_s2_htrans       ),
//   .s2_hwdata                   (hmain0_smc_s2_hwdata       ),
//   .s2_hwrite                   (hmain0_smc_s2_hwrite       ),
//   .s3_haddr                    (hmain0_smc_s3_haddr        ),
//   .s3_hburst                   (hmain0_smc_s3_hburst       ),
//   .s3_hprot                    (hmain0_smc_s3_hprot        ),
//   .s3_hrdata                   (smc_hmain0_s3_hrdata       ),
//   .s3_hready                   (smc_hmain0_s3_hready       ),
//   .s3_hresp                    (smc_hmain0_s3_hresp        ),
//   .s3_hselx                    (hmain0_smc_s3_hsel         ),
//   .s3_hsize                    (hmain0_smc_s3_hsize        ),
//   .s3_htrans                   (hmain0_smc_s3_htrans       ),
//   .s3_hwdata                   (hmain0_smc_s3_hwdata       ),
//   .s3_hwrite                   (hmain0_smc_s3_hwrite       ),
//   .s4_haddr                    (hmain0_smc_s4_haddr        ),
//   .s4_hburst                   (hmain0_smc_s4_hburst       ),
//   .s4_hprot                    (hmain0_smc_s4_hprot        ),
//   .s4_hrdata                   (smc_hmain0_s4_hrdata       ),
//   .s4_hready                   (smc_hmain0_s4_hready       ),
//   .s4_hresp                    (smc_hmain0_s4_hresp        ),
//   .s4_hselx                    (hmain0_smc_s4_hsel         ),
//   .s4_hsize                    (hmain0_smc_s4_hsize        ),
//   .s4_htrans                   (hmain0_smc_s4_htrans       ),
//   .s4_hwdata                   (hmain0_smc_s4_hwdata       ),
//   .s4_hwrite                   (hmain0_smc_s4_hwrite       ),
//   .s5_haddr                    (hmain0_dmemdummy0_s5_haddr ),
//   .s5_hburst                   (hmain0_dmemdummy0_s5_hburst),
//   .s5_hprot                    (hmain0_dmemdummy0_s5_hprot ),
//   .s5_hrdata                   (dmemdummy0_hmain0_s5_hrdata),
//   .s5_hready                   (dmemdummy0_hmain0_s5_hready),
//   .s5_hresp                    (dmemdummy0_hmain0_s5_hresp ),
//   .s5_hselx                    (hmain0_dmemdummy0_s5_hsel  ),
//   .s5_hsize                    (hmain0_dmemdummy0_s5_hsize ),
//   .s5_htrans                   (hmain0_dmemdummy0_s5_htrans),
//   .s5_hwdata                   (hmain0_dmemdummy0_s5_hwdata),
//   .s5_hwrite                   (hmain0_dmemdummy0_s5_hwrite),
//   .s6_haddr                    (hmain0_dmac0_s6_haddr      ),
//   .s6_hburst                   (hmain0_dmac0_s6_hburst     ),
//   .s6_hprot                    (hmain0_dmac0_s6_hprot      ),
//   .s6_hrdata                   (dmac0_hmain0_s6_hrdata     ),
//   .s6_hready                   (dmac0_hmain0_s6_hready     ),
//   .s6_hresp                    (dmac0_hmain0_s6_hresp      ),
//   .s6_hselx                    (hmain0_dmac0_s6_hsel       ),
//   .s6_hsize                    (hmain0_dmac0_s6_hsize      ),
//   .s6_htrans                   (hmain0_dmac0_s6_htrans     ),
//   .s6_hwdata                   (hmain0_dmac0_s6_hwdata     ),
//   .s6_hwrite                   (hmain0_dmac0_s6_hwrite     ),
//   .s7_haddr                    (hmain0_dummy0_s7_haddr     ),
//   .s7_hburst                   (hmain0_dummy0_s7_hburst    ),
//   .s7_hprot                    (hmain0_dummy0_s7_hprot     ),
//   .s7_hrdata                   (dummy0_hmain0_s7_hrdata    ),
//   .s7_hready                   (dummy0_hmain0_s7_hready    ),
//   .s7_hresp                    (dummy0_hmain0_s7_hresp     ),
//   .s7_hselx                    (hmain0_dummy0_s7_hsel      ),
//   .s7_hsize                    (hmain0_dummy0_s7_hsize     ),
//   .s7_htrans                   (hmain0_dummy0_s7_htrans    ),
//   .s7_hwdata                   (hmain0_dummy0_s7_hwdata    ),
//   .s7_hwrite                   (hmain0_dummy0_s7_hwrite    ),
//   .s8_haddr                    (hmain0_dummy1_s8_haddr     ),
//   .s8_hburst                   (hmain0_dummy1_s8_hburst    ),
//   .s8_hprot                    (hmain0_dummy1_s8_hprot     ),
//   .s8_hrdata                   (dummy1_hmain0_s8_hrdata    ),
//   .s8_hready                   (dummy1_hmain0_s8_hready    ),
//   .s8_hresp                    (dummy1_hmain0_s8_hresp     ),
//   .s8_hselx                    (hmain0_dummy1_s8_hsel      ),
//   .s8_hsize                    (hmain0_dummy1_s8_hsize     ),
//   .s8_htrans                   (hmain0_dummy1_s8_htrans    ),
//   .s8_hwdata                   (hmain0_dummy1_s8_hwdata    ),
//   .s8_hwrite                   (hmain0_dummy1_s8_hwrite    ),
//   .s9_haddr                    (hmain0_dummy2_s9_haddr     ),
//   .s9_hburst                   (hmain0_dummy2_s9_hburst    ),
//   .s9_hprot                    (hmain0_dummy2_s9_hprot     ),
//   .s9_hrdata                   (dummy2_hmain0_s9_hrdata    ),
//   .s9_hready                   (dummy2_hmain0_s9_hready    ),
//   .s9_hresp                    (dummy2_hmain0_s9_hresp     ),
//   .s9_hselx                    (hmain0_dummy2_s9_hsel      ),
//   .s9_hsize                    (hmain0_dummy2_s9_hsize     ),
//   .s9_htrans                   (hmain0_dummy2_s9_htrans    ),
//   .s9_hwdata                   (hmain0_dummy2_s9_hwdata    ),
//   .s9_hwrite                   (hmain0_dummy2_s9_hwrite    )
// );
// ahbm_dummy_top  x_main_mdummy_top0 (
//   .hclk                     (pmu_mdummy0_hclk        ),
//   .hrst_b                   (pmu_mdummy0_hrst_b      ),
//   .mhaddr                   (mdummy0_hmain0_m4_haddr ),
//   .mhburst                  (mdummy0_hmain0_m4_hburst),
//   .mhgrant                  (hmain0_mdummy0_m4_hgrant),
//   .mhprot                   (mdummy0_hmain0_m4_hprot ),
//   .mhrdata                  (hmain0_mdummy0_m4_hrdata),
//   .mhready                  (hmain0_mdummy0_m4_hready),
//   .mhresp                   (hmain0_mdummy0_m4_hresp ),
//   .mhsize                   (mdummy0_hmain0_m4_hsize ),
//   .mhtrans                  (mdummy0_hmain0_m4_htrans),
//   .mhwdata                  (mdummy0_hmain0_m4_hwdata),
//   .mhwrite                  (mdummy0_hmain0_m4_hwrite)
// );
// ahbm_dummy_top  x_main_mdummy_top1 (
//   .hclk                     (pmu_mdummy1_hclk        ),
//   .hrst_b                   (pmu_mdummy1_hrst_b      ),
//   .mhaddr                   (mdummy1_hmain0_m5_haddr ),
//   .mhburst                  (mdummy1_hmain0_m5_hburst),
//   .mhgrant                  (hmain0_mdummy1_m5_hgrant),
//   .mhprot                   (mdummy1_hmain0_m5_hprot ),
//   .mhrdata                  (hmain0_mdummy1_m5_hrdata),
//   .mhready                  (hmain0_mdummy1_m5_hready),
//   .mhresp                   (hmain0_mdummy1_m5_hresp ),
//   .mhsize                   (mdummy1_hmain0_m5_hsize ),
//   .mhtrans                  (mdummy1_hmain0_m5_htrans),
//   .mhwdata                  (mdummy1_hmain0_m5_hwdata),
//   .mhwrite                  (mdummy1_hmain0_m5_hwrite)
// );
ahbm_dummy_top  x_main_mdummy_top2 (
  .hclk                     (pmu_mdummy2_hclk        ),
  .hrst_b                   (pmu_mdummy2_hrst_b      ),
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
);
//ahb_dummy_top  x_main_imemdummy_top0 (
//  .haddr                       (hmain0_imemdummy0_s1_haddr ),
//  .hclk                        (pmu_imemdummy0_hclk        ),
//  .hprot                       (hmain0_imemdummy0_s1_hprot ),
//  .hrdata                      (imemdummy0_hmain0_s1_hrdata),
//  .hready                      (imemdummy0_hmain0_s1_hready),
//  .hresp                       (imemdummy0_hmain0_s1_hresp ),
//  .hrst_b                      (pmu_imemdummy0_hrst_b      ),
//  .hsel                        (hmain0_imemdummy0_s1_hsel  ),
//  .hsize                       (hmain0_imemdummy0_s1_hsize ),
//  .htrans                      (hmain0_imemdummy0_s1_htrans),
//  .hwdata                      (hmain0_imemdummy0_s1_hwdata),
//  .hwrite                      (hmain0_imemdummy0_s1_hwrite),
//  .intr                        (main_imemdummy0_intr       )
//);
// ahb_dummy_top  x_main_dmemdummy_top0 (
//   .haddr                       (hmain0_dmemdummy0_s5_haddr ),
//   .hclk                        (pmu_dmemdummy0_hclk        ),
//   .hprot                       (hmain0_dmemdummy0_s5_hprot ),
//   .hrdata                      (dmemdummy0_hmain0_s5_hrdata),
//   .hready                      (dmemdummy0_hmain0_s5_hready),
//   .hresp                       (dmemdummy0_hmain0_s5_hresp ),
//   .hrst_b                      (pmu_dmemdummy0_hrst_b      ),
//   .hsel                        (hmain0_dmemdummy0_s5_hsel  ),
//   .hsize                       (hmain0_dmemdummy0_s5_hsize ),
//   .htrans                      (hmain0_dmemdummy0_s5_htrans),
//   .hwdata                      (hmain0_dmemdummy0_s5_hwdata),
//   .hwrite                      (hmain0_dmemdummy0_s5_hwrite),
//   .intr                        (main_dmemdummy0_intr       )
// );

// ahb_dummy_top  x_main_dummy_top0 (
//   .haddr                   (hmain0_dummy0_s7_haddr ),
//   .hclk                    (pmu_dummy0_hclk        ),
//   .hprot                   (hmain0_dummy0_s7_hprot ),
//   .hrdata                  (dummy0_hmain0_s7_hrdata),
//   .hready                  (dummy0_hmain0_s7_hready),
//   .hresp                   (dummy0_hmain0_s7_hresp ),
//   .hrst_b                  (pmu_dummy0_hrst_b      ),
//   .hsel                    (hmain0_dummy0_s7_hsel  ),
//   .hsize                   (hmain0_dummy0_s7_hsize ),
//   .htrans                  (hmain0_dummy0_s7_htrans),
//   .hwdata                  (hmain0_dummy0_s7_hwdata),
//   .hwrite                  (hmain0_dummy0_s7_hwrite),
//   .intr                    (main_dummy0_intr       )
// );
dmac_top_simply x_dmac_top (
  .ch0_etb_evtdone            (ch0_etb_evtdone           ),
  .ch0_etb_htfrdone           (ch0_etb_htfrdone          ),
  .ch0_etb_tfrdone            (ch0_etb_tfrdone           ),
  .ch0_prot_out               (dmacch0_etb_prot          ),
  .ch10_etb_evtdone           (ch10_etb_evtdone          ),
  .ch10_etb_htfrdone          (ch10_etb_htfrdone         ),
  .ch10_etb_tfrdone           (ch10_etb_tfrdone          ),
  .ch10_prot_out              (dmacch10_etb_prot         ),
  .ch11_etb_evtdone           (ch11_etb_evtdone          ),
  .ch11_etb_htfrdone          (ch11_etb_htfrdone         ),
  .ch11_etb_tfrdone           (ch11_etb_tfrdone          ),
  .ch11_prot_out              (dmacch11_etb_prot         ),
  .ch12_etb_evtdone           (ch12_etb_evtdone          ),
  .ch12_etb_htfrdone          (ch12_etb_htfrdone         ),
  .ch12_etb_tfrdone           (ch12_etb_tfrdone          ),
  .ch12_prot_out              (dmacch12_etb_prot         ),
  .ch13_etb_evtdone           (ch13_etb_evtdone          ),
  .ch13_etb_htfrdone          (ch13_etb_htfrdone         ),
  .ch13_etb_tfrdone           (ch13_etb_tfrdone          ),
  .ch13_prot_out              (dmacch13_etb_prot         ),
  .ch14_etb_evtdone           (ch14_etb_evtdone          ),
  .ch14_etb_htfrdone          (ch14_etb_htfrdone         ),
  .ch14_etb_tfrdone           (ch14_etb_tfrdone          ),
  .ch14_prot_out              (dmacch14_etb_prot         ),
  .ch15_etb_evtdone           (ch15_etb_evtdone          ),
  .ch15_etb_htfrdone          (ch15_etb_htfrdone         ),
  .ch15_etb_tfrdone           (ch15_etb_tfrdone          ),
  .ch15_prot_out              (dmacch15_etb_prot         ),
  .ch1_etb_evtdone            (ch1_etb_evtdone           ),
  .ch1_etb_htfrdone           (ch1_etb_htfrdone          ),
  .ch1_etb_tfrdone            (ch1_etb_tfrdone           ),
  .ch1_prot_out               (dmacch1_etb_prot          ),
  .ch2_etb_evtdone            (ch2_etb_evtdone           ),
  .ch2_etb_htfrdone           (ch2_etb_htfrdone          ),
  .ch2_etb_tfrdone            (ch2_etb_tfrdone           ),
  .ch2_prot_out               (dmacch2_etb_prot          ),
  .ch3_etb_evtdone            (ch3_etb_evtdone           ),
  .ch3_etb_htfrdone           (ch3_etb_htfrdone          ),
  .ch3_etb_tfrdone            (ch3_etb_tfrdone           ),
  .ch3_prot_out               (dmacch3_etb_prot          ),
  .ch4_etb_evtdone            (ch4_etb_evtdone           ),
  .ch4_etb_htfrdone           (ch4_etb_htfrdone          ),
  .ch4_etb_tfrdone            (ch4_etb_tfrdone           ),
  .ch4_prot_out               (dmacch4_etb_prot          ),
  .ch5_etb_evtdone            (ch5_etb_evtdone           ),
  .ch5_etb_htfrdone           (ch5_etb_htfrdone          ),
  .ch5_etb_tfrdone            (ch5_etb_tfrdone           ),
  .ch5_prot_out               (dmacch5_etb_prot          ),
  .ch6_etb_evtdone            (ch6_etb_evtdone           ),
  .ch6_etb_htfrdone           (ch6_etb_htfrdone          ),
  .ch6_etb_tfrdone            (ch6_etb_tfrdone           ),
  .ch6_prot_out               (dmacch6_etb_prot          ),
  .ch7_etb_evtdone            (ch7_etb_evtdone           ),
  .ch7_etb_htfrdone           (ch7_etb_htfrdone          ),
  .ch7_etb_tfrdone            (ch7_etb_tfrdone           ),
  .ch7_prot_out               (dmacch7_etb_prot          ),
  .ch8_etb_evtdone            (ch8_etb_evtdone           ),
  .ch8_etb_htfrdone           (ch8_etb_htfrdone          ),
  .ch8_etb_tfrdone            (ch8_etb_tfrdone           ),
  .ch8_prot_out               (dmacch8_etb_prot          ),
  .ch9_etb_evtdone            (ch9_etb_evtdone           ),
  .ch9_etb_htfrdone           (ch9_etb_htfrdone          ),
  .ch9_etb_tfrdone            (ch9_etb_tfrdone           ),
  .ch9_prot_out               (dmacch9_etb_prot          ),
  .dmac_vic_if                (dmac0_wic_intr            ),
  .etb_dmacch0_trg            (etb_dmacch0_trg           ),
  .etb_dmacch10_trg           (etb_dmacch10_trg          ),
  .etb_dmacch11_trg           (etb_dmacch11_trg          ),
  .etb_dmacch12_trg           (etb_dmacch12_trg          ),
  .etb_dmacch13_trg           (etb_dmacch13_trg          ),
  .etb_dmacch14_trg           (etb_dmacch14_trg          ),
  .etb_dmacch15_trg           (etb_dmacch15_trg          ),
  .etb_dmacch1_trg            (etb_dmacch1_trg           ),
  .etb_dmacch2_trg            (etb_dmacch2_trg           ),
  .etb_dmacch3_trg            (etb_dmacch3_trg           ),
  .etb_dmacch4_trg            (etb_dmacch4_trg           ),
  .etb_dmacch5_trg            (etb_dmacch5_trg           ),
  .etb_dmacch6_trg            (etb_dmacch6_trg           ),
  .etb_dmacch7_trg            (etb_dmacch7_trg           ),
  .etb_dmacch8_trg            (etb_dmacch8_trg           ),
  .etb_dmacch9_trg            (etb_dmacch9_trg           ),
  .hclk                       (pmu_dmac0_hclk            ),
  .hrst_n                     (pmu_dmac0_hrst_b          ),
  .m_haddr                    (dmac0_hmain0_m3_haddr     ),
  .m_hburst                   (dmac0_hmain0_m3_hburst    ),
  .m_hbusreq                  (dmac0_hmain0_m3_hbusreq   ),
  .m_hgrant                   (hmain0_dmac0_m3_hgrant    ),
  .m_hlock                    (dmac0_hmain0_m3_hlock     ),
  .m_hprot                    (dmac0_hmain0_m3_hprot     ),
  .m_hrdata                   (hmain0_dmac0_m3_hrdata    ),
  .m_hready                   (hmain0_dmac0_m3_hready    ),
  .m_hresp                    (hmain0_dmac0_m3_hresp     ),
  .m_hsize                    (dmac0_hmain0_m3_hsize     ),
  .m_htrans                   (dmac0_hmain0_m3_htrans    ),
  .m_hwdata                   (dmac0_hmain0_m3_hwdata    ),
  .m_hwrite                   (dmac0_hmain0_m3_hwrite    ),
  .s_haddr                    (hmain0_dmac0_s6_haddr     ),
  .s_hprot                    (hmain0_dmac0_s6_hprot[3:0]),
  .s_hrdata                   (dmac0_hmain0_s6_hrdata    ),
  .s_hready                   (dmac0_hmain0_s6_hready    ),
  .s_hresp                    (dmac0_hmain0_s6_hresp     ),
  .s_hsel                     (hmain0_dmac0_s6_hsel      ),
  .s_htrans                   (hmain0_dmac0_s6_htrans    ),
  .s_hwdata                   (hmain0_dmac0_s6_hwdata    ),
  .s_hwrite                   (hmain0_dmac0_s6_hwrite    )
);
// ahb_dummy_top  x_main_dummy_top1 (
//   .haddr                   (hmain0_dummy1_s8_haddr ),
//   .hclk                    (pmu_dummy1_hclk        ),
//   .hprot                   (hmain0_dummy1_s8_hprot ),
//   .hrdata                  (dummy1_hmain0_s8_hrdata),
//   .hready                  (dummy1_hmain0_s8_hready),
//   .hresp                   (dummy1_hmain0_s8_hresp ),
//   .hrst_b                  (pmu_dummy1_hrst_b      ),
//   .hsel                    (hmain0_dummy1_s8_hsel  ),
//   .hsize                   (hmain0_dummy1_s8_hsize ),
//   .htrans                  (hmain0_dummy1_s8_htrans),
//   .hwdata                  (hmain0_dummy1_s8_hwdata),
//   .hwrite                  (hmain0_dummy1_s8_hwrite),
//   .intr                    (main_dummy1_intr       )
// );
// ahb_dummy_top  x_main_dummy_top2 (
//   .haddr                   (hmain0_dummy2_s9_haddr ),
//   .hclk                    (pmu_dummy2_hclk        ),
//   .hprot                   (hmain0_dummy2_s9_hprot ),
//   .hrdata                  (dummy2_hmain0_s9_hrdata),
//   .hready                  (dummy2_hmain0_s9_hready),
//   .hresp                   (dummy2_hmain0_s9_hresp ),
//   .hrst_b                  (pmu_dummy2_hrst_b      ),
//   .hsel                    (hmain0_dummy2_s9_hsel  ),
//   .hsize                   (hmain0_dummy2_s9_hsize ),
//   .htrans                  (hmain0_dummy2_s9_htrans),
//   .hwdata                  (hmain0_dummy2_s9_hwdata),
//   .hwrite                  (hmain0_dummy2_s9_hwrite),
//   .intr                    (main_dummy2_intr       )
// );
// ahb_dummy_top  x_main_dummy_top3 (
//   .haddr                    (hmain0_dummy3_s11_haddr ),
//   .hclk                     (pmu_dummy3_hclk         ),
//   .hprot                    (hmain0_dummy3_s11_hprot ),
//   .hrdata                   (dummy3_hmain0_s11_hrdata),
//   .hready                   (dummy3_hmain0_s11_hready),
//   .hresp                    (dummy3_hmain0_s11_hresp ),
//   .hrst_b                   (pmu_dummy3_hrst_b       ),
//   .hsel                     (hmain0_dummy3_s11_hsel  ),
//   .hsize                    (hmain0_dummy3_s11_hsize ),
//   .htrans                   (hmain0_dummy3_s11_htrans),
//   .hwdata                   (hmain0_dummy3_s11_hwdata),
//   .hwrite                   (hmain0_dummy3_s11_hwrite),
//   .intr                     (main_dummy3_intr        )
// );



assign etb_dmacch0_trg = 1'b0;
assign etb_dmacch10_trg = 1'b0;
assign etb_dmacch11_trg = 1'b0;
assign etb_dmacch12_trg = 1'b0;
assign etb_dmacch13_trg = 1'b0;
assign etb_dmacch14_trg = 1'b0;
assign etb_dmacch15_trg = 1'b0;
assign etb_dmacch1_trg = 1'b0;
assign etb_dmacch2_trg = 1'b0;
assign etb_dmacch3_trg = 1'b0;
assign etb_dmacch4_trg = 1'b0;
assign etb_dmacch5_trg = 1'b0;
assign etb_dmacch6_trg = 1'b0;
assign etb_dmacch7_trg = 1'b0;
assign etb_dmacch8_trg = 1'b0;
assign etb_dmacch9_trg = 1'b0;
endmodule
