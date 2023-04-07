//======================================================================
//
// cbc.v
// -----
// CBC block cipher mode of operation for AES. The implementation
// matches the specification in NIST SP 800-38A.
//
//
// Author: Joachim Strombergson
// Copyright (c) 2018, Assured AB
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or
// without modification, are permitted provided that the following
// conditions are met:
//
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in
//    the documentation and/or other materials provided with the
//    distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
// COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//======================================================================

module ahb_aes_top(
	haddr,
	hclk,
	hprot,//
	hrdata,
	hready,
	hresp,
	hrst_b,
	hsel,
	hsize,//
	htrans,//
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

  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------

////////////Register
  localparam ADDR_INIT_KEY_BUSY    = 32'h20030000;
  localparam ADDR_CONFIG           = 32'h20030004;
  localparam ADDR_CTRL             = 32'h20030008;
  localparam ADDR_STATUS           = 32'h2003000c;
  localparam ADDR_KEY0             = 32'h20030010;//KEY地址低八位不能改，KEY_BASE
  // localparam ADDR_KEY1        = 32'h20030014;
  // localparam ADDR_KEY2        = 32'h20030018;
  // localparam ADDR_KEY3        = 32'h2003001c;
  // localparam ADDR_KEY4        = 32'h20030020;
  // localparam ADDR_KEY5        = 32'h20030024;
  // localparam ADDR_KEY6        = 32'h20030028;
  // localparam ADDR_KEY7        = 32'h2003002c;//KEY_OFFSET

  localparam ADDR_BLOCK0      = 32'h20030014;//BLOCK地址低八位不能改,BLOCK_BASE
  localparam ADDR_BLOCK1      = 32'h20030018;
  localparam ADDR_BLOCK2      = 32'h2003001C;
  localparam ADDR_BLOCK3      = 32'h20030020;//BLOCK_OFFSET

  localparam ADDR_IV0         = 32'h20030024;//IV地址低八位不能改,IV_BASE
  localparam ADDR_IV1         = 32'h20030028;
  localparam ADDR_IV2         = 32'h2003002C;
  localparam ADDR_IV3         = 32'h20030030;//IV_OFFSET

  localparam ADDR_INTR        = 32'h20030034;
  localparam ADDR_READ_INTR   = 32'h20030038;

  localparam ADDR_RESULT0     = 32'h20030040;//RESULT地址低八位不能改,RESULT_BASE
  localparam ADDR_RESULT1     = 32'h20030044;
  localparam ADDR_RESULT2     = 32'h20030048;
  localparam ADDR_RESULT3     = 32'h2003004c;//RESULT_OFFSET

  localparam CTRL_INIT_BIT    = 0;
  localparam CTRL_NEXT_BIT    = 1;
  localparam CTRL_CBC_BIT     = 2;
  localparam STATUS_READY_BIT = 0;
  localparam STATUS_VALID_BIT = 1;
  localparam CTRL_ENCDEC_BIT  = 0;
  localparam CTRL_KEYLEN_BIT  = 1;
  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg init_reg;
  reg init_new;

  reg next_reg;
  reg next_new;
  
  reg cbc_reg;
  reg cbc_new;

  reg init;
  reg next;
  reg cbc;

  reg encdec_reg;
  reg keylen_reg;
  reg config_we;

  reg [31 : 0] iv_reg [0 : 3];
  reg          iv_we;
  reg          load_iv;

  reg [31 : 0] block_reg [0 : 3];
  reg          block_we;

  reg [31 : 0] key_reg [0 : 7];
  reg          key_we;

  reg [127 : 0] result_reg;
  reg           valid_reg;
  reg           ready_reg;

  reg cs;
  reg we;
  reg [31:0] Address;
  reg core_ready_reg;
  reg core_valid_reg;
  wire posedge_core_ready;
  wire posedge_core_valid;
  wire init_intr;
  wire next_intr;
  reg  intr_reg;
  reg [31 : 0]   tmp_read_data;

  wire           core_encdec;
  wire           core_init;
  wire           core_next;
  wire           core_ready;
  wire [255 : 0] core_key;
  wire           core_keylen;
  wire [127 : 0] core_block;
  wire [127 : 0] core_result;
  wire           core_valid;

    always @ (posedge hclk or negedge hrst_b)
    begin
      if (!hrst_b)
        begin
          cs  <= 1'b0;
          we         <= 1'b0;
          Address <= 1'b0;
        end
      else
        begin
            cs <= hsel;
            we <= hwrite;
            Address <= haddr;
        end
    end 

    always @ (posedge hclk or negedge hrst_b)
    begin
      if (!hrst_b)
        begin
          init  <= 1'b0;
          next         <= 1'b0;
          cbc <= 1'b0;
        end
      else
        begin
            init <= init_reg;
            next <= next_reg;
            cbc <= cbc_reg;
        end
    end


//////////////intr////////////////////////////////////////



assign init_intr=posedge_core_ready&&(!posedge_core_valid);
assign next_intr=posedge_core_ready&&posedge_core_valid;

    always @ (posedge hclk or negedge hrst_b)
    begin
      if (!hrst_b)
        begin
          core_ready_reg  <= 1'b1;
        end
      else
        begin
            core_ready_reg <= core_ready;
        end
    end

    always @ (posedge hclk or negedge hrst_b)
    begin
      if (!hrst_b)
        begin
          core_valid_reg  <= 1'b0;
        end
      else
        begin
            core_valid_reg <= core_valid;
        end
    end

    assign posedge_core_ready=!core_ready_reg&&core_ready;
    assign posedge_core_valid=!core_valid_reg&&core_valid;

    wire            intr_op;
    reg				intr_op_reg;
    wire            read_init_key_busy;
    reg             read_init_key_busy_reg;
    assign read_init_key_busy  = (hwrite == 1'b0) && (hsel == 1'b1) && (haddr == ADDR_INIT_KEY_BUSY);

    always @(posedge hclk or negedge hrst_b) begin
        if(!hrst_b) begin
            read_init_key_busy_reg <= 0;
        end
        else if(read_init_key_busy)  begin
            read_init_key_busy_reg <= read_init_key_busy;
        end
		else begin
		    read_init_key_busy_reg <= 0;	
		end

    end


    assign intr_op  = (hwrite == 1'b1) && (hsel == 1'b1) && (haddr == ADDR_INTR);
    assign intr = intr_reg;

    always @(posedge hclk or negedge hrst_b) begin
        if(!hrst_b) begin
            intr_op_reg <= 0;
        end
        else if(intr_op)  begin
            intr_op_reg <= intr_op;
        end
        else begin
            intr_op_reg <= 0;	
        end
    end


    always @(posedge hclk or negedge hrst_b) begin
        if(!hrst_b) begin
            intr_reg <= 0;
        end
        else if(next_intr)begin
            intr_reg <= 1;
        end
        else if(intr_op_reg)begin
        	intr_reg <= hwdata[0];
        end
    end

    reg [31:0] init_key_busy;
    always @(posedge hclk or negedge hrst_b) begin
        if(!hrst_b) begin
            init_key_busy <= {31'b0,1'b0};
        end
        else if(init_new)begin
            init_key_busy<={31'b0,1'b1};
        end
        else if(init_intr)begin
            init_key_busy <= {31'b0,1'b0};
        end
        else begin
        	init_key_busy <= init_key_busy;
        end
    end
//////////////////////INTR///////////////////////////////

  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------
  //----------------------------------------------------------------
  // Concurrent connectivity for ports etc.
  //----------------------------------------------------------------
  // assign read_data = tmp_read_data;

  assign core_key = {key_reg[7], key_reg[6], key_reg[5], key_reg[4],
                     key_reg[3], key_reg[2], key_reg[1], key_reg[0]};



  assign core_block  = (cbc||cbc_reg)?
  {(block_reg[0] ^ iv_reg[0]), (block_reg[1] ^ iv_reg[1]),(block_reg[2] ^ iv_reg[2]), (block_reg[3] ^ iv_reg[3])}:
                        {(block_reg[0] ), (block_reg[1]),(block_reg[2] ), (block_reg[3] )};

// assign core_block  = 
//   {(block_reg[0] ^ iv_reg[0]), (block_reg[1] ^ iv_reg[1]),(block_reg[2] ^ iv_reg[2]), (block_reg[3] ^ iv_reg[3])};

  assign core_init   = init||init_reg;
  assign core_next   = next||next_reg;
  assign core_encdec = encdec_reg;
  assign core_keylen = keylen_reg;


  //----------------------------------------------------------------
  // core instantiation.
  //----------------------------------------------------------------
  aes_core core(
                .clk(hclk),
                .reset_n(hrst_b),

                .encdec(core_encdec),
                .init(core_init),
                .next(core_next),
                .ready(core_ready),

                .key(core_key),
                .keylen(core_keylen),

                .block(core_block),
                .result(core_result),
                .result_valid(core_valid)
               );


  //----------------------------------------------------------------
  // reg_update
  // Update functionality for all registers in the core.
  // All registers are positive edge triggered with asynchronous
  // active low reset.
  //----------------------------------------------------------------
  always @ (posedge hclk or negedge hrst_b)
    begin : reg_update
      integer i;

      if (!hrst_b)
        begin
          for (i = 0 ; i < 4 ; i = i + 1)
            begin
              iv_reg[i]    <= 32'h0;
              block_reg[i] <= 32'h0;
            end

          // for (i = 0 ; i < 8 ; i = i + 1)
          //   key_reg[i] <= 32'h0;

          init_reg   <= 1'b0;
          next_reg   <= 1'b0;
          cbc_reg    <= 1'b0;
          encdec_reg <= 1'b0;
          keylen_reg <= 1'b0;
          result_reg <= 128'h0;
          valid_reg  <= 1'b0;
          ready_reg  <= 1'b0;
        end
      else
        begin
          ready_reg  <= core_ready;
          valid_reg  <= core_valid;
          result_reg <= core_result;
          init_reg   <= init_new;
          next_reg   <= next_new;
          cbc_reg    <= cbc_new;

          if (config_we)
            begin
              encdec_reg <= hwdata[CTRL_ENCDEC_BIT];
              keylen_reg <= hwdata[CTRL_KEYLEN_BIT];
            end

          // if (key_we)
          //   key_reg[(Address-ADDR_KEY0)>>2] <= hwdata;

          if (iv_we)
            begin
              if (load_iv)
                iv_reg[3-((Address-ADDR_IV0)>>2)] <= hwdata;
              else
                begin
                  iv_reg[0] <= core_result[127 : 096];
                  iv_reg[1] <= core_result[095 : 064];
                  iv_reg[2] <= core_result[063 : 032];
                  iv_reg[3] <= core_result[031 : 000];
                end
            end

          if (block_we)
            block_reg[3-((Address-ADDR_BLOCK0)>>2)] <= hwdata;
        end
    end // reg_update


  reg [31:0] key_reg_addr;
  reg        key_config_valid;

  always@(posedge hclk or negedge hrst_b)begin
      if(!hrst_b)begin
          key_config_valid <= 0;
      end
      else if(haddr == ADDR_KEY0 && hsel && hwrite)begin
          key_config_valid <= 1;
      end
      else begin
          key_config_valid <= 0;
      end
  end

  always@(posedge hclk or negedge hrst_b)begin
      if(!hrst_b)begin
          key_reg_addr <= 0;
      end
      else if(key_config_valid)begin
          if(key_reg_addr == 7)begin
              key_reg_addr <= 0;
          end
          else begin
              key_reg_addr <= key_reg_addr + 1;
          end
      end
  end

  always@(posedge hclk or negedge hrst_b)begin
      if(!hrst_b)begin
          
      end
      else if(key_config_valid)begin
          key_reg[key_reg_addr] <= hwdata;
      end
  end
  //----------------------------------------------------------------
  // api
  //
  // The interface command decoding logic.
  //----------------------------------------------------------------
  always @*
    begin : api
      init_new      = 1'b0;
      next_new      = 1'b0;
      cbc_new       = 1'b0;
      config_we     = 1'b0;
      key_we        = 1'b0;
      block_we      = 1'b0;
      tmp_read_data = 32'h0;

      load_iv       = 1'b0;
      iv_we         = core_valid;

      if (cs)
        begin
          if (we)
            begin
              if (Address == ADDR_CTRL)
                begin
                  init_new = hwdata[CTRL_INIT_BIT];//0
                  next_new = hwdata[CTRL_NEXT_BIT];//1
                  cbc_new  = hwdata[CTRL_CBC_BIT];//2
                end

              if (Address == ADDR_CONFIG)
                config_we = 1'b1;

              // if ((Address >= ADDR_KEY0) && (Address <= ADDR_KEY7))
              //   key_we = 1'b1;

              if ((Address >= ADDR_IV0) && (Address <= ADDR_IV3))
                begin
                  load_iv = 1'b1;
                  iv_we   = 1'b1;
                end

              if ((Address >= ADDR_BLOCK0) && (Address <= ADDR_BLOCK3))
                block_we = 1'b1;
            end // if (we)

          else
            begin
              case (Address)
                ADDR_CTRL:    tmp_read_data = {28'h0, keylen_reg, encdec_reg, next_reg, init_reg};
                ADDR_STATUS:  tmp_read_data = {30'h0, valid_reg, ready_reg};
                ADDR_READ_INTR : tmp_read_data = {31'b0, intr_reg};
                default:
                  begin
                  end
              endcase // case (Address)

              if ((Address >= ADDR_RESULT0) && (Address <= ADDR_RESULT3))
                  tmp_read_data = result_reg[(((Address-ADDR_RESULT0)>>2)) * 32 +: 32];
            end
        end
    end // addr_decoder





    assign hready 			= 1;
    assign hresp 			= 2'b00;
    assign hrdata   		= read_init_key_busy_reg?init_key_busy:tmp_read_data;
endmodule // cbc

//======================================================================
// EOF cbc.v
//======================================================================
