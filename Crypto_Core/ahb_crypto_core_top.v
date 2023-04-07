`define RSA_BASE_ADDR 32'h20020000
`define AES_BASE_ADDR 32'h20030000
`define SHA_BASE_ADDR 32'h20040000

`define RSA_OFFSET	  32'h2002FFFF
`define AES_OFFSET    32'h2003FFFF
`define SHA_OFFSET    32'h2004FFFF

module ahb_crypto_core_top(
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
	RSA_Interrupt,
	AES_Interrupt,
	SHA_Interrupt

    );

	input 	[31:0] 	haddr;
	input   	 	hclk;
	output 		 	hready;
	input 		 	hrst_b;
	input 	     	hsel;
	input 	[31:0] 	hwdata;
	input        	hwrite;
	output	[31:0] 	hrdata;
	output       	RSA_Interrupt;
	output 			AES_Interrupt;
	output    		SHA_Interrupt;

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
	wire       		RSA_Interrupt;
	wire			AES_Interrupt;
    wire  	[1 :0] 	hresp;
    wire   	[3 :0]  hprot; 
    wire   	[2 :0]  hsize;
    wire   	[1 :0]  htrans;

    wire 			hsel_rsa;
    wire 			hsel_aes;
    wire 			hsel_sha;
    reg  			hsel_rsa_reg;
    reg  			hsel_aes_reg;
    reg  			hsel_sha_reg;

    wire 	[31:0] 	hrdata_rsa;
    wire 	[31:0]	hrdata_aes;
    wire 	[31:0]	hrdata_sha;

    assign hsel_rsa = (haddr >= `RSA_BASE_ADDR) && (haddr <= `RSA_OFFSET) && hsel;
    assign hsel_aes = (haddr >= `AES_BASE_ADDR) && (haddr <= `AES_OFFSET) && hsel;
    assign hsel_sha = (haddr >= `SHA_BASE_ADDR) && (haddr <= `SHA_OFFSET) && hsel;

    always@(posedge hclk or negedge hrst_b)begin
    	if(~hrst_b)begin
    		hsel_rsa_reg <= 0;
    		hsel_aes_reg <= 0;
    		hsel_sha_reg <= 0;
    	end
    	else begin
    		hsel_rsa_reg <= hsel_rsa;
    		hsel_aes_reg <= hsel_aes;
    		hsel_sha_reg <= hsel_sha;
    	end
    end

    ahb_rsa_top x_ahb_rsa_top(
		.haddr(haddr),
		.hclk(hclk),
		.hprot(hprot),
		.hrdata(hrdata_rsa),
		.hready(),
		.hresp(),
		.hrst_b(hrst_b),
		.hsel(hsel_rsa),
		.hsize(hsize),
		.htrans(htrans),
		.hwdata(hwdata),
		.hwrite(hwrite),
		.intr(RSA_Interrupt)
	);

	ahb_aes_top x_ahb_aes_top(
	  	.haddr(haddr),
		.hclk(hclk),
		.hprot(hprot),
		.hrdata(hrdata_aes),
		.hready(),
		.hresp(),
		.hrst_b(hrst_b),
		.hsel(hsel_aes),
		.hsize(hsize),
		.htrans(htrans),
		.hwdata(hwdata),
		.hwrite(hwrite),
		.intr(AES_Interrupt)
    );

    sha1 x_ahb_sha_top(
	  	.haddr(haddr),
		.hclk(hclk),
		.hprot(hprot),
		.hrdata(hrdata_sha),
		.hready(),
		.hresp(),
		.hrst_b(hrst_b),
		.hsel(hsel_sha),
		.hsize(hsize),
		.htrans(htrans),
		.hwdata(hwdata),
		.hwrite(hwrite),
		.intr(SHA_Interrupt)
		);

    assign hrdata           = hsel_rsa_reg ? hrdata_rsa: 
    						  hsel_aes_reg ? hrdata_aes:
    						  hsel_sha_reg ? hrdata_sha: 32'b0;
    assign hready 			= 1;
    assign hresp 			= 2'b00;

    //assign SHA_Interrupt = 0;

endmodule