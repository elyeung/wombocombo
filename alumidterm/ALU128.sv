`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2016 11:03:14 PM
// Design Name: 
// Module Name: ALU128
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


module ALU128( op1 , op2 , opsel , mode , result , c_flag , z_flag , o_flag , s_flag );
    
    parameter DWIDTH = 128;
    
    input logic [DWIDTH-1:0] op1;
    input logic [DWIDTH-1:0] op2;
    input logic [       2:0] opsel;
    input logic mode;
    output logic [DWIDTH-1:0] result;
    output logic c_flag;
    output logic z_flag;
    output logic o_flag;
    output logic s_flag;
    
    genvar i;
    wire [DWIDTH-1:0] Cin;
    wire [DWIDTH-1:0] Cout;
    generate
    
    
    
    
     assign Cin[0] = ((mode == 0 & opsel == 3'b000 )? 1'bz:
                                                 ((mode == 0 & opsel == 3'b001 )? 1'bz :
                                                                        ((mode == 0 & opsel == 3'b010 )? 1'b1:
                                                                              ((mode == 0 & opsel == 3'b011 )? 1'bz:
                                                                                             ((mode == 0 & opsel == 3'b100 )? 1'b1:
                                                                                                  ((mode == 0 & opsel == 3'b101 )? 0 :
                                                                                                   ((mode == 0 & opsel == 3'b110 )? 1'b1:
                                                                                                         ((mode == 1 & opsel == 3'b000 )? 0:
                                                                                                             ((mode == 1 & opsel == 3'b001 )? 0:
                                                                                                                 ((mode == 1 & opsel == 3'b010 )? 0:  
                                                                                                                     ((mode == 1 & opsel == 3'b011 )? 0:
                                                                                                                         ((mode == 1 & opsel == 3'b100 )? 1'b0:
                                                                                                                                                         3'bzzz)))))))))))); 
    for (i=0; i<=127; i++) begin:g
    ALU1bit l1 (
       .op1(op1[i]),
       .op2(op2[i]),
       .opsel(opsel),
       .mode(mode),
       .result(result[i]),
       .Cout(Cout[i]),
       .Cin(Cin[i])      
    );
     
    assign Cin[i+1] = ((mode == 0 & opsel == 3'b000 )? Cout[i]:
                        ((mode == 0 & opsel == 3'b001 )? Cout[i]:
                            ((mode == 0 & opsel == 3'b010 )? 0:
                                ((mode == 0 & opsel == 3'b011 )? Cout[i]:
                                    ((mode == 0 & opsel == 3'b100 )? Cout[i]:
                                        ((mode == 0 & opsel == 3'b101 )? 0:
                                            ((mode == 0 & opsel == 3'b110 )? Cout[i]:
                                                ((mode == 1 & opsel == 3'b000 )? 0:
                                                    ((mode == 1 & opsel == 3'b001 )? 0:
                                                        ((mode == 1 & opsel == 3'b010 )? 0:  
                                                            ((mode == 1 & opsel == 3'b011 )? 0:
                                                                ((mode == 1 & opsel == 3'b100 )? 0:
                                                                                            3'bzzz)))))))))))); 
   
    end
    endgenerate
    
    assign c_flag = (Cout[127] == 1)? 1:0;
    assign z_flag = (result[127:0] == 0) ? 1 : 0; //ask TA tommorow about zero flag 
    assign s_flag = ((mode == 0 & (opsel == 3'b001 | opsel == 3'b011)) & Cout[127] == 1)? 1:0 ;
    assign o_flag = (Cout[127] ==1 )? 1:0;

    
    
endmodule
