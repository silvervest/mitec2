`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:51:30 10/17/2022
// Design Name:   mitec2
// Module Name:   /home/vboxuser/mitec2/mitec2_test.v
// Project Name:  mitec2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mitec2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mitec2_test;

	// Inputs
	reg NMIN;
	reg RD;
	reg WR;
	reg MREQ;
	reg IORQ;
	reg RFSH;
	reg A6;
	reg A7;
	reg A14;
	reg A15;

	// Outputs
	wire NMI;
	wire IOR;
	wire IOW;
	wire MEMR;
	wire MEMW;
	wire CSR;
	wire CSW;
	wire CE89;
	wire CSSRAM;
	wire CEROM2;
	wire CAS1;
	wire RAS1;
	wire CAS2;
	wire RAS2;
	wire MUX;
	wire RAMA7;

	// Instantiate the Unit Under Test (UUT)
	mitec2 uut (
		.NMIN(NMIN), 
		.RD(RD), 
		.WR(WR), 
		.MREQ(MREQ), 
		.IORQ(IORQ), 
		.RFSH(RFSH), 
		.RAMA7(RAMA7), 
		.A6(A6), 
		.A7(A7), 
		.A14(A14), 
		.A15(A15), 
		.NMI(NMI), 
		.IOR(IOR), 
		.IOW(IOW), 
		.MEMR(MEMR), 
		.MEMW(MEMW), 
		.CSR(CSR), 
		.CSW(CSW), 
		.CE89(CE89), 
		.CSSRAM(CSSRAM), 
		.CEROM2(CEROM2), 
		.CAS1(CAS1), 
		.RAS1(RAS1), 
		.CAS2(CAS2), 
		.RAS2(RAS2), 
		.MUX(MUX)
	);

	initial begin
		$monitor("T=%0t: MREQ=%d, RD=%d, WR=%d, RFSH=%d, MUX=%d\n", $time, MREQ, RD, WR, RFSH, MUX	);

		// Initialize Inputs
		NMIN = 1;
		RD = 1;
		WR = 1;
		MREQ = 1;
		IORQ = 1;
		RFSH = 1;
		A6 = 0;
		A7 = 0;
		A14 = 0;
		A15 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
//assign #50 MUX = !(!RFSH || (!MREQ && !RD) || (!MREQ && !WR));

		#10 RFSH = 0;
		#60 RFSH = 1;
		#100 MREQ = 0;
		#10 RD = 0;
		#400 MREQ = 1; RD = 1;
		#100 MREQ = 0;
		#10 WR = 0;
		#400 MREQ = 1; WR = 1;
	
	end
      
endmodule

