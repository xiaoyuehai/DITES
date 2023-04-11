module pwm_sec_top_simply(
  etb_pwm_trig_tim0_off,
  etb_pwm_trig_tim0_on,
  etb_pwm_trig_tim1_off,
  etb_pwm_trig_tim1_on,
  etb_pwm_trig_tim2_off,
  etb_pwm_trig_tim2_on,
  etb_pwm_trig_tim3_off,
  etb_pwm_trig_tim3_on,
  etb_pwm_trig_tim4_off,
  etb_pwm_trig_tim4_on,
  etb_pwm_trig_tim5_off,
  etb_pwm_trig_tim5_on,
  fault,
  i_capedge0,
  i_capedge10,
  i_capedge2,
  i_capedge4,
  i_capedge6,
  i_capedge8,
  o_pwm0,
  o_pwm1,
  o_pwm10,
  o_pwm11,
  o_pwm2,
  o_pwm3,
  o_pwm4,
  o_pwm5,
  o_pwm6,
  o_pwm7,
  o_pwm8,
  o_pwm9,
  paddr,
  pclk,
  penable,
  pprot,
  prdata,
  presetn,
  psel,
  pwdata,
  pwm0oe_n,
  pwm10oe_n,
  pwm11oe_n,
  pwm1oe_n,
  pwm2oe_n,
  pwm3oe_n,
  pwm4oe_n,
  pwm5oe_n,
  pwm6oe_n,
  pwm7oe_n,
  pwm8oe_n,
  pwm9oe_n,
  pwm_idle,
  pwm_tim0_etb_trig,
  pwm_tim1_etb_trig,
  pwm_tim2_etb_trig,
  pwm_tim3_etb_trig,
  pwm_tim4_etb_trig,
  pwm_tim5_etb_trig,
  pwm_xx_trig,
  pwmint,
  pwrite,
  test_mode,
  tipc_pwm_trust
);
input           etb_pwm_trig_tim0_off; 
input           etb_pwm_trig_tim0_on; 
input           etb_pwm_trig_tim1_off; 
input           etb_pwm_trig_tim1_on; 
input           etb_pwm_trig_tim2_off; 
input           etb_pwm_trig_tim2_on; 
input           etb_pwm_trig_tim3_off; 
input           etb_pwm_trig_tim3_on; 
input           etb_pwm_trig_tim4_off; 
input           etb_pwm_trig_tim4_on; 
input           etb_pwm_trig_tim5_off; 
input           etb_pwm_trig_tim5_on; 
input           fault;                
input           i_capedge0;           
input           i_capedge10;          
input           i_capedge2;           
input           i_capedge4;           
input           i_capedge6;           
input           i_capedge8;           
input   [31:0]  paddr;                
input           pclk;                 
input           penable;              
input   [2 :0]  pprot;                
input           presetn;              
input           psel;                 
input   [31:0]  pwdata;               
input           pwrite;               
input           test_mode;            
input           tipc_pwm_trust;       
output          o_pwm0;               
output          o_pwm1;               
output          o_pwm10;              
output          o_pwm11;              
output          o_pwm2;               
output          o_pwm3;               
output          o_pwm4;               
output          o_pwm5;               
output          o_pwm6;               
output          o_pwm7;               
output          o_pwm8;               
output          o_pwm9;               
output  [31:0]  prdata;               
output          pwm0oe_n;             
output          pwm10oe_n;            
output          pwm11oe_n;            
output          pwm1oe_n;             
output          pwm2oe_n;             
output          pwm3oe_n;             
output          pwm4oe_n;             
output          pwm5oe_n;             
output          pwm6oe_n;             
output          pwm7oe_n;             
output          pwm8oe_n;             
output          pwm9oe_n;             
output          pwm_idle;             
output          pwm_tim0_etb_trig;    
output          pwm_tim1_etb_trig;    
output          pwm_tim2_etb_trig;    
output          pwm_tim3_etb_trig;    
output          pwm_tim4_etb_trig;    
output          pwm_tim5_etb_trig;    
output          pwm_xx_trig;          
output          pwmint;               
wire            etb_pwm_trig_tim0_off; 
wire            etb_pwm_trig_tim0_on; 
wire            etb_pwm_trig_tim1_off; 
wire            etb_pwm_trig_tim1_on; 
wire            etb_pwm_trig_tim2_off; 
wire            etb_pwm_trig_tim2_on; 
wire            etb_pwm_trig_tim3_off; 
wire            etb_pwm_trig_tim3_on; 
wire            etb_pwm_trig_tim4_off; 
wire            etb_pwm_trig_tim4_on; 
wire            etb_pwm_trig_tim5_off; 
wire            etb_pwm_trig_tim5_on; 
wire            fault;                
wire            i_capedge0;           
wire            i_capedge10;          
wire            i_capedge2;           
wire            i_capedge4;           
wire            i_capedge6;           
wire            i_capedge8;           
wire    [31:0]  i_prdata;             
wire            i_psel;               
wire            i_pwrite;             
wire            o_pwm0;               
wire            o_pwm1;               
wire            o_pwm10;              
wire            o_pwm11;              
wire            o_pwm2;               
wire            o_pwm3;               
wire            o_pwm4;               
wire            o_pwm5;               
wire            o_pwm6;               
wire            o_pwm7;               
wire            o_pwm8;               
wire            o_pwm9;               
wire    [31:0]  paddr;                
wire            pclk;                 
wire            penable;              
wire    [2 :0]  pprot;                
wire    [31:0]  prdata;               
wire            presetn;              
wire            psel;                 
wire    [31:0]  pwdata;               
wire            pwm0oe_n;             
wire            pwm10oe_n;            
wire            pwm11oe_n;            
wire            pwm1oe_n;             
wire            pwm2oe_n;             
wire            pwm3oe_n;             
wire            pwm4oe_n;             
wire            pwm5oe_n;             
wire            pwm6oe_n;             
wire            pwm7oe_n;             
wire            pwm8oe_n;             
wire            pwm9oe_n;             
wire            pwm_idle;             
wire            pwm_tim0_etb_trig;    
wire            pwm_tim1_etb_trig;    
wire            pwm_tim2_etb_trig;    
wire            pwm_tim3_etb_trig;    
wire            pwm_tim4_etb_trig;    
wire            pwm_tim5_etb_trig;    
wire            pwm_xx_trig;          
wire            pwmint;               
wire            pwrite;               
wire            test_mode;            
wire            tipc_pwm_trust;  

assign o_pwm0 = 1'b0;               
assign o_pwm1 = 1'b0;               
assign o_pwm10 = 1'b0;              
assign o_pwm11 = 1'b0;              
assign o_pwm2 = 1'b0;               
assign o_pwm3 = 1'b0;               
assign o_pwm4 = 1'b0;               
assign o_pwm5 = 1'b0;               
assign o_pwm6 = 1'b0;               
assign o_pwm7 = 1'b0;               
assign o_pwm8 = 1'b0;               
assign o_pwm9 = 1'b0;               
assign prdata = 32'b0;               
assign pwm0oe_n = 1'b0;             
assign pwm10oe_n = 1'b0;            
assign pwm11oe_n = 1'b0;            
assign pwm1oe_n = 1'b0;             
assign pwm2oe_n = 1'b0;             
assign pwm3oe_n = 1'b0;             
assign pwm4oe_n = 1'b0;             
assign pwm5oe_n = 1'b0;             
assign pwm6oe_n = 1'b0;             
assign pwm7oe_n = 1'b0;             
assign pwm8oe_n = 1'b0;             
assign pwm9oe_n = 1'b0;             
assign pwm_idle = 1'b0;             
assign pwm_tim0_etb_trig = 1'b0;    
assign pwm_tim1_etb_trig = 1'b0;    
assign pwm_tim2_etb_trig = 1'b0;    
assign pwm_tim3_etb_trig = 1'b0;    
assign pwm_tim4_etb_trig = 1'b0;    
assign pwm_tim5_etb_trig = 1'b0;    
assign pwm_xx_trig = 1'b0;          
assign pwmint = 1'b0;


endmodule
module usi3_sec_top_simply(
  clk,
  dma_ack_rx,
  dma_ack_tx,
  dma_req_rx,
  dma_req_tx,
  nss_ie_n,
  nss_in,
  nss_oe_n,
  nss_out,
  paddr,
  penable,
  pprot,
  prdata,
  psel,
  pwdata,
  pwrite,
  rst_n,
  sclk_ie_n,
  sclk_in,
  sclk_oe_n,
  sclk_out,
  sd0_ie_n,
  sd0_in,
  sd0_oe_n,
  sd0_out,
  sd1_ie_n,
  sd1_in,
  sd1_oe_n,
  sd1_out,
  sec_rx_req,
  sec_tx_req,
  tipc_usi1_trust,
  usi_etb_rx_trig,
  usi_etb_tx_trig,
  usi_intr
);
input           clk;            
input           dma_ack_rx;     
input           dma_ack_tx;     
input           nss_in;         
input   [31:0]  paddr;          
input           penable;        
input   [2 :0]  pprot;          
input           psel;           
input   [31:0]  pwdata;         
input           pwrite;         
input           rst_n;          
input           sclk_in;        
input           sd0_in;         
input           sd1_in;         
input           tipc_usi1_trust; 
output          dma_req_rx;     
output          dma_req_tx;     
output          nss_ie_n;       
output          nss_oe_n;       
output          nss_out;        
output  [31:0]  prdata;         
output          sclk_ie_n;      
output          sclk_oe_n;      
output          sclk_out;       
output          sd0_ie_n;       
output          sd0_oe_n;       
output          sd0_out;        
output          sd1_ie_n;       
output          sd1_oe_n;       
output          sd1_out;        
output          sec_rx_req;     
output          sec_tx_req;     
output          usi_etb_rx_trig; 
output          usi_etb_tx_trig; 
output          usi_intr;       
wire            clk;            
wire            dma_ack_rx;     
wire            dma_ack_tx;     
wire            dma_req_rx;     
wire            dma_req_tx;     
wire    [31:0]  i_prdata;       
wire            i_psel;         
wire            i_pwrite;       
wire            nss_ie_n;       
wire            nss_in;         
wire            nss_oe_n;       
wire            nss_out;        
wire    [31:0]  paddr;          
wire            penable;        
wire    [2 :0]  pprot;          
wire    [31:0]  prdata;         
wire            psel;           
wire    [31:0]  pwdata;         
wire            pwrite;         
wire            rst_n;          
wire            sclk_ie_n;      
wire            sclk_in;        
wire            sclk_oe_n;      
wire            sclk_out;       
wire            sd0_ie_n;       
wire            sd0_in;         
wire            sd0_oe_n;       
wire            sd0_out;        
wire            sd1_ie_n;       
wire            sd1_in;         
wire            sd1_oe_n;       
wire            sd1_out;        
wire            sec_rx_req;     
wire            sec_tx_req;     
wire            tipc_usi1_trust; 
wire            usi_etb_rx_trig; 
wire            usi_etb_tx_trig; 
wire            usi_intr;       
assign prdata[31:0] = 32'b0;

assign dma_req_rx = 1'b0;     
assign dma_req_tx = 1'b0; 
assign nss_ie_n = 1'b0 ;       
assign nss_oe_n = 1'b0;       
assign nss_out = 1'b0;        
        
assign sclk_ie_n = 1'b0;      
assign sclk_oe_n = 1'b0;      
assign sclk_out = 1'b0;       
assign sd0_ie_n = 1'b0;       
assign sd0_oe_n = 1'b0;       
assign sd0_out = 1'b0;        
assign sd1_ie_n = 1'b0;       
assign sd1_oe_n = 1'b0;       
assign sd1_out = 1'b0;        
assign sec_rx_req = 1'b0;     
assign sec_tx_req = 1'b0;     
assign usi_etb_rx_trig = 1'b0; 
assign usi_etb_tx_trig = 1'b0; 
assign usi_intr = 1'b0;

endmodule
module usi1_sec_top_simply(
  clk,
  dma_ack_rx,
  dma_ack_tx,
  dma_req_rx,
  dma_req_tx,
  nss_ie_n,
  nss_in,
  nss_oe_n,
  nss_out,
  paddr,
  penable,
  pprot,
  prdata,
  psel,
  pwdata,
  pwrite,
  rst_n,
  sclk_ie_n,
  sclk_in,
  sclk_oe_n,
  sclk_out,
  sd0_ie_n,
  sd0_in,
  sd0_oe_n,
  sd0_out,
  sd1_ie_n,
  sd1_in,
  sd1_oe_n,
  sd1_out,
  sec_rx_req,
  sec_tx_req,
  tipc_usi1_trust,
  usi_etb_rx_trig,
  usi_etb_tx_trig,
  usi_intr
);
input           clk;            
input           dma_ack_rx;     
input           dma_ack_tx;     
input           nss_in;         
input   [31:0]  paddr;          
input           penable;        
input   [2 :0]  pprot;          
input           psel;           
input   [31:0]  pwdata;         
input           pwrite;         
input           rst_n;          
input           sclk_in;        
input           sd0_in;         
input           sd1_in;         
input           tipc_usi1_trust; 
output          dma_req_rx;     
output          dma_req_tx;     
output          nss_ie_n;       
output          nss_oe_n;       
output          nss_out;        
output  [31:0]  prdata;         
output          sclk_ie_n;      
output          sclk_oe_n;      
output          sclk_out;       
output          sd0_ie_n;       
output          sd0_oe_n;       
output          sd0_out;        
output          sd1_ie_n;       
output          sd1_oe_n;       
output          sd1_out;        
output          sec_rx_req;     
output          sec_tx_req;     
output          usi_etb_rx_trig; 
output          usi_etb_tx_trig; 
output          usi_intr;       
wire            clk;            
wire            dma_ack_rx;     
wire            dma_ack_tx;     
wire            dma_req_rx;     
wire            dma_req_tx;     
wire    [31:0]  i_prdata;       
wire            i_psel;         
wire            i_pwrite;       
wire            nss_ie_n;       
wire            nss_in;         
wire            nss_oe_n;       
wire            nss_out;        
wire    [31:0]  paddr;          
wire            penable;        
wire    [2 :0]  pprot;          
wire    [31:0]  prdata;         
wire            psel;           
wire    [31:0]  pwdata;         
wire            pwrite;         
wire            rst_n;          
wire            sclk_ie_n;      
wire            sclk_in;        
wire            sclk_oe_n;      
wire            sclk_out;       
wire            sd0_ie_n;       
wire            sd0_in;         
wire            sd0_oe_n;       
wire            sd0_out;        
wire            sd1_ie_n;       
wire            sd1_in;         
wire            sd1_oe_n;       
wire            sd1_out;        
wire            sec_rx_req;     
wire            sec_tx_req;     
wire            tipc_usi1_trust; 
wire            usi_etb_rx_trig; 
wire            usi_etb_tx_trig; 
wire            usi_intr;       
usi_top  x_usi1 (
  .clk             (clk            ),
  .dma_ack_rx      (dma_ack_rx     ),
  .dma_ack_tx      (dma_ack_tx     ),
  .dma_req_rx      (dma_req_rx     ),
  .dma_req_tx      (dma_req_tx     ),
  .nss_ie_n        (nss_ie_n       ),
  .nss_in          (nss_in         ),
  .nss_oe_n        (nss_oe_n       ),
  .nss_out         (nss_out        ),
  .paddr           (paddr          ),
  .penable         (penable        ),
  .prdata          (i_prdata       ),
  .psel            (i_psel         ),
  .pwdata          (pwdata         ),
  .pwrite          (i_pwrite       ),
  .rst_n           (rst_n          ),
  .sclk_ie_n       (sclk_ie_n      ),
  .sclk_in         (sclk_in        ),
  .sclk_oe_n       (sclk_oe_n      ),
  .sclk_out        (sclk_out       ),
  .sd0_ie_n        (sd0_ie_n       ),
  .sd0_in          (sd0_in         ),
  .sd0_oe_n        (sd0_oe_n       ),
  .sd0_out         (sd0_out        ),
  .sd1_ie_n        (sd1_ie_n       ),
  .sd1_in          (sd1_in         ),
  .sd1_oe_n        (sd1_oe_n       ),
  .sd1_out         (sd1_out        ),
  .usi_etb_rx_trig (usi_etb_rx_trig),
  .usi_etb_tx_trig (usi_etb_tx_trig),
  .usi_intr        (usi_intr       )
);
assign prdata[31:0] = i_prdata[31:0];
assign i_pwrite = pwrite;
assign i_psel = psel;

assign sec_rx_req = dma_req_rx;
assign sec_tx_req = dma_req_tx;

endmodule


module tim7_sec_top_simply(
  etb_tim1_trig_en_off,
  etb_tim1_trig_en_on,
  etb_tim2_trig_en_off,
  etb_tim2_trig_en_on,
  intr,
  paddr,
  pclk,
  penable,
  pprot,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite,
  scan_mode,
  tim1_etb_trig,
  tim2_etb_trig,
  tipc_tim7_trust
);
input           etb_tim1_trig_en_off; 
input           etb_tim1_trig_en_on; 
input           etb_tim2_trig_en_off; 
input           etb_tim2_trig_en_on; 
input   [31:0]  paddr;               
input           pclk;                
input           penable;             
input   [2 :0]  pprot;               
input           presetn;             
input           psel;                
input   [31:0]  pwdata;              
input           pwrite;              
input           scan_mode;           
input           tipc_tim7_trust;     
output  [1 :0]  intr;                
output  [31:0]  prdata;              
output          tim1_etb_trig;       
output          tim2_etb_trig;       
wire            etb_tim1_trig_en_off; 
wire            etb_tim1_trig_en_on; 
wire            etb_tim2_trig_en_off; 
wire            etb_tim2_trig_en_on; 
wire    [31:0]  i_prdata;            
wire            i_psel;              
wire            i_pwrite;            
wire    [1 :0]  intr;                
wire    [31:0]  paddr;               
wire            pclk;                
wire            penable;             
wire    [2 :0]  pprot;               
wire    [31:0]  prdata;              
wire            presetn;             
wire            psel;                
wire    [31:0]  pwdata;              
wire            pwrite;              
wire            scan_mode;           
wire            tim1_etb_trig;       
wire            tim2_etb_trig;       
wire            tipc_tim7_trust;     

assign intr = 2'b0;                
assign prdata = 32'b0;              
assign tim1_etb_trig = 1'b0;       
assign tim2_etb_trig = 1'b0; 

endmodule

module tim0_sec_top_simply(
  etb_tim1_trig_en_off,
  etb_tim1_trig_en_on,
  etb_tim2_trig_en_off,
  etb_tim2_trig_en_on,
  intr,
  paddr,
  pclk,
  penable,
  pprot,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite,
  scan_mode,
  tim1_etb_trig,
  tim2_etb_trig,
  tipc_tim0_trust
);
input           etb_tim1_trig_en_off; 
input           etb_tim1_trig_en_on; 
input           etb_tim2_trig_en_off; 
input           etb_tim2_trig_en_on; 
input   [31:0]  paddr;               
input           pclk;                
input           penable;             
input   [2 :0]  pprot;               
input           presetn;             
input           psel;                
input   [31:0]  pwdata;              
input           pwrite;              
input           scan_mode;           
input           tipc_tim0_trust;     
output  [1 :0]  intr;                
output  [31:0]  prdata;              
output          tim1_etb_trig;       
output          tim2_etb_trig;       
wire            etb_tim1_trig_en_off; 
wire            etb_tim1_trig_en_on; 
wire            etb_tim2_trig_en_off; 
wire            etb_tim2_trig_en_on; 
wire    [31:0]  i_prdata;            
wire            i_psel;              
wire            i_pwrite;            
wire    [1 :0]  intr;                
wire    [31:0]  paddr;               
wire            pclk;                
wire            penable;             
wire    [2 :0]  pprot;               
wire    [31:0]  prdata;              
wire            presetn;             
wire            psel;                
wire    [31:0]  pwdata;              
wire            pwrite;              
wire            scan_mode;           
wire            tim1_etb_trig;       
wire            tim2_etb_trig;       
wire            tipc_tim0_trust;     

assign intr = 2'b0;                
assign prdata = 32'b0;              
assign tim1_etb_trig = 1'b0;       
assign tim2_etb_trig = 1'b0; 

endmodule

module tim5_sec_top_simply(
  etb_tim1_trig_en_off,
  etb_tim1_trig_en_on,
  etb_tim2_trig_en_off,
  etb_tim2_trig_en_on,
  intr,
  paddr,
  pclk,
  penable,
  pprot,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite,
  scan_mode,
  tim1_etb_trig,
  tim2_etb_trig,
  tipc_tim5_trust
);
input           etb_tim1_trig_en_off; 
input           etb_tim1_trig_en_on; 
input           etb_tim2_trig_en_off; 
input           etb_tim2_trig_en_on; 
input   [31:0]  paddr;               
input           pclk;                
input           penable;             
input   [2 :0]  pprot;               
input           presetn;             
input           psel;                
input   [31:0]  pwdata;              
input           pwrite;              
input           scan_mode;           
input           tipc_tim5_trust;     
output  [1 :0]  intr;                
output  [31:0]  prdata;              
output          tim1_etb_trig;       
output          tim2_etb_trig;       
wire            etb_tim1_trig_en_off; 
wire            etb_tim1_trig_en_on; 
wire            etb_tim2_trig_en_off; 
wire            etb_tim2_trig_en_on; 
wire    [31:0]  i_prdata;            
wire            i_psel;              
wire            i_pwrite;            
wire    [1 :0]  intr;                
wire    [31:0]  paddr;               
wire            pclk;                
wire            penable;             
wire    [2 :0]  pprot;               
wire    [31:0]  prdata;              
wire            presetn;             
wire            psel;                
wire    [31:0]  pwdata;              
wire            pwrite;              
wire            scan_mode;           
wire            tim1_etb_trig;       
wire            tim2_etb_trig;       
wire            tipc_tim5_trust;     
assign intr = 2'b0;                
assign prdata = 32'b0;              
assign tim1_etb_trig = 1'b0;       
assign tim2_etb_trig = 1'b0; 

endmodule
module tim3_sec_top_simply(
  etb_tim1_trig_en_off,
  etb_tim1_trig_en_on,
  etb_tim2_trig_en_off,
  etb_tim2_trig_en_on,
  intr,
  paddr,
  pclk,
  penable,
  pprot,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite,
  scan_mode,
  tim1_etb_trig,
  tim2_etb_trig,
  tipc_tim3_trust
);
input           etb_tim1_trig_en_off; 
input           etb_tim1_trig_en_on; 
input           etb_tim2_trig_en_off; 
input           etb_tim2_trig_en_on; 
input   [31:0]  paddr;               
input           pclk;                
input           penable;             
input   [2 :0]  pprot;               
input           presetn;             
input           psel;                
input   [31:0]  pwdata;              
input           pwrite;              
input           scan_mode;           
input           tipc_tim3_trust;     
output  [1 :0]  intr;                
output  [31:0]  prdata;              
output          tim1_etb_trig;       
output          tim2_etb_trig;       
wire            etb_tim1_trig_en_off; 
wire            etb_tim1_trig_en_on; 
wire            etb_tim2_trig_en_off; 
wire            etb_tim2_trig_en_on; 
wire    [31:0]  i_prdata;            
wire            i_psel;              
wire            i_pwrite;            
wire    [1 :0]  intr;                
wire    [31:0]  paddr;               
wire            pclk;                
wire            penable;             
wire    [2 :0]  pprot;               
wire    [31:0]  prdata;              
wire            presetn;             
wire            psel;                
wire    [31:0]  pwdata;              
wire            pwrite;              
wire            scan_mode;           
wire            tim1_etb_trig;       
wire            tim2_etb_trig;       
wire            tipc_tim3_trust;     
assign intr = 2'b0;                
assign prdata = 32'b0;              
assign tim1_etb_trig = 1'b0;       
assign tim2_etb_trig = 1'b0; 

endmodule

module usi2_sec_top_simply(
  clk,
  dma_ack_rx,
  dma_ack_tx,
  dma_req_rx,
  dma_req_tx,
  nss_ie_n,
  nss_in,
  nss_oe_n,
  nss_out,
  paddr,
  penable,
  pprot,
  prdata,
  psel,
  pwdata,
  pwrite,
  rst_n,
  sclk_ie_n,
  sclk_in,
  sclk_oe_n,
  sclk_out,
  sd0_ie_n,
  sd0_in,
  sd0_oe_n,
  sd0_out,
  sd1_ie_n,
  sd1_in,
  sd1_oe_n,
  sd1_out,
  sec_rx_req,
  sec_tx_req,
  tipc_usi2_trust,
  usi_etb_rx_trig,
  usi_etb_tx_trig,
  usi_intr
);
input           clk;            
input           dma_ack_rx;     
input           dma_ack_tx;     
input           nss_in;         
input   [31:0]  paddr;          
input           penable;        
input   [2 :0]  pprot;          
input           psel;           
input   [31:0]  pwdata;         
input           pwrite;         
input           rst_n;          
input           sclk_in;        
input           sd0_in;         
input           sd1_in;         
input           tipc_usi2_trust; 
output          dma_req_rx;     
output          dma_req_tx;     
output          nss_ie_n;       
output          nss_oe_n;       
output          nss_out;        
output  [31:0]  prdata;         
output          sclk_ie_n;      
output          sclk_oe_n;      
output          sclk_out;       
output          sd0_ie_n;       
output          sd0_oe_n;       
output          sd0_out;        
output          sd1_ie_n;       
output          sd1_oe_n;       
output          sd1_out;        
output          sec_rx_req;     
output          sec_tx_req;     
output          usi_etb_rx_trig; 
output          usi_etb_tx_trig; 
output          usi_intr;       
wire            clk;            
wire            dma_ack_rx;     
wire            dma_ack_tx;     
wire            dma_req_rx;     
wire            dma_req_tx;     
wire    [31:0]  i_prdata;       
wire            i_psel;         
wire            i_pwrite;       
wire            nss_ie_n;       
wire            nss_in;         
wire            nss_oe_n;       
wire            nss_out;        
wire    [31:0]  paddr;          
wire            penable;        
wire    [2 :0]  pprot;          
wire    [31:0]  prdata;         
wire            psel;           
wire    [31:0]  pwdata;         
wire            pwrite;         
wire            rst_n;          
wire            sclk_ie_n;      
wire            sclk_in;        
wire            sclk_oe_n;      
wire            sclk_out;       
wire            sd0_ie_n;       
wire            sd0_in;         
wire            sd0_oe_n;       
wire            sd0_out;        
wire            sd1_ie_n;       
wire            sd1_in;         
wire            sd1_oe_n;       
wire            sd1_out;        
wire            sec_rx_req;     
wire            sec_tx_req;     
wire            tipc_usi2_trust; 
wire            usi_etb_rx_trig; 
wire            usi_etb_tx_trig; 
wire            usi_intr;       

assign prdata[31:0] = 32'b0;

assign dma_req_rx = 1'b0;     
assign dma_req_tx = 1'b0; 
assign nss_ie_n = 1'b0 ;       
assign nss_oe_n = 1'b0;       
assign nss_out = 1'b0;        
        
assign sclk_ie_n = 1'b0;      
assign sclk_oe_n = 1'b0;      
assign sclk_out = 1'b0;       
assign sd0_ie_n = 1'b0;       
assign sd0_oe_n = 1'b0;       
assign sd0_out = 1'b0;        
assign sd1_ie_n = 1'b0;       
assign sd1_oe_n = 1'b0;       
assign sd1_out = 1'b0;        
assign sec_rx_req = 1'b0;     
assign sec_tx_req = 1'b0;     
assign usi_etb_rx_trig = 1'b0; 
assign usi_etb_tx_trig = 1'b0; 
assign usi_intr = 1'b0;

endmodule

module dmac_top_simply(
  ch0_etb_evtdone,
  ch0_etb_htfrdone,
  ch0_etb_tfrdone,
  ch0_prot_out,
  ch10_etb_evtdone,
  ch10_etb_htfrdone,
  ch10_etb_tfrdone,
  ch10_prot_out,
  ch11_etb_evtdone,
  ch11_etb_htfrdone,
  ch11_etb_tfrdone,
  ch11_prot_out,
  ch12_etb_evtdone,
  ch12_etb_htfrdone,
  ch12_etb_tfrdone,
  ch12_prot_out,
  ch13_etb_evtdone,
  ch13_etb_htfrdone,
  ch13_etb_tfrdone,
  ch13_prot_out,
  ch14_etb_evtdone,
  ch14_etb_htfrdone,
  ch14_etb_tfrdone,
  ch14_prot_out,
  ch15_etb_evtdone,
  ch15_etb_htfrdone,
  ch15_etb_tfrdone,
  ch15_prot_out,
  ch1_etb_evtdone,
  ch1_etb_htfrdone,
  ch1_etb_tfrdone,
  ch1_prot_out,
  ch2_etb_evtdone,
  ch2_etb_htfrdone,
  ch2_etb_tfrdone,
  ch2_prot_out,
  ch3_etb_evtdone,
  ch3_etb_htfrdone,
  ch3_etb_tfrdone,
  ch3_prot_out,
  ch4_etb_evtdone,
  ch4_etb_htfrdone,
  ch4_etb_tfrdone,
  ch4_prot_out,
  ch5_etb_evtdone,
  ch5_etb_htfrdone,
  ch5_etb_tfrdone,
  ch5_prot_out,
  ch6_etb_evtdone,
  ch6_etb_htfrdone,
  ch6_etb_tfrdone,
  ch6_prot_out,
  ch7_etb_evtdone,
  ch7_etb_htfrdone,
  ch7_etb_tfrdone,
  ch7_prot_out,
  ch8_etb_evtdone,
  ch8_etb_htfrdone,
  ch8_etb_tfrdone,
  ch8_prot_out,
  ch9_etb_evtdone,
  ch9_etb_htfrdone,
  ch9_etb_tfrdone,
  ch9_prot_out,
  dmac_vic_if,
  etb_dmacch0_trg,
  etb_dmacch10_trg,
  etb_dmacch11_trg,
  etb_dmacch12_trg,
  etb_dmacch13_trg,
  etb_dmacch14_trg,
  etb_dmacch15_trg,
  etb_dmacch1_trg,
  etb_dmacch2_trg,
  etb_dmacch3_trg,
  etb_dmacch4_trg,
  etb_dmacch5_trg,
  etb_dmacch6_trg,
  etb_dmacch7_trg,
  etb_dmacch8_trg,
  etb_dmacch9_trg,
  hclk,
  hrst_n,
  m_haddr,
  m_hburst,
  m_hbusreq,
  m_hgrant,
  m_hlock,
  m_hprot,
  m_hrdata,
  m_hready,
  m_hresp,
  m_hsize,
  m_htrans,
  m_hwdata,
  m_hwrite,
  s_haddr,
  s_hprot,
  s_hrdata,
  s_hready,
  s_hresp,
  s_hsel,
  s_htrans,
  s_hwdata,
  s_hwrite
);
input           etb_dmacch0_trg;           
input           etb_dmacch10_trg;          
input           etb_dmacch11_trg;          
input           etb_dmacch12_trg;          
input           etb_dmacch13_trg;          
input           etb_dmacch14_trg;          
input           etb_dmacch15_trg;          
input           etb_dmacch1_trg;           
input           etb_dmacch2_trg;           
input           etb_dmacch3_trg;           
input           etb_dmacch4_trg;           
input           etb_dmacch5_trg;           
input           etb_dmacch6_trg;           
input           etb_dmacch7_trg;           
input           etb_dmacch8_trg;           
input           etb_dmacch9_trg;           
input           hclk;                      
input           hrst_n;                    
input           m_hgrant;                  
input   [31:0]  m_hrdata;                  
input           m_hready;                  
input   [1 :0]  m_hresp;                   
input   [31:0]  s_haddr;                   
input   [3 :0]  s_hprot;                   
input           s_hsel;                    
input   [1 :0]  s_htrans;                  
input   [31:0]  s_hwdata;                  
input           s_hwrite;                  
output          ch0_etb_evtdone;           
output          ch0_etb_htfrdone;          
output          ch0_etb_tfrdone;           
output          ch0_prot_out;              
output          ch10_etb_evtdone;          
output          ch10_etb_htfrdone;         
output          ch10_etb_tfrdone;          
output          ch10_prot_out;             
output          ch11_etb_evtdone;          
output          ch11_etb_htfrdone;         
output          ch11_etb_tfrdone;          
output          ch11_prot_out;             
output          ch12_etb_evtdone;          
output          ch12_etb_htfrdone;         
output          ch12_etb_tfrdone;          
output          ch12_prot_out;             
output          ch13_etb_evtdone;          
output          ch13_etb_htfrdone;         
output          ch13_etb_tfrdone;          
output          ch13_prot_out;             
output          ch14_etb_evtdone;          
output          ch14_etb_htfrdone;         
output          ch14_etb_tfrdone;          
output          ch14_prot_out;             
output          ch15_etb_evtdone;          
output          ch15_etb_htfrdone;         
output          ch15_etb_tfrdone;          
output          ch15_prot_out;             
output          ch1_etb_evtdone;           
output          ch1_etb_htfrdone;          
output          ch1_etb_tfrdone;           
output          ch1_prot_out;              
output          ch2_etb_evtdone;           
output          ch2_etb_htfrdone;          
output          ch2_etb_tfrdone;           
output          ch2_prot_out;              
output          ch3_etb_evtdone;           
output          ch3_etb_htfrdone;          
output          ch3_etb_tfrdone;           
output          ch3_prot_out;              
output          ch4_etb_evtdone;           
output          ch4_etb_htfrdone;          
output          ch4_etb_tfrdone;           
output          ch4_prot_out;              
output          ch5_etb_evtdone;           
output          ch5_etb_htfrdone;          
output          ch5_etb_tfrdone;           
output          ch5_prot_out;              
output          ch6_etb_evtdone;           
output          ch6_etb_htfrdone;          
output          ch6_etb_tfrdone;           
output          ch6_prot_out;              
output          ch7_etb_evtdone;           
output          ch7_etb_htfrdone;          
output          ch7_etb_tfrdone;           
output          ch7_prot_out;              
output          ch8_etb_evtdone;           
output          ch8_etb_htfrdone;          
output          ch8_etb_tfrdone;           
output          ch8_prot_out;              
output          ch9_etb_evtdone;           
output          ch9_etb_htfrdone;          
output          ch9_etb_tfrdone;           
output          ch9_prot_out;              
output          dmac_vic_if;               
output  [31:0]  m_haddr;                   
output  [2 :0]  m_hburst;                  
output          m_hbusreq;                 
output          m_hlock;                   
output  [3 :0]  m_hprot;                   
output  [2 :0]  m_hsize;                   
output  [1 :0]  m_htrans;                  
output  [31:0]  m_hwdata;                  
output          m_hwrite;                  
output  [31:0]  s_hrdata;                  
output          s_hready;                  
output  [1 :0]  s_hresp;                   
wire            arb_bmux_transvld;         
wire            arb_bmux_trgvld;           
wire    [15:0]  busy_chn_code;             
wire            ch0_etb_evtdone;           
wire            ch0_etb_htfrdone;          
wire            ch0_etb_tfrdone;           
wire            ch0_prot_out;              
wire            ch0c_gbc_chbsy;            
wire            ch0c_gbc_chnen;            
wire            ch0c_gbc_sfwtrg;           
wire            ch0c_gbc_trgclr;           
wire            ch0chgen;                  
wire            ch10_etb_evtdone;          
wire            ch10_etb_htfrdone;         
wire            ch10_etb_tfrdone;          
wire            ch10_prot_out;             
wire            ch10c_gbc_chbsy;           
wire            ch10c_gbc_chnen;           
wire            ch10c_gbc_sfwtrg;          
wire            ch10c_gbc_trgclr;          
wire            ch10chgen;                 
wire            ch11_etb_evtdone;          
wire            ch11_etb_htfrdone;         
wire            ch11_etb_tfrdone;          
wire            ch11_prot_out;             
wire            ch11c_gbc_chbsy;           
wire            ch11c_gbc_chnen;           
wire            ch11c_gbc_sfwtrg;          
wire            ch11c_gbc_trgclr;          
wire            ch11chgen;                 
wire            ch12_etb_evtdone;          
wire            ch12_etb_htfrdone;         
wire            ch12_etb_tfrdone;          
wire            ch12_prot_out;             
wire            ch12c_gbc_chbsy;           
wire            ch12c_gbc_chnen;           
wire            ch12c_gbc_sfwtrg;          
wire            ch12c_gbc_trgclr;          
wire            ch12chgen;                 
wire            ch13_etb_evtdone;          
wire            ch13_etb_htfrdone;         
wire            ch13_etb_tfrdone;          
wire            ch13_prot_out;             
wire            ch13c_gbc_chbsy;           
wire            ch13c_gbc_chnen;           
wire            ch13c_gbc_sfwtrg;          
wire            ch13c_gbc_trgclr;          
wire            ch13chgen;                 
wire            ch14_etb_evtdone;          
wire            ch14_etb_htfrdone;         
wire            ch14_etb_tfrdone;          
wire            ch14_prot_out;             
wire            ch14c_gbc_chbsy;           
wire            ch14c_gbc_chnen;           
wire            ch14c_gbc_sfwtrg;          
wire            ch14c_gbc_trgclr;          
wire            ch14chgen;                 
wire            ch15_etb_evtdone;          
wire            ch15_etb_htfrdone;         
wire            ch15_etb_tfrdone;          
wire            ch15_prot_out;             
wire            ch15c_gbc_chbsy;           
wire            ch15c_gbc_chnen;           
wire            ch15c_gbc_sfwtrg;          
wire            ch15c_gbc_trgclr;          
wire            ch15chgen;                 
wire            ch1_etb_evtdone;           
wire            ch1_etb_htfrdone;          
wire            ch1_etb_tfrdone;           
wire            ch1_prot_out;              
wire            ch1c_gbc_chbsy;            
wire            ch1c_gbc_chnen;            
wire            ch1c_gbc_sfwtrg;           
wire            ch1c_gbc_trgclr;           
wire            ch1chgen;                  
wire            ch2_etb_evtdone;           
wire            ch2_etb_htfrdone;          
wire            ch2_etb_tfrdone;           
wire            ch2_prot_out;              
wire            ch2c_gbc_chbsy;            
wire            ch2c_gbc_chnen;            
wire            ch2c_gbc_sfwtrg;           
wire            ch2c_gbc_trgclr;           
wire            ch2chgen;                  
wire            ch3_etb_evtdone;           
wire            ch3_etb_htfrdone;          
wire            ch3_etb_tfrdone;           
wire            ch3_prot_out;              
wire            ch3c_gbc_chbsy;            
wire            ch3c_gbc_chnen;            
wire            ch3c_gbc_sfwtrg;           
wire            ch3c_gbc_trgclr;           
wire            ch3chgen;                  
wire            ch4_etb_evtdone;           
wire            ch4_etb_htfrdone;          
wire            ch4_etb_tfrdone;           
wire            ch4_prot_out;              
wire            ch4c_gbc_chbsy;            
wire            ch4c_gbc_chnen;            
wire            ch4c_gbc_sfwtrg;           
wire            ch4c_gbc_trgclr;           
wire            ch4chgen;                  
wire            ch5_etb_evtdone;           
wire            ch5_etb_htfrdone;          
wire            ch5_etb_tfrdone;           
wire            ch5_prot_out;              
wire            ch5c_gbc_chbsy;            
wire            ch5c_gbc_chnen;            
wire            ch5c_gbc_sfwtrg;           
wire            ch5c_gbc_trgclr;           
wire            ch5chgen;                  
wire            ch6_etb_evtdone;           
wire            ch6_etb_htfrdone;          
wire            ch6_etb_tfrdone;           
wire            ch6_prot_out;              
wire            ch6c_gbc_chbsy;            
wire            ch6c_gbc_chnen;            
wire            ch6c_gbc_sfwtrg;           
wire            ch6c_gbc_trgclr;           
wire            ch6chgen;                  
wire            ch7_etb_evtdone;           
wire            ch7_etb_htfrdone;          
wire            ch7_etb_tfrdone;           
wire            ch7_prot_out;              
wire            ch7c_gbc_chbsy;            
wire            ch7c_gbc_chnen;            
wire            ch7c_gbc_sfwtrg;           
wire            ch7c_gbc_trgclr;           
wire            ch7chgen;                  
wire            ch8_etb_evtdone;           
wire            ch8_etb_htfrdone;          
wire            ch8_etb_tfrdone;           
wire            ch8_prot_out;              
wire            ch8c_gbc_chbsy;            
wire            ch8c_gbc_chnen;            
wire            ch8c_gbc_sfwtrg;           
wire            ch8c_gbc_trgclr;           
wire            ch8chgen;                  
wire            ch9_etb_evtdone;           
wire            ch9_etb_htfrdone;          
wire            ch9_etb_tfrdone;           
wire            ch9_prot_out;              
wire            ch9c_gbc_chbsy;            
wire            ch9c_gbc_chnen;            
wire            ch9c_gbc_sfwtrg;           
wire            ch9c_gbc_trgclr;           
wire            ch9chgen;                  
wire    [11:0]  chregc0_fsmc_block_tl;     
wire    [2 :0]  chregc0_fsmc_chintmdc;     
wire    [31:0]  chregc0_fsmc_darn;         
wire            chregc0_fsmc_dgrpaddrc;    
wire    [1 :0]  chregc0_fsmc_dinc;         
wire    [1 :0]  chregc0_fsmc_dst_tr_width; 
wire            chregc0_fsmc_endlan;       
wire    [5 :0]  chregc0_fsmc_group_len;    
wire            chregc0_fsmc_grpmc;        
wire    [3 :0]  chregc0_fsmc_protctl;      
wire    [31:0]  chregc0_fsmc_sarn;         
wire            chregc0_fsmc_sgrpaddrc;    
wire    [1 :0]  chregc0_fsmc_sinc;         
wire    [1 :0]  chregc0_fsmc_src_tr_width; 
wire    [1 :0]  chregc0_fsmc_trgtmdc;      
wire    [11:0]  chregc10_fsmc_block_tl;    
wire    [2 :0]  chregc10_fsmc_chintmdc;    
wire    [31:0]  chregc10_fsmc_darn;        
wire            chregc10_fsmc_dgrpaddrc;   
wire    [1 :0]  chregc10_fsmc_dinc;        
wire    [1 :0]  chregc10_fsmc_dst_tr_width; 
wire            chregc10_fsmc_endlan;      
wire    [5 :0]  chregc10_fsmc_group_len;   
wire            chregc10_fsmc_grpmc;       
wire    [3 :0]  chregc10_fsmc_protctl;     
wire    [31:0]  chregc10_fsmc_sarn;        
wire            chregc10_fsmc_sgrpaddrc;   
wire    [1 :0]  chregc10_fsmc_sinc;        
wire    [1 :0]  chregc10_fsmc_src_tr_width; 
wire    [1 :0]  chregc10_fsmc_trgtmdc;     
wire    [11:0]  chregc11_fsmc_block_tl;    
wire    [2 :0]  chregc11_fsmc_chintmdc;    
wire    [31:0]  chregc11_fsmc_darn;        
wire            chregc11_fsmc_dgrpaddrc;   
wire    [1 :0]  chregc11_fsmc_dinc;        
wire    [1 :0]  chregc11_fsmc_dst_tr_width; 
wire            chregc11_fsmc_endlan;      
wire    [5 :0]  chregc11_fsmc_group_len;   
wire            chregc11_fsmc_grpmc;       
wire    [3 :0]  chregc11_fsmc_protctl;     
wire    [31:0]  chregc11_fsmc_sarn;        
wire            chregc11_fsmc_sgrpaddrc;   
wire    [1 :0]  chregc11_fsmc_sinc;        
wire    [1 :0]  chregc11_fsmc_src_tr_width; 
wire    [1 :0]  chregc11_fsmc_trgtmdc;     
wire    [11:0]  chregc12_fsmc_block_tl;    
wire    [2 :0]  chregc12_fsmc_chintmdc;    
wire    [31:0]  chregc12_fsmc_darn;        
wire            chregc12_fsmc_dgrpaddrc;   
wire    [1 :0]  chregc12_fsmc_dinc;        
wire    [1 :0]  chregc12_fsmc_dst_tr_width; 
wire            chregc12_fsmc_endlan;      
wire    [5 :0]  chregc12_fsmc_group_len;   
wire            chregc12_fsmc_grpmc;       
wire    [3 :0]  chregc12_fsmc_protctl;     
wire    [31:0]  chregc12_fsmc_sarn;        
wire            chregc12_fsmc_sgrpaddrc;   
wire    [1 :0]  chregc12_fsmc_sinc;        
wire    [1 :0]  chregc12_fsmc_src_tr_width; 
wire    [1 :0]  chregc12_fsmc_trgtmdc;     
wire    [11:0]  chregc13_fsmc_block_tl;    
wire    [2 :0]  chregc13_fsmc_chintmdc;    
wire    [31:0]  chregc13_fsmc_darn;        
wire            chregc13_fsmc_dgrpaddrc;   
wire    [1 :0]  chregc13_fsmc_dinc;        
wire    [1 :0]  chregc13_fsmc_dst_tr_width; 
wire            chregc13_fsmc_endlan;      
wire    [5 :0]  chregc13_fsmc_group_len;   
wire            chregc13_fsmc_grpmc;       
wire    [3 :0]  chregc13_fsmc_protctl;     
wire    [31:0]  chregc13_fsmc_sarn;        
wire            chregc13_fsmc_sgrpaddrc;   
wire    [1 :0]  chregc13_fsmc_sinc;        
wire    [1 :0]  chregc13_fsmc_src_tr_width; 
wire    [1 :0]  chregc13_fsmc_trgtmdc;     
wire    [11:0]  chregc14_fsmc_block_tl;    
wire    [2 :0]  chregc14_fsmc_chintmdc;    
wire    [31:0]  chregc14_fsmc_darn;        
wire            chregc14_fsmc_dgrpaddrc;   
wire    [1 :0]  chregc14_fsmc_dinc;        
wire    [1 :0]  chregc14_fsmc_dst_tr_width; 
wire            chregc14_fsmc_endlan;      
wire    [5 :0]  chregc14_fsmc_group_len;   
wire            chregc14_fsmc_grpmc;       
wire    [3 :0]  chregc14_fsmc_protctl;     
wire    [31:0]  chregc14_fsmc_sarn;        
wire            chregc14_fsmc_sgrpaddrc;   
wire    [1 :0]  chregc14_fsmc_sinc;        
wire    [1 :0]  chregc14_fsmc_src_tr_width; 
wire    [1 :0]  chregc14_fsmc_trgtmdc;     
wire    [11:0]  chregc15_fsmc_block_tl;    
wire    [2 :0]  chregc15_fsmc_chintmdc;    
wire    [31:0]  chregc15_fsmc_darn;        
wire            chregc15_fsmc_dgrpaddrc;   
wire    [1 :0]  chregc15_fsmc_dinc;        
wire    [1 :0]  chregc15_fsmc_dst_tr_width; 
wire            chregc15_fsmc_endlan;      
wire    [5 :0]  chregc15_fsmc_group_len;   
wire            chregc15_fsmc_grpmc;       
wire    [3 :0]  chregc15_fsmc_protctl;     
wire    [31:0]  chregc15_fsmc_sarn;        
wire            chregc15_fsmc_sgrpaddrc;   
wire    [1 :0]  chregc15_fsmc_sinc;        
wire    [1 :0]  chregc15_fsmc_src_tr_width; 
wire    [1 :0]  chregc15_fsmc_trgtmdc;     
wire    [11:0]  chregc1_fsmc_block_tl;     
wire    [2 :0]  chregc1_fsmc_chintmdc;     
wire    [31:0]  chregc1_fsmc_darn;         
wire            chregc1_fsmc_dgrpaddrc;    
wire    [1 :0]  chregc1_fsmc_dinc;         
wire    [1 :0]  chregc1_fsmc_dst_tr_width; 
wire            chregc1_fsmc_endlan;       
wire    [5 :0]  chregc1_fsmc_group_len;    
wire            chregc1_fsmc_grpmc;        
wire    [3 :0]  chregc1_fsmc_protctl;      
wire    [31:0]  chregc1_fsmc_sarn;         
wire            chregc1_fsmc_sgrpaddrc;    
wire    [1 :0]  chregc1_fsmc_sinc;         
wire    [1 :0]  chregc1_fsmc_src_tr_width; 
wire    [1 :0]  chregc1_fsmc_trgtmdc;      
wire    [11:0]  chregc2_fsmc_block_tl;     
wire    [2 :0]  chregc2_fsmc_chintmdc;     
wire    [31:0]  chregc2_fsmc_darn;         
wire            chregc2_fsmc_dgrpaddrc;    
wire    [1 :0]  chregc2_fsmc_dinc;         
wire    [1 :0]  chregc2_fsmc_dst_tr_width; 
wire            chregc2_fsmc_endlan;       
wire    [5 :0]  chregc2_fsmc_group_len;    
wire            chregc2_fsmc_grpmc;        
wire    [3 :0]  chregc2_fsmc_protctl;      
wire    [31:0]  chregc2_fsmc_sarn;         
wire            chregc2_fsmc_sgrpaddrc;    
wire    [1 :0]  chregc2_fsmc_sinc;         
wire    [1 :0]  chregc2_fsmc_src_tr_width; 
wire    [1 :0]  chregc2_fsmc_trgtmdc;      
wire    [11:0]  chregc3_fsmc_block_tl;     
wire    [2 :0]  chregc3_fsmc_chintmdc;     
wire    [31:0]  chregc3_fsmc_darn;         
wire            chregc3_fsmc_dgrpaddrc;    
wire    [1 :0]  chregc3_fsmc_dinc;         
wire    [1 :0]  chregc3_fsmc_dst_tr_width; 
wire            chregc3_fsmc_endlan;       
wire    [5 :0]  chregc3_fsmc_group_len;    
wire            chregc3_fsmc_grpmc;        
wire    [3 :0]  chregc3_fsmc_protctl;      
wire    [31:0]  chregc3_fsmc_sarn;         
wire            chregc3_fsmc_sgrpaddrc;    
wire    [1 :0]  chregc3_fsmc_sinc;         
wire    [1 :0]  chregc3_fsmc_src_tr_width; 
wire    [1 :0]  chregc3_fsmc_trgtmdc;      
wire    [11:0]  chregc4_fsmc_block_tl;     
wire    [2 :0]  chregc4_fsmc_chintmdc;     
wire    [31:0]  chregc4_fsmc_darn;         
wire            chregc4_fsmc_dgrpaddrc;    
wire    [1 :0]  chregc4_fsmc_dinc;         
wire    [1 :0]  chregc4_fsmc_dst_tr_width; 
wire            chregc4_fsmc_endlan;       
wire    [5 :0]  chregc4_fsmc_group_len;    
wire            chregc4_fsmc_grpmc;        
wire    [3 :0]  chregc4_fsmc_protctl;      
wire    [31:0]  chregc4_fsmc_sarn;         
wire            chregc4_fsmc_sgrpaddrc;    
wire    [1 :0]  chregc4_fsmc_sinc;         
wire    [1 :0]  chregc4_fsmc_src_tr_width; 
wire    [1 :0]  chregc4_fsmc_trgtmdc;      
wire    [11:0]  chregc5_fsmc_block_tl;     
wire    [2 :0]  chregc5_fsmc_chintmdc;     
wire    [31:0]  chregc5_fsmc_darn;         
wire            chregc5_fsmc_dgrpaddrc;    
wire    [1 :0]  chregc5_fsmc_dinc;         
wire    [1 :0]  chregc5_fsmc_dst_tr_width; 
wire            chregc5_fsmc_endlan;       
wire    [5 :0]  chregc5_fsmc_group_len;    
wire            chregc5_fsmc_grpmc;        
wire    [3 :0]  chregc5_fsmc_protctl;      
wire    [31:0]  chregc5_fsmc_sarn;         
wire            chregc5_fsmc_sgrpaddrc;    
wire    [1 :0]  chregc5_fsmc_sinc;         
wire    [1 :0]  chregc5_fsmc_src_tr_width; 
wire    [1 :0]  chregc5_fsmc_trgtmdc;      
wire    [11:0]  chregc6_fsmc_block_tl;     
wire    [2 :0]  chregc6_fsmc_chintmdc;     
wire    [31:0]  chregc6_fsmc_darn;         
wire            chregc6_fsmc_dgrpaddrc;    
wire    [1 :0]  chregc6_fsmc_dinc;         
wire    [1 :0]  chregc6_fsmc_dst_tr_width; 
wire            chregc6_fsmc_endlan;       
wire    [5 :0]  chregc6_fsmc_group_len;    
wire            chregc6_fsmc_grpmc;        
wire    [3 :0]  chregc6_fsmc_protctl;      
wire    [31:0]  chregc6_fsmc_sarn;         
wire            chregc6_fsmc_sgrpaddrc;    
wire    [1 :0]  chregc6_fsmc_sinc;         
wire    [1 :0]  chregc6_fsmc_src_tr_width; 
wire    [1 :0]  chregc6_fsmc_trgtmdc;      
wire    [11:0]  chregc7_fsmc_block_tl;     
wire    [2 :0]  chregc7_fsmc_chintmdc;     
wire    [31:0]  chregc7_fsmc_darn;         
wire            chregc7_fsmc_dgrpaddrc;    
wire    [1 :0]  chregc7_fsmc_dinc;         
wire    [1 :0]  chregc7_fsmc_dst_tr_width; 
wire            chregc7_fsmc_endlan;       
wire    [5 :0]  chregc7_fsmc_group_len;    
wire            chregc7_fsmc_grpmc;        
wire    [3 :0]  chregc7_fsmc_protctl;      
wire    [31:0]  chregc7_fsmc_sarn;         
wire            chregc7_fsmc_sgrpaddrc;    
wire    [1 :0]  chregc7_fsmc_sinc;         
wire    [1 :0]  chregc7_fsmc_src_tr_width; 
wire    [1 :0]  chregc7_fsmc_trgtmdc;      
wire    [11:0]  chregc8_fsmc_block_tl;     
wire    [2 :0]  chregc8_fsmc_chintmdc;     
wire    [31:0]  chregc8_fsmc_darn;         
wire            chregc8_fsmc_dgrpaddrc;    
wire    [1 :0]  chregc8_fsmc_dinc;         
wire    [1 :0]  chregc8_fsmc_dst_tr_width; 
wire            chregc8_fsmc_endlan;       
wire    [5 :0]  chregc8_fsmc_group_len;    
wire            chregc8_fsmc_grpmc;        
wire    [3 :0]  chregc8_fsmc_protctl;      
wire    [31:0]  chregc8_fsmc_sarn;         
wire            chregc8_fsmc_sgrpaddrc;    
wire    [1 :0]  chregc8_fsmc_sinc;         
wire    [1 :0]  chregc8_fsmc_src_tr_width; 
wire    [1 :0]  chregc8_fsmc_trgtmdc;      
wire    [11:0]  chregc9_fsmc_block_tl;     
wire    [2 :0]  chregc9_fsmc_chintmdc;     
wire    [31:0]  chregc9_fsmc_darn;         
wire            chregc9_fsmc_dgrpaddrc;    
wire    [1 :0]  chregc9_fsmc_dinc;         
wire    [1 :0]  chregc9_fsmc_dst_tr_width; 
wire            chregc9_fsmc_endlan;       
wire    [5 :0]  chregc9_fsmc_group_len;    
wire            chregc9_fsmc_grpmc;        
wire    [3 :0]  chregc9_fsmc_protctl;      
wire    [31:0]  chregc9_fsmc_sarn;         
wire            chregc9_fsmc_sgrpaddrc;    
wire    [1 :0]  chregc9_fsmc_sinc;         
wire    [1 :0]  chregc9_fsmc_src_tr_width; 
wire    [1 :0]  chregc9_fsmc_trgtmdc;      
wire            dmac_vic_if;               
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
wire            fsmc_chregc0_err_vld;      
wire            fsmc_chregc0_htfr_vld;     
wire            fsmc_chregc0_tfr_vld;      
wire            fsmc_chregc0_trgetcmp_vld; 
wire            fsmc_chregc10_err_vld;     
wire            fsmc_chregc10_htfr_vld;    
wire            fsmc_chregc10_tfr_vld;     
wire            fsmc_chregc10_trgetcmp_vld; 
wire            fsmc_chregc11_err_vld;     
wire            fsmc_chregc11_htfr_vld;    
wire            fsmc_chregc11_tfr_vld;     
wire            fsmc_chregc11_trgetcmp_vld; 
wire            fsmc_chregc12_err_vld;     
wire            fsmc_chregc12_htfr_vld;    
wire            fsmc_chregc12_tfr_vld;     
wire            fsmc_chregc12_trgetcmp_vld; 
wire            fsmc_chregc13_err_vld;     
wire            fsmc_chregc13_htfr_vld;    
wire            fsmc_chregc13_tfr_vld;     
wire            fsmc_chregc13_trgetcmp_vld; 
wire            fsmc_chregc14_err_vld;     
wire            fsmc_chregc14_htfr_vld;    
wire            fsmc_chregc14_tfr_vld;     
wire            fsmc_chregc14_trgetcmp_vld; 
wire            fsmc_chregc15_err_vld;     
wire            fsmc_chregc15_htfr_vld;    
wire            fsmc_chregc15_tfr_vld;     
wire            fsmc_chregc15_trgetcmp_vld; 
wire            fsmc_chregc1_err_vld;      
wire            fsmc_chregc1_htfr_vld;     
wire            fsmc_chregc1_tfr_vld;      
wire            fsmc_chregc1_trgetcmp_vld; 
wire            fsmc_chregc2_err_vld;      
wire            fsmc_chregc2_htfr_vld;     
wire            fsmc_chregc2_tfr_vld;      
wire            fsmc_chregc2_trgetcmp_vld; 
wire            fsmc_chregc3_err_vld;      
wire            fsmc_chregc3_htfr_vld;     
wire            fsmc_chregc3_tfr_vld;      
wire            fsmc_chregc3_trgetcmp_vld; 
wire            fsmc_chregc4_err_vld;      
wire            fsmc_chregc4_htfr_vld;     
wire            fsmc_chregc4_tfr_vld;      
wire            fsmc_chregc4_trgetcmp_vld; 
wire            fsmc_chregc5_err_vld;      
wire            fsmc_chregc5_htfr_vld;     
wire            fsmc_chregc5_tfr_vld;      
wire            fsmc_chregc5_trgetcmp_vld; 
wire            fsmc_chregc6_err_vld;      
wire            fsmc_chregc6_htfr_vld;     
wire            fsmc_chregc6_tfr_vld;      
wire            fsmc_chregc6_trgetcmp_vld; 
wire            fsmc_chregc7_err_vld;      
wire            fsmc_chregc7_htfr_vld;     
wire            fsmc_chregc7_tfr_vld;      
wire            fsmc_chregc7_trgetcmp_vld; 
wire            fsmc_chregc8_err_vld;      
wire            fsmc_chregc8_htfr_vld;     
wire            fsmc_chregc8_tfr_vld;      
wire            fsmc_chregc8_trgetcmp_vld; 
wire            fsmc_chregc9_err_vld;      
wire            fsmc_chregc9_htfr_vld;     
wire            fsmc_chregc9_tfr_vld;      
wire            fsmc_chregc9_trgetcmp_vld; 
wire            fsmc_chregc_pdvld_ch0;     
wire            fsmc_chregc_pdvld_ch1;     
wire            fsmc_chregc_pdvld_ch10;    
wire            fsmc_chregc_pdvld_ch11;    
wire            fsmc_chregc_pdvld_ch12;    
wire            fsmc_chregc_pdvld_ch13;    
wire            fsmc_chregc_pdvld_ch14;    
wire            fsmc_chregc_pdvld_ch15;    
wire            fsmc_chregc_pdvld_ch2;     
wire            fsmc_chregc_pdvld_ch3;     
wire            fsmc_chregc_pdvld_ch4;     
wire            fsmc_chregc_pdvld_ch5;     
wire            fsmc_chregc_pdvld_ch6;     
wire            fsmc_chregc_pdvld_ch7;     
wire            fsmc_chregc_pdvld_ch8;     
wire            fsmc_chregc_pdvld_ch9;     
wire            fsmc_regc_ch0en_clr;       
wire            fsmc_regc_ch10en_clr;      
wire            fsmc_regc_ch11en_clr;      
wire            fsmc_regc_ch12en_clr;      
wire            fsmc_regc_ch13en_clr;      
wire            fsmc_regc_ch14en_clr;      
wire            fsmc_regc_ch15en_clr;      
wire            fsmc_regc_ch1en_clr;       
wire            fsmc_regc_ch2en_clr;       
wire            fsmc_regc_ch3en_clr;       
wire            fsmc_regc_ch4en_clr;       
wire            fsmc_regc_ch5en_clr;       
wire            fsmc_regc_ch6en_clr;       
wire            fsmc_regc_ch7en_clr;       
wire            fsmc_regc_ch8en_clr;       
wire            fsmc_regc_ch9en_clr;       
wire            gbc_ch0c_hpreqvld;         
wire            gbc_ch0c_reqvld;           
wire            gbc_ch10c_hpreqvld;        
wire            gbc_ch10c_reqvld;          
wire            gbc_ch11c_hpreqvld;        
wire            gbc_ch11c_reqvld;          
wire            gbc_ch12c_hpreqvld;        
wire            gbc_ch12c_reqvld;          
wire            gbc_ch13c_hpreqvld;        
wire            gbc_ch13c_reqvld;          
wire            gbc_ch14c_hpreqvld;        
wire            gbc_ch14c_reqvld;          
wire            gbc_ch15c_hpreqvld;        
wire            gbc_ch15c_reqvld;          
wire            gbc_ch1c_hpreqvld;         
wire            gbc_ch1c_reqvld;           
wire            gbc_ch2c_hpreqvld;         
wire            gbc_ch2c_reqvld;           
wire            gbc_ch3c_hpreqvld;         
wire            gbc_ch3c_reqvld;           
wire            gbc_ch4c_hpreqvld;         
wire            gbc_ch4c_reqvld;           
wire            gbc_ch5c_hpreqvld;         
wire            gbc_ch5c_reqvld;           
wire            gbc_ch6c_hpreqvld;         
wire            gbc_ch6c_reqvld;           
wire            gbc_ch7c_hpreqvld;         
wire            gbc_ch7c_reqvld;           
wire            gbc_ch8c_hpreqvld;         
wire            gbc_ch8c_reqvld;           
wire            gbc_ch9c_hpreqvld;         
wire            gbc_ch9c_reqvld;           
wire            gbc_chnc_dmacen;           
wire            hclk;                      
wire            hready;                    
wire            hrst_n;                    
wire    [31:0]  m_addr_ch0;                
wire    [31:0]  m_addr_ch1;                
wire    [31:0]  m_addr_ch10;               
wire    [31:0]  m_addr_ch11;               
wire    [31:0]  m_addr_ch12;               
wire    [31:0]  m_addr_ch13;               
wire    [31:0]  m_addr_ch14;               
wire    [31:0]  m_addr_ch15;               
wire    [31:0]  m_addr_ch2;                
wire    [31:0]  m_addr_ch3;                
wire    [31:0]  m_addr_ch4;                
wire    [31:0]  m_addr_ch5;                
wire    [31:0]  m_addr_ch6;                
wire    [31:0]  m_addr_ch7;                
wire    [31:0]  m_addr_ch8;                
wire    [31:0]  m_addr_ch9;                
wire    [31:0]  m_haddr;                   
wire    [2 :0]  m_hburst;                  
wire            m_hbusreq;                 
wire            m_hgrant;                  
wire            m_hlock;                   
wire    [3 :0]  m_hprot;                   
wire    [31:0]  m_hrdata;                  
wire            m_hready;                  
wire    [1 :0]  m_hresp;                   
wire    [2 :0]  m_hsize;                   
wire    [2 :0]  m_hsize_ch0;               
wire    [2 :0]  m_hsize_ch1;               
wire    [2 :0]  m_hsize_ch10;              
wire    [2 :0]  m_hsize_ch11;              
wire    [2 :0]  m_hsize_ch12;              
wire    [2 :0]  m_hsize_ch13;              
wire    [2 :0]  m_hsize_ch14;              
wire    [2 :0]  m_hsize_ch15;              
wire    [2 :0]  m_hsize_ch2;               
wire    [2 :0]  m_hsize_ch3;               
wire    [2 :0]  m_hsize_ch4;               
wire    [2 :0]  m_hsize_ch5;               
wire    [2 :0]  m_hsize_ch6;               
wire    [2 :0]  m_hsize_ch7;               
wire    [2 :0]  m_hsize_ch8;               
wire    [2 :0]  m_hsize_ch9;               
wire    [1 :0]  m_htrans;                  
wire    [31:0]  m_hwdata;                  
wire    [31:0]  m_hwdata_ch0;              
wire    [31:0]  m_hwdata_ch1;              
wire    [31:0]  m_hwdata_ch10;             
wire    [31:0]  m_hwdata_ch11;             
wire    [31:0]  m_hwdata_ch12;             
wire    [31:0]  m_hwdata_ch13;             
wire    [31:0]  m_hwdata_ch14;             
wire    [31:0]  m_hwdata_ch15;             
wire    [31:0]  m_hwdata_ch2;              
wire    [31:0]  m_hwdata_ch3;              
wire    [31:0]  m_hwdata_ch4;              
wire    [31:0]  m_hwdata_ch5;              
wire    [31:0]  m_hwdata_ch6;              
wire    [31:0]  m_hwdata_ch7;              
wire    [31:0]  m_hwdata_ch8;              
wire    [31:0]  m_hwdata_ch9;              
wire            m_hwrite;                  
wire            m_hwrite_ch0;              
wire            m_hwrite_ch1;              
wire            m_hwrite_ch10;             
wire            m_hwrite_ch11;             
wire            m_hwrite_ch12;             
wire            m_hwrite_ch13;             
wire            m_hwrite_ch14;             
wire            m_hwrite_ch15;             
wire            m_hwrite_ch2;              
wire            m_hwrite_ch3;              
wire            m_hwrite_ch4;              
wire            m_hwrite_ch5;              
wire            m_hwrite_ch6;              
wire            m_hwrite_ch7;              
wire            m_hwrite_ch8;              
wire            m_hwrite_ch9;              
wire    [3 :0]  m_prot_ch0;                
wire    [3 :0]  m_prot_ch1;                
wire    [3 :0]  m_prot_ch10;               
wire    [3 :0]  m_prot_ch11;               
wire    [3 :0]  m_prot_ch12;               
wire    [3 :0]  m_prot_ch13;               
wire    [3 :0]  m_prot_ch14;               
wire    [3 :0]  m_prot_ch15;               
wire    [3 :0]  m_prot_ch2;                
wire    [3 :0]  m_prot_ch3;                
wire    [3 :0]  m_prot_ch4;                
wire    [3 :0]  m_prot_ch5;                
wire    [3 :0]  m_prot_ch6;                
wire    [3 :0]  m_prot_ch7;                
wire    [3 :0]  m_prot_ch8;                
wire    [3 :0]  m_prot_ch9;                
wire            regc_fsmc_ch0_srcdtlgc;    
wire            regc_fsmc_ch10_srcdtlgc;   
wire            regc_fsmc_ch11_srcdtlgc;   
wire            regc_fsmc_ch12_srcdtlgc;   
wire            regc_fsmc_ch13_srcdtlgc;   
wire            regc_fsmc_ch14_srcdtlgc;   
wire            regc_fsmc_ch15_srcdtlgc;   
wire            regc_fsmc_ch1_srcdtlgc;    
wire            regc_fsmc_ch2_srcdtlgc;    
wire            regc_fsmc_ch3_srcdtlgc;    
wire            regc_fsmc_ch4_srcdtlgc;    
wire            regc_fsmc_ch5_srcdtlgc;    
wire            regc_fsmc_ch6_srcdtlgc;    
wire            regc_fsmc_ch7_srcdtlgc;    
wire            regc_fsmc_ch8_srcdtlgc;    
wire            regc_fsmc_ch9_srcdtlgc;    
wire    [31:0]  s_haddr;                   
wire    [3 :0]  s_hprot;                   
wire    [31:0]  s_hrdata;                  
wire            s_hready;                  
wire    [1 :0]  s_hresp;                   
wire            s_hsel;                    
wire    [1 :0]  s_htrans;                  
wire    [31:0]  s_hwdata;                  
wire            s_hwrite;                  

assign ch0_etb_evtdone = 1'b0;           
assign ch0_etb_htfrdone = 1'b0;          
assign ch0_etb_tfrdone = 1'b0;           
assign ch0_prot_out = 1'b0;              
assign ch10_etb_evtdone = 1'b0;          
assign ch10_etb_htfrdone = 1'b0;         
assign ch10_etb_tfrdone = 1'b0;          
assign ch10_prot_out = 1'b0;             
assign ch11_etb_evtdone = 1'b0;          
assign ch11_etb_htfrdone = 1'b0;         
assign ch11_etb_tfrdone = 1'b0;          
assign ch11_prot_out = 1'b0;             
assign ch12_etb_evtdone = 1'b0;          
assign ch12_etb_htfrdone = 1'b0;         
assign ch12_etb_tfrdone = 1'b0;          
assign ch12_prot_out = 1'b0;             
assign ch13_etb_evtdone = 1'b0;          
assign ch13_etb_htfrdone = 1'b0;         
assign ch13_etb_tfrdone = 1'b0;          
assign ch13_prot_out = 1'b0;             
assign ch14_etb_evtdone = 1'b0;          
assign ch14_etb_htfrdone = 1'b0;         
assign ch14_etb_tfrdone = 1'b0;          
assign ch14_prot_out = 1'b0;             
assign ch15_etb_evtdone = 1'b0;          
assign ch15_etb_htfrdone = 1'b0;         
assign ch15_etb_tfrdone = 1'b0;          
assign ch15_prot_out = 1'b0;             
assign ch1_etb_evtdone = 1'b0;           
assign ch1_etb_htfrdone = 1'b0;          
assign ch1_etb_tfrdone = 1'b0;           
assign ch1_prot_out = 1'b0;              
assign ch2_etb_evtdone = 1'b0;           
assign ch2_etb_htfrdone = 1'b0;          
assign ch2_etb_tfrdone = 1'b0;           
assign ch2_prot_out = 1'b0;              
assign ch3_etb_evtdone = 1'b0;           
assign ch3_etb_htfrdone = 1'b0;          
assign ch3_etb_tfrdone = 1'b0;           
assign ch3_prot_out = 1'b0;              
assign ch4_etb_evtdone = 1'b0;           
assign ch4_etb_htfrdone = 1'b0;          
assign ch4_etb_tfrdone = 1'b0;           
assign ch4_prot_out = 1'b0;              
assign ch5_etb_evtdone = 1'b0;           
assign ch5_etb_htfrdone = 1'b0;          
assign ch5_etb_tfrdone = 1'b0;           
assign ch5_prot_out = 1'b0;              
assign ch6_etb_evtdone = 1'b0;           
assign ch6_etb_htfrdone = 1'b0;          
assign ch6_etb_tfrdone = 1'b0;           
assign ch6_prot_out = 1'b0;              
assign ch7_etb_evtdone = 1'b0;           
assign ch7_etb_htfrdone = 1'b0;          
assign ch7_etb_tfrdone = 1'b0;           
assign ch7_prot_out = 1'b0;              
assign ch8_etb_evtdone = 1'b0;           
assign ch8_etb_htfrdone = 1'b0;          
assign ch8_etb_tfrdone = 1'b0;           
assign ch8_prot_out = 1'b0;              
assign ch9_etb_evtdone = 1'b0;           
assign ch9_etb_htfrdone = 1'b0;          
assign ch9_etb_tfrdone = 1'b0;           
assign ch9_prot_out = 1'b0;              
assign dmac_vic_if = 1'b0; 

endmodule

module tim1_sec_top_simply(
  etb_tim1_trig_en_off,
  etb_tim1_trig_en_on,
  etb_tim2_trig_en_off,
  etb_tim2_trig_en_on,
  intr,
  paddr,
  pclk,
  penable,
  pprot,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite,
  scan_mode,
  tim1_etb_trig,
  tim2_etb_trig,
  tipc_tim1_trust
);
input           etb_tim1_trig_en_off; 
input           etb_tim1_trig_en_on; 
input           etb_tim2_trig_en_off; 
input           etb_tim2_trig_en_on; 
input   [31:0]  paddr;               
input           pclk;                
input           penable;             
input   [2 :0]  pprot;               
input           presetn;             
input           psel;                
input   [31:0]  pwdata;              
input           pwrite;              
input           scan_mode;           
input           tipc_tim1_trust;     
output  [1 :0]  intr;                
output  [31:0]  prdata;              
output          tim1_etb_trig;       
output          tim2_etb_trig;       
wire            etb_tim1_trig_en_off; 
wire            etb_tim1_trig_en_on; 
wire            etb_tim2_trig_en_off; 
wire            etb_tim2_trig_en_on; 
wire    [31:0]  i_prdata;            
wire            i_psel;              
wire            i_pwrite;            
wire    [1 :0]  intr;                
wire    [31:0]  paddr;               
wire            pclk;                
wire            penable;             
wire    [2 :0]  pprot;               
wire    [31:0]  prdata;              
wire            presetn;             
wire            psel;                
wire    [31:0]  pwdata;              
wire            pwrite;              
wire            scan_mode;           
wire            tim1_etb_trig;       
wire            tim2_etb_trig;       
wire            tipc_tim1_trust;     
assign intr = 2'b0;                
assign prdata = 32'b0;              
assign tim1_etb_trig = 1'b0;       
assign tim2_etb_trig = 1'b0; 
endmodule
module tim2_sec_top_simply(
  etb_tim1_trig_en_off,
  etb_tim1_trig_en_on,
  etb_tim2_trig_en_off,
  etb_tim2_trig_en_on,
  intr,
  paddr,
  pclk,
  penable,
  pprot,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite,
  scan_mode,
  tim1_etb_trig,
  tim2_etb_trig,
  tipc_tim2_trust
);
input           etb_tim1_trig_en_off; 
input           etb_tim1_trig_en_on; 
input           etb_tim2_trig_en_off; 
input           etb_tim2_trig_en_on; 
input   [31:0]  paddr;               
input           pclk;                
input           penable;             
input   [2 :0]  pprot;               
input           presetn;             
input           psel;                
input   [31:0]  pwdata;              
input           pwrite;              
input           scan_mode;           
input           tipc_tim2_trust;     
output  [1 :0]  intr;                
output  [31:0]  prdata;              
output          tim1_etb_trig;       
output          tim2_etb_trig;       
wire            etb_tim1_trig_en_off; 
wire            etb_tim1_trig_en_on; 
wire            etb_tim2_trig_en_off; 
wire            etb_tim2_trig_en_on; 
wire    [31:0]  i_prdata;            
wire            i_psel;              
wire            i_pwrite;            
wire    [1 :0]  intr;                
wire    [31:0]  paddr;               
wire            pclk;                
wire            penable;             
wire    [2 :0]  pprot;               
wire    [31:0]  prdata;              
wire            presetn;             
wire            psel;                
wire    [31:0]  pwdata;              
wire            pwrite;              
wire            scan_mode;           
wire            tim1_etb_trig;       
wire            tim2_etb_trig;       
wire            tipc_tim2_trust;     

assign intr = 2'b0;                
assign prdata = 32'b0;              
assign tim1_etb_trig = 1'b0;       
assign tim2_etb_trig = 1'b0;

endmodule


module tim4_sec_top_simply(
  etb_tim1_trig_en_off,
  etb_tim1_trig_en_on,
  etb_tim2_trig_en_off,
  etb_tim2_trig_en_on,
  intr,
  paddr,
  pclk,
  penable,
  pprot,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite,
  scan_mode,
  tim1_etb_trig,
  tim2_etb_trig,
  tipc_tim4_trust
);
input           etb_tim1_trig_en_off; 
input           etb_tim1_trig_en_on; 
input           etb_tim2_trig_en_off; 
input           etb_tim2_trig_en_on; 
input   [31:0]  paddr;               
input           pclk;                
input           penable;             
input   [2 :0]  pprot;               
input           presetn;             
input           psel;                
input   [31:0]  pwdata;              
input           pwrite;              
input           scan_mode;           
input           tipc_tim4_trust;     
output  [1 :0]  intr;                
output  [31:0]  prdata;              
output          tim1_etb_trig;       
output          tim2_etb_trig;       
wire            etb_tim1_trig_en_off; 
wire            etb_tim1_trig_en_on; 
wire            etb_tim2_trig_en_off; 
wire            etb_tim2_trig_en_on; 
wire    [31:0]  i_prdata;            
wire            i_psel;              
wire            i_pwrite;            
wire    [1 :0]  intr;                
wire    [31:0]  paddr;               
wire            pclk;                
wire            penable;             
wire    [2 :0]  pprot;               
wire    [31:0]  prdata;              
wire            presetn;             
wire            psel;                
wire    [31:0]  pwdata;              
wire            pwrite;              
wire            scan_mode;           
wire            tim1_etb_trig;       
wire            tim2_etb_trig;       
wire            tipc_tim4_trust;     

assign intr = 2'b0;                
assign prdata = 32'b0;              
assign tim1_etb_trig = 1'b0;       
assign tim2_etb_trig = 1'b0; 

endmodule


module tim6_sec_top_simply(
  etb_tim1_trig_en_off,
  etb_tim1_trig_en_on,
  etb_tim2_trig_en_off,
  etb_tim2_trig_en_on,
  intr,
  paddr,
  pclk,
  penable,
  pprot,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite,
  scan_mode,
  tim1_etb_trig,
  tim2_etb_trig,
  tipc_tim6_trust
);
input           etb_tim1_trig_en_off; 
input           etb_tim1_trig_en_on; 
input           etb_tim2_trig_en_off; 
input           etb_tim2_trig_en_on; 
input   [31:0]  paddr;               
input           pclk;                
input           penable;             
input   [2 :0]  pprot;               
input           presetn;             
input           psel;                
input   [31:0]  pwdata;              
input           pwrite;              
input           scan_mode;           
input           tipc_tim6_trust;     
output  [1 :0]  intr;                
output  [31:0]  prdata;              
output          tim1_etb_trig;       
output          tim2_etb_trig;       
wire            etb_tim1_trig_en_off; 
wire            etb_tim1_trig_en_on; 
wire            etb_tim2_trig_en_off; 
wire            etb_tim2_trig_en_on; 
wire    [31:0]  i_prdata;            
wire            i_psel;              
wire            i_pwrite;            
wire    [1 :0]  intr;                
wire    [31:0]  paddr;               
wire            pclk;                
wire            penable;             
wire    [2 :0]  pprot;               
wire    [31:0]  prdata;              
wire            presetn;             
wire            psel;                
wire    [31:0]  pwdata;              
wire            pwrite;              
wire            scan_mode;           
wire            tim1_etb_trig;       
wire            tim2_etb_trig;       
wire            tipc_tim6_trust;     

assign intr = 2'b0;                
assign prdata = 32'b0;              
assign tim1_etb_trig = 1'b0;       
assign tim2_etb_trig = 1'b0;

endmodule

module wdt_sec_top_simply(
  intr,
  paddr,
  pclk,
  penable,
  pprot,
  prdata,
  prst_b,
  psel,
  pwdata,
  pwrite,
  scan_mode,
  sys_rst_b,
  tipc_wdt_trust
);
input   [31:0]  paddr;         
input           pclk;          
input           penable;       
input   [2 :0]  pprot;         
input           prst_b;        
input           psel;          
input   [31:0]  pwdata;        
input           pwrite;        
input           scan_mode;     
input           tipc_wdt_trust; 
output          intr;          
output  [31:0]  prdata;        
output          sys_rst_b;     
wire    [7 :0]  i_paddr;       
wire    [31:0]  i_prdata;      
wire            i_psel;        
wire            i_pwrite;      
wire            intr;          
wire    [31:0]  paddr;         
wire            pclk;          
wire            penable;       
wire    [2 :0]  pprot;         
wire    [31:0]  prdata;        
wire            prst_b;        
wire            psel;          
wire    [31:0]  pwdata;        
wire            pwrite;        
wire            scan_mode;     
wire            sys_rst_b;     
wire            tipc_wdt_trust; 
wire            wdt_int_n;     
wire            wdt_sys_rst;   

assign intr = 0;
assign prdata[31:0] = 0;
assign sys_rst_b = 1;

endmodule

module gpio0_sec_top_simply(
  gpio0_etb_trig,
  gpio_ext_porta,
  gpio_intr_flag,
  gpio_intrclk_en,
  gpio_porta_ddr,
  gpio_porta_dr,
  paddr,
  pclk,
  pclk_intr,
  penable,
  pprot,
  prdata,
  presetn,
  psel,
  pwdata,
  pwrite,
  tipc_gpio0_trust
);
input   [31:0]  gpio_ext_porta;  
input   [31:0]  paddr;           
input           pclk;            
input           pclk_intr;       
input           penable;         
input   [2 :0]  pprot;           
input           presetn;         
input           psel;            
input   [31:0]  pwdata;          
input           pwrite;          
input           tipc_gpio0_trust; 
output  [31:0]  gpio0_etb_trig;  
output          gpio_intr_flag;  
output          gpio_intrclk_en; 
output  [31:0]  gpio_porta_ddr;  
output  [31:0]  gpio_porta_dr;   
output  [31:0]  prdata;          
wire    [31:0]  gpio0_etb_trig;  
wire    [31:0]  gpio_ext_porta;  
wire            gpio_intr_flag;  
wire            gpio_intrclk_en; 
wire    [31:0]  gpio_porta_ddr;  
wire    [31:0]  gpio_porta_dr;   
wire    [31:0]  i_prdata;        
wire            i_psel;          
wire            i_pwrite;        
wire    [31:0]  paddr;           
wire            pclk;            
wire            pclk_intr;       
wire            penable;         
wire    [2 :0]  pprot;           
wire    [31:0]  prdata;          
wire            presetn;         
wire            psel;            
wire    [31:0]  pwdata;          
wire            pwrite;          
wire            tipc_gpio0_trust; 

assign gpio0_etb_trig = 0;  
assign gpio_intr_flag = 0;  
assign gpio_intrclk_en = 0; 
assign gpio_porta_ddr = 0;  
assign gpio_porta_dr = 0;   
assign prdata = 0;         
endmodule