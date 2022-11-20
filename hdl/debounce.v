`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:24 11/20/2022 
// Design Name: 
// Module Name:    debounce 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module debounce(
    input clk,
    input in,
    output out
    );

	parameter DEBOUNCE_CYCLES = 10; // how many clk cycles to verify the input
	reg [3:0] count = 0;
	reg state = 0;

	always @(posedge clk)
	begin
		if (in !== state && count < DEBOUNCE_CYCLES)
			count <= count + 1;
		else if (count == DEBOUNCE_CYCLES)
		begin
			state <= in;
			count <= 0;
		end
		else
			count <= 0;
	end
	
	assign out = state;

endmodule
