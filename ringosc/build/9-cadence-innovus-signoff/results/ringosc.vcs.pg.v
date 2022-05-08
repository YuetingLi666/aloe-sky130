/*
###############################################################
#  Generated by:      Cadence Innovus 20.13-s083_1
#  OS:                Linux x86_64(Host ID rice-503-20-north)
#  Generated on:      Sat May  7 23:55:31 2022
#  Design:            ringosc
#  Command:           saveNetlist -includePowerGround -excludeLeafCell results/ringosc.vcs.pg.v
###############################################################
*/
module ringosc (
	VSS, 
	VDD);
   inout VSS;
   inout VDD;

   // Internal wires
   wire VSSE;
   wire VSSPST;
   wire VPW;
   wire VDDPE;
   wire VDDCE;
   wire POC;
   wire VDDPST;
   wire VNW;
   wire out1;
   wire out2;
   wire out3;
   wire out4;
   wire out5;
   wire VDD;
   wire VSS;

   // Module instantiations
   sky130_asc_pfet_01v8_lvt_1 pfet1 (
	.GATE(out5),
	.SOURCE(VDD),
	.DRAIN(out1), 
	.VPWR(VDD), 
	.VGND(VSS));
   sky130_asc_nfet_01v8_lvt_1 nfet1 (
	.GATE(out5),
	.SOURCE(out1),
	.DRAIN(VSS), 
	.VPWR(VDD), 
	.VGND(VSS));
   sky130_asc_pfet_01v8_lvt_1 pfet2 (
	.GATE(out1),
	.SOURCE(VDD),
	.DRAIN(out2), 
	.VPWR(VDD), 
	.VGND(VSS));
   sky130_asc_nfet_01v8_lvt_1 nfet2 (
	.GATE(out1),
	.SOURCE(out2),
	.DRAIN(VSS), 
	.VPWR(VDD), 
	.VGND(VSS));
   sky130_asc_pfet_01v8_lvt_1 pfet3 (
	.GATE(out2),
	.SOURCE(VDD),
	.DRAIN(out3), 
	.VPWR(VDD), 
	.VGND(VSS));
   sky130_asc_nfet_01v8_lvt_1 nfet3 (
	.GATE(out2),
	.SOURCE(out3),
	.DRAIN(VSS), 
	.VPWR(VDD), 
	.VGND(VSS));
   sky130_asc_pfet_01v8_lvt_1 pfet4 (
	.GATE(out3),
	.SOURCE(VDD),
	.DRAIN(out4), 
	.VPWR(VDD), 
	.VGND(VSS));
   sky130_asc_nfet_01v8_lvt_1 nfet4 (
	.GATE(out3),
	.SOURCE(out4),
	.DRAIN(VSS), 
	.VPWR(VDD), 
	.VGND(VSS));
   sky130_asc_pfet_01v8_lvt_1 pfet5 (
	.GATE(out4),
	.SOURCE(VDD),
	.DRAIN(out5), 
	.VPWR(VDD), 
	.VGND(VSS));
   sky130_asc_nfet_01v8_lvt_1 nfet5 (
	.GATE(out4),
	.SOURCE(out5),
	.DRAIN(VSS), 
	.VPWR(VDD), 
	.VGND(VSS));
endmodule

