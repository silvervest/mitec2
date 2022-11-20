`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:24:26 10/17/2022 
// Design Name: 
// Module Name:    mitec2 
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
module mitec2(
    input NMIN,
    input RD,
    input WR,
    input MREQ,
    input IORQ,
    input RFSH,
    input A6,
    input A7,
    input A14,
    input A15,
    output NMI,
    output IOR,
    output IOW,
    output MEMR,
    output MEMW,
    output CSR,
    output CSW,
    output CE89,
    output CSSRAM,
    output CEROM2,
    output CAS1,
    output RAS1,
    output CAS2,
    output RAS2,
    output MUX,
    output RAMA7
    );

	// this still needs to be debounced
	assign NMI = NMIN;

	// store common states in temporary wires for cleanliness
	wire in_rd = !RD && WR,
		  in_wr = !WR && RD;

	// /MEMR and /MEMW are used to enable read/write of the onboard SRAM
	// they are set LOW when /MREQ is LOW
	assign MEMR = !(in_rd && !MREQ);
	assign MEMW = !(in_wr && !MREQ);

	// /IOR and /IOW are used to enable read/write of the PPI
	// they are LOW when /MREQ is HIGH and /IORQ is LOW
	assign IOR = !(in_rd && MREQ && !IORQ);
	assign IOW = !(in_wr && MREQ && !IORQ);

	// /CSR and /CSW are used to enable read/write of the VDP
	// they are LOW when /MREQ is HIGH, /RFSH is HIGH and A6 is LOW
	// /RFSH isn't obvious, and was shown as required during logic analysis and testing
	// A6 is shown as /CS for the VDP on page 10 of service manual: 2-9 I/O MAP
	assign CSR = !(in_rd && MREQ && RFSH && !A6);
	assign CSW = !(in_wr && MREQ && RFSH && !A6);

	// /CE89 is used to control the PSG
	// it is LOW when /MREQ is HIGH, /IORQ is HIGH and A7 is LOW
	// this equation overlaps /IOW but it doesn't seem to matter (yet)
	// A7 is shown as /CS for the PSG on page 10 of service manual: 2-9 I/O MAP
	assign CE89 = !(in_wr && MREQ && !IORQ && !A7);

	// /CSSRAM is weakly used to activate the onboard SRAM (carts disable this by strongly pulling HIGH)
	// /CEROM2 is used to activate the cart ROM
	// i have not been able to discern a difference between these, and can not determine why A15 is required for both
	// it is LOW when /MREQ is LOW and A15 is HIGH
	assign CSSRAM = !(!MREQ && A15);
	assign CEROM2 = !(!MREQ && A15);

	// /RAS1, /RAS2, /CAS1, /CAS2, and /MUX are all used to control read/write cycles for external DRAM on carts
	// there are timing charts on page 11-12 of service manual, delays below are based off that mixed with signal captures and experimentation
	// however, these delays are not really used as there is no clock source in this design - but it doesn't seem to matter so ¯\_(ツ)_/¯
	// A14 and /MUX are used to multiplex which bank of DRAM is in use
	// when A14 is LOW, bank 1 is active, when A14 is HIGH, bank 2 is used
	// first /RAS is pulled low, shortly after /MUX is pulled low by /MREQ and a read/write request, then shortly after the corresponding /CAS is pulled LOW
	assign #10 RAS1 = !((!MREQ && !RFSH) || (!A14 && (!MEMR || !MEMW) && !CSSRAM));
	assign #10 RAS2 = !((!MREQ && !RFSH) || ( A14 && (!MEMR || !MEMW) && !CSSRAM));
	assign #50 MUX = !(RFSH && ((!MREQ && !RD) || (!MREQ && !WR)));
	assign #50 CAS1 = !(!MUX && !RAS1);
	assign #50 CAS2 = !(!MUX && !RAS2);
	
	// RAMA7 replaces regular A7 when accessing external DRAM
	// it is HIGH when A7 and RFSH are HIGH
	// it is enabled/disabled for use in DRAM by /MUX and is always LOW when /MUX is HIGH
	assign #30 RAMA7 = A7 && RFSH;

endmodule
