`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/02 21:14:07
// Design Name: 
// Module Name: LSFR_Random
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

module LSFR_Random(
    input wire CLK,
    input wire RST_N,
    input wire gen_random,
    input wire load_data,
    
    output reg [11:0] rand_num
);

always@(posedge CLK , negedge RST_N) begin
    if(!RST_N)begin
        rand_num <= 12'b101010100111;       
    end
    else if(load_data)begin
        rand_num <= 12'b101010100111;//12'b101010100111
    end
    else if(gen_random)begin
        rand_num[0] <= rand_num[11];
        rand_num[1] <= rand_num[11] ^ rand_num[0];
        rand_num[2] <= rand_num[11] ^ rand_num[1];
        rand_num[3] <= rand_num[2];
        rand_num[4] <= rand_num[11] ^ rand_num[3];
        rand_num[5] <= rand_num[4];
        rand_num[6] <= rand_num[5];
        rand_num[7] <= rand_num[11] ^ rand_num[6];
        rand_num[8] <= rand_num[7];
        rand_num[9] <= rand_num[11] ^ rand_num[8];
        rand_num[10] <= rand_num[9];
        rand_num[11] <= rand_num[11] ^ rand_num[10];
    end
end

endmodule
