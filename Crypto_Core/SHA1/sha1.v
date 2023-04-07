//======================================================================
//
// sha1.v
// ------
// Top level wrapper for the SHA-1 hash function providing
// a simple memory like interface with 32 bit data access.
//
//
// Author: Joachim Strombergson
// Copyright (c) 2013  Secworks Sweden AB
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

`default_nettype none

module sha1(
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

  input   [31:0]  haddr;
  input       hclk;
  output      hready;
  input       hrst_b;
  input         hsel;
  input   [31:0]  hwdata;
  input         hwrite;
  output  [31:0]  hrdata;
  output        intr;
    output  [1 :0]  hresp;
    input   [3 :0]  hprot; 
    input   [2 :0]  hsize;
    input   [1 :0]  htrans;
  wire  [31:0]  haddr;
  wire        hclk;
  wire      hready;
  wire      hrst_b;
  wire        hsel;
  wire  [31:0]  hwdata;
  wire          hwrite;
  wire  [31:0]  hrdata;
  wire          intr;
    wire    [1 :0]  hresp;
    wire    [3 :0]  hprot; 
    wire    [2 :0]  hsize;
    wire    [1 :0]  htrans;

  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------


  localparam ADDR_CTRL        = 32'h20040000;
  localparam ADDR_STATUS      = 32'h20040004;
  localparam ADDR_BLOCK0      = 32'h20040008;//BLOCK_BASE
  // localparam ADDR_BLOCK1   = 32'h20040014;
  // localparam ADDR_BLOCK2   = 32'h20040018;
  // localparam ADDR_BLOCK3    = 32'h2004001c;
  // localparam ADDR_BLOCK4    = 32'h20040020;
  // localparam ADDR_BLOCK5    = 32'h20040024;
  // localparam ADDR_BLOCK6    = 32'h20040028;
  // localparam ADDR_BLOCK7    = 32'h2004002c;
  // localparam ADDR_BLOCK8    = 32'h20040030;
  // localparam ADDR_BLOCK9    = 32'h20040034;
  // localparam ADDR_BLOCK10    = 32'h20040038;
  // localparam ADDR_BLOCK11    = 32'h2004003c;
  // localparam ADDR_BLOCK12    = 32'h20040040;
  // localparam ADDR_BLOCK13    = 32'h20040044;
  // localparam ADDR_BLOCK14    = 32'h20040048;
  // localparam ADDR_BLOCK15    = 32'h2004004c;//BLOCK_OFFSET

  localparam ADDR_DIGEST0   = 32'h2004000C;//DIGEST_BASE
  localparam ADDR_DIGEST1   = 32'h20040010;
  localparam ADDR_DIGEST2   = 32'h20040014;
  localparam ADDR_DIGEST3   = 32'h20040018;
  localparam ADDR_DIGEST4   = 32'h2004001C;//DIGEST_OFFSET

  localparam ADDR_INTR        = 32'h20040020;

  localparam CTRL_INIT_BIT   = 0;
  localparam CTRL_NEXT_BIT   = 1;
  localparam STATUS_READY_BIT = 0;
  localparam STATUS_VALID_BIT = 1;



  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg init_reg;
  reg init_new;

  reg next_reg;
  reg next_new;

  reg ready_reg;

  reg [31 : 0] block_reg [0 : 15];
  reg          block_we;

  reg [159 : 0] digest_reg;

  reg digest_valid_reg;


  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------
  wire           core_ready;
  wire [511 : 0] core_block;
  wire [159 : 0] core_digest;
  wire           core_digest_valid;

  reg [31 : 0]   tmp_read_data;
  reg            tmp_error;


  //----------------------------------------------------------------
  // Concurrent connectivity for ports etc.
  //----------------------------------------------------------------
  assign core_block = {block_reg[15], block_reg[14], block_reg[13], block_reg[12],
                       block_reg[11], block_reg[10], block_reg[09], block_reg[08],
                       block_reg[07], block_reg[06], block_reg[05], block_reg[04],
                       block_reg[03], block_reg[02], block_reg[01], block_reg[00]};

  // assign read_data = tmp_read_data;
  // assign error     = tmp_error;


  //----------------------------------------------------------------
  // core instantiation.
  //----------------------------------------------------------------
  sha1_core core(
                 .clk(hclk),
                 .reset_n(hrst_b),

                 .init(init_reg),
                 .next(next_reg),

                 .block(core_block),

                 .ready(core_ready),

                 .digest(core_digest),
                 .digest_valid(core_digest_valid)
                );


  //----------------------------------------------------------------
  // reg_update
  // Update functionality for all registers in the core.
  // All registers are positive edge triggered with
  // asynchronous active low reset.
  //----------------------------------------------------------------


reg core_digest_valid_reg;
wire posedge_core_digest_valid;

    always @ (posedge hclk or negedge hrst_b)
    begin
      if (!hrst_b)
        begin
          core_digest_valid_reg  <= 1'b0;
        end
      else
        begin
            core_digest_valid_reg <= core_digest_valid;
        end
    end
    assign posedge_core_digest_valid=!core_digest_valid_reg&&core_digest_valid;


  reg cs;
  reg we;
  reg [31:0] address;

    always @ (posedge hclk or negedge hrst_b)
    begin
      if (!hrst_b)
        begin
          cs  <= 1'b0;
          we         <= 1'b0;
          address <= 1'b0;
        end
      else
        begin
            cs <= hsel;
            we <= hwrite;
            address <= haddr;
        end
    end 


    wire            intr_op;
    reg       intr_op_reg;
    reg       intr_reg;

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
        else if(posedge_core_digest_valid)begin
            intr_reg <= 1;
        end
        else if(intr_op_reg)begin
          intr_reg <= hwdata[0];
        end
    end



  always @ (posedge hclk or negedge hrst_b)
    begin : reg_update
      integer i;

      if (!hrst_b)
        begin
          init_reg         <= 1'h0;
          next_reg         <= 1'h0;
          ready_reg        <= 1'h0;
          digest_reg       <= 160'h0;
          digest_valid_reg <= 1'h0;

          // for (i = 0 ; i < 16 ; i = i + 1)
          //   block_reg[i] <= 32'h0;
        end
      else
        begin
          ready_reg        <= core_ready;
          digest_valid_reg <= core_digest_valid;
          init_reg         <= init_new;
          next_reg         <= next_new;

          // if (block_we)
          //   block_reg[(address-ADDR_BLOCK0)>>2] <= hwdata;

          if (core_digest_valid)
            digest_reg <= core_digest;
        end
    end // reg_update

  reg [31:0] block_reg_addr;
  reg        block_reg_config_valid;

  always@(posedge hclk or negedge hrst_b)begin
      if(!hrst_b)begin
          block_reg_config_valid <= 0;
      end
      else if(haddr == ADDR_BLOCK0 && hsel && hwrite)begin
          block_reg_config_valid <= 1;
      end
      else begin
          block_reg_config_valid <= 0;
      end
  end

  always@(posedge hclk or negedge hrst_b)begin
      if(!hrst_b)begin
          block_reg_addr <= 0;
      end
      else if(block_reg_config_valid)begin
          if(block_reg_addr == 15)begin
              block_reg_addr <= 0;
          end
          else begin
              block_reg_addr <= block_reg_addr + 1;
          end
      end
  end

  always@(posedge hclk or negedge hrst_b)begin
      if(!hrst_b)begin
          
      end
      else if(block_reg_config_valid)begin
          block_reg[block_reg_addr] <= hwdata;
      end
  end

  //----------------------------------------------------------------
  // api
  //
  // The interface command decoding logic.
  //----------------------------------------------------------------
  always @*
    begin : api
      init_new      = 1'h0;
      next_new      = 1'h0;
      block_we      = 1'h0;
      tmp_read_data = 32'h0;
      tmp_error     = 1'h0;

      if (cs)
        begin
          if (we)
            begin
              // if ((address >= ADDR_BLOCK0) && (address <= ADDR_BLOCK15))
              //   block_we = 1'h1;

              if (address == ADDR_CTRL)
                begin
                  init_new = hwdata[CTRL_INIT_BIT];
                  next_new = hwdata[CTRL_NEXT_BIT];
                end
            end // if (write_read)
          else
            begin
              // if ((address >= ADDR_BLOCK0) && (address <= ADDR_BLOCK15))
              //   tmp_read_data = block_reg[(address-ADDR_BLOCK0)>>2];

              if ((address >= ADDR_DIGEST0) && (address <= ADDR_DIGEST4))
                tmp_read_data = digest_reg[((address - ADDR_DIGEST0)>>2) * 32 +: 32];

              case (address)
                // Read operations.
                ADDR_CTRL:
                  tmp_read_data = {30'h0, next_reg, init_reg};

                ADDR_STATUS:
                  tmp_read_data = {30'h0, digest_valid_reg, ready_reg};

                default:
                  begin
                    tmp_error = 1'h1;
                  end
              endcase // case (addr)
            end
        end
    end // addr_decoder

    assign hready       = 1;
    assign hresp      = 2'b00;
    assign hrdata       = tmp_read_data;
endmodule // sha1

//======================================================================
// EOF sha1.v
//======================================================================
