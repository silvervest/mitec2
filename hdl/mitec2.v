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

// fully confident in these equations, they work to boot mostly everything
assign NMI = NMIN;

assign MEMR = !(!RD && WR && !MREQ && IORQ && RFSH);
assign MEMW = !(RD && !WR && !MREQ && IORQ && RFSH);

assign IOR = !(!RD && WR && MREQ && !IORQ && A7);
assign IOW = !(RD && !WR && MREQ && !IORQ && A7);

assign CSR = !(!RD && WR && MREQ && RFSH && !A6 && A7);
assign CSW = !(RD && !WR && MREQ && RFSH && !A6 && A7);

assign CE89 = !(RD && !WR && MREQ && !A7);

assign CSSRAM = !(A14 && A15);
assign CEROM2 = !(A14 && A15);

// these signals I haven't found a perfect solution for
// the below equations are guesses, but don't seem to work
// however, they only seem to affect cartridges that contain
// onboard dram, so the impact is minimal
assign CAS1 = !(RFSH && !A14 && A15);
assign CAS2 = !(RFSH && A14 && A15);
assign RAS1 = !(!MREQ && !RFSH);
assign RAS2 = !(!MREQ && !RFSH) && !(!A6 && !MREQ);
assign MUX = !(!RD || A15 || A7);
assign RAMA7 = A7 || !RD || !RFSH;


endmodule
