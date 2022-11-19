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

assign #10 RAS1 = !((!MREQ && !RFSH) || (!MREQ && (!RD || !WR) && !A14 && A15));
assign #10 RAS2 = !((!MREQ && !RFSH) || (!MREQ && (!RD || !WR) && A14 && A15));
assign #50 MUX = !(RFSH && ((!MREQ && !RD) || (!MREQ && !WR)));
assign #50 CAS1 = !(!MUX && !RAS1);
assign #50 CAS2 = !(!MUX && !RAS2);
assign #30 RAMA7 = A7 && RFSH;


endmodule
