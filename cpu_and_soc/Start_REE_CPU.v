// memory map : 0x2000_0000~0x2000_FFFF
`define SET_ADDR        32'h0006_0000
`define SET_RST_ADDR    32'h0006_0004

module Start_REE_CPU(  
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
    intr,

    ree_cpu_rst_addr,
    ree_cpu_rst_n
); 
 
    input   [31:0]  haddr;
    input           hclk;
    output          hready;
    input           hrst_b;
    input           hsel;
    input   [31:0]  hwdata;
    input           hwrite;
    output  [31:0]  hrdata;
    output          intr;
    output  [1 :0]  hresp;
    input   [3 :0]  hprot; 
    input   [2 :0]  hsize;
    input   [1 :0]  htrans;

    output  [31:0]  ree_cpu_rst_addr;
    output          ree_cpu_rst_n; 

    wire    [31:0]  haddr;
    wire            hclk;
    wire            hready;
    wire            hrst_b;
    wire            hsel;
    wire    [31:0]  hwdata;
    wire            hwrite;
    wire    [31:0]  hrdata;
    wire            intr;
    wire    [1 :0]  hresp;
    wire    [3 :0]  hprot; 
    wire    [2 :0]  hsize;
    wire    [1 :0]  htrans;

    wire    [31:0]  ree_cpu_rst_addr;
    wire            ree_cpu_rst_n; 

    wire            ree_cpu_rst_addr_set_en;
    wire            ree_cpu_rst_n_set_en;
    reg             ree_cpu_rst_addr_set_en_reg;
    reg             ree_cpu_rst_n_set_en_reg;
    reg     [31:0]  ree_addr;
    reg             ree_rst_n;


    assign  ree_cpu_rst_addr_set_en = (haddr == `SET_ADDR) & hwrite & hsel;
    assign  ree_cpu_rst_n_set_en = (haddr == `SET_RST_ADDR) & hwrite & hsel;

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            ree_cpu_rst_addr_set_en_reg <= 0;
        end
        else begin
            ree_cpu_rst_addr_set_en_reg <= ree_cpu_rst_addr_set_en;
        end
    end

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            ree_addr <= 32'h1007FFFF;
        end
        else if(ree_cpu_rst_addr_set_en_reg)begin
            ree_addr <= hwdata;
        end
    end

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            ree_cpu_rst_n_set_en_reg <= 0;
        end
        else begin
            ree_cpu_rst_n_set_en_reg <= ree_cpu_rst_n_set_en;
        end
    end

    always@(posedge hclk or negedge hrst_b)begin
        if(!hrst_b)begin
            ree_rst_n <= 0;
        end
        else if(ree_cpu_rst_n_set_en_reg)begin
            ree_rst_n <= hwdata[0];
        end
    end

    reg [31:0] ihrdata;
    always @(posedge hclk or negedge hrst_b)
    begin
    if(!hrst_b)
        ihrdata[31:0] <= {32{1'b0}};
    else
        if((hwrite == 1'b0) && (hsel == 1'b1))
        case(haddr)
            `SET_ADDR:ihrdata <= ree_addr;
            `SET_RST_ADDR:ihrdata <= {31'b0,ree_rst_n};
        
            default:ihrdata <= {32{1'b0}};
        endcase
        else
            ihrdata <= {32{1'b1}};
    end

    assign hrdata[31:0]     = ihrdata;
    assign hready           = 1;
    assign hresp            = 2'b00;
    assign ree_cpu_rst_addr = ree_addr;
    assign ree_cpu_rst_n    = ree_rst_n;
    assign intr             = 1'b0;

endmodule
