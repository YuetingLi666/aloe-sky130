proc shift_to_center {} {
	set res1 [box size]
	puts "************************************"
	puts $res1
	move [expr {-[lindex $res1 0] / 2}]i [expr {-[lindex $res1 1] / 2}]i
	return $res1
}

proc shift_to_center_cap_1 {} {
	set res1 [box size]
	puts "************************************"
	puts $res1
	move 1443 25
	return $res1
}

proc shift_to_center_cap_2 {} {
	set res1 [box size]
	puts "************************************"
	puts $res1
	move 2243.5 25
	return $res1
}
proc place_pmos {x_center y_center length nf index} {
	load pmos
	# input arg [um]
	box [expr $x_center]um [expr $y_center]um [expr $x_center]um [expr $y_center]um  
	magic::gencell sky130::sky130_fd_pr__pfet_01v8_lvt [format "xm%d" $index] w 6.45 l $length m 1 nf $nf diffcov 100 polycov 100 guard 0 glc 0 grc 0 gtc 0 gbc 0 tbcov 0 rlcov 0 topc 0 botc 0 poverlap 0 doverlap 1 lmin 0.15 wmin 0.42 compatible {sky130_fd_pr__pfet_01v8  sky130_fd_pr__pfet_01v8_lvt sky130_fd_pr__pfet_01v8_hvt  sky130_fd_pr__pfet_g5v0d10v5} full_metal 0 viasrc 100 viadrn 100 viagate 0 viagb 0 viagr 0 viagl 0 viagt 0
	set box_size [shift_to_center]
	set bx [expr {[lindex $box_size 0]/2}]
	set by [expr {[lindex $box_size 1]/2}]
	puts "by is : $by"
	set height_half_center 380
	set power_half_w 30
	set con_w 30
	### unit conversion here
	set con_sep  [expr $length*100]
	set x_center [expr $x_center*100]
	set y_center [expr $y_center*100]
	### extend NWELL
	box [expr $x_center-$bx/2-49] [expr $y_center-$by/2] [expr $x_center+$bx/2] [expr $y_center + $height_half_center + $power_half_w+60]
	paint nwell
	# #------- label VPB
	# box [expr $x_center-$bx/2+100-$con_w/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+100+$con_w/2] [expr $y_center+$height_half_center+$con_w/2+60]
	# paint nwell
	# label VPB FreeSans 50
	### paint VDD
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center - $power_half_w+60] [expr $x_center + $bx/2] [expr $y_center + $height_half_center + $power_half_w+60]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center+$bx/2] [expr $y_center + $height_half_center + $con_w/2+60]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$x+$con_w/2] [expr $y_center+$height_half_center+$con_w/2+60]
		paint viali
	}
	#------ label VPWR
	box [expr $x_center-$bx/2-49] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$con_w-49] [expr $y_center+$height_half_center+$con_w/2+60]
	label VPWR FreeSans 50
	### paint VSS
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$power_half_w-120] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$power_half_w-120]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$con_w/2-120]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center-$bx/2+$x+$con_w/2]  [expr $y_center-$height_half_center+$con_w/2-120]
		paint viali
	}
	#------ label VGND
	box [expr $x_center-$bx/2-49] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center-$bx/2+$con_w] [expr $y_center-$height_half_center+$con_w/2-120]
	paint m1
	label VGND FreeSans 50 
	### paint SOURCE rail
	box [expr $x_center-$bx/2+30] [expr $y_center+$height_half_center-$con_w/2] [expr $x_center+$bx/2] [expr $y_center+$height_half_center+$con_w/2]
	paint li
	#------ label SOURCE
	box [expr $x_center+$bx/2-$con_w] [expr $y_center+$height_half_center-$con_w/2] [expr $x_center+$bx/2] [expr $y_center+$height_half_center+$con_w/2]
	paint li
	label SOURCE FreeSans 50
	### paint DRAIN rail
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$con_w/2]
	paint li
	#------ label DRAIN
	box [expr $x_center+$bx/2-$con_w] [expr $y_center-$height_half_center-$con_w/2] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$con_w/2]
	paint li
	label DRAIN FreeSans 50
	### paint GATE rail
	set gate_w 50  
	box [expr $x_center-$bx/2] [expr $y_center-$by/2-80-$gate_w/2] [expr $x_center+$bx/2]  [expr $y_center-$by/2-80+$gate_w/2]
	paint p
	box [expr $x_center-$bx/2] [expr $y_center-$by/2-80-15] [expr $x_center+$bx/2]  [expr $y_center-$by/2-80+15]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center - $bx/2 + $x - $con_w/2] [expr $y_center - $by/2 - $con_w/2 - 80] [expr $x_center - $bx/2 + $x+$con_w/2] [expr $y_center - $by/2 + $con_w/2 - 80]
		paint pcontact
	}
	#------ label GATE
	box [expr $x_center+$bx/2-$con_w] [expr $y_center - $by/2 - $con_w/2 - 80] [expr $x_center+$bx/2] [expr $y_center - $by/2 + $con_w/2 - 80]
	paint li
	label GATE FreeSans 50
	### paint GATE connection
	for {set x 150} {$x+$con_w + 28<=$bx} {set x [expr $x + $con_sep + 28]} {
		box [expr $x_center-$bx/2+$x-$con_w] [expr $y_center-$by/2-70] [expr $x_center-$bx/2+$x+$con_w] [expr $y_center-$by/2+$con_w]
		paint polysilicon
	}
	### paint source connection
	for {set x [expr 23.5+$con_sep+29]} {$x+29<=$bx} {set x [expr $x+2*$con_sep+2*29]} {
		box [expr $x_center-$bx/2+$x] [expr $y_center+$by/2-40] [expr $x_center-$bx/2+$x+17] [expr $y_center+$height_half_center]
		paint li
	}
	### paint drain connection
	for {set x 23.5} {$x+29<=$bx} {set x [expr $x+2*$con_sep+2*29]} {
		box [expr $x_center-$bx/2+$x] [expr $y_center-$by/2+40] [expr $x_center-$bx/2+$x+17] [expr $y_center-$height_half_center]
		paint li
	}
	### paint tapvpwr
	# PWR
	box [expr $x_center-$bx/2-49] [expr $y_center+$height_half_center - $power_half_w+60] [expr $x_center-$bx/2] [expr $y_center + $height_half_center + $power_half_w+60]
	paint m1
	box [expr $x_center-$bx/2-49] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2] [expr $y_center + $height_half_center + $con_w/2+60]
	paint li
	# GND
	box [expr $x_center-$bx/2-49] [expr $y_center-$height_half_center-$power_half_w-120] [expr $x_center-$bx/2] [expr $y_center-$height_half_center+$power_half_w-120]
	paint m1
	box [expr $x_center-$bx/2-49] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center-$bx/2] [expr $y_center-$height_half_center+$con_w/2-120]
	paint li
	# diff
	box [expr $x_center-$bx/2-30] [expr $y_center+$height_half_center-40+60] [expr $x_center-$bx/2-10] [expr $y_center + $height_half_center-100+60]
	paint nsubstratendiff
	# nsubstratencontact
	box [expr $x_center-$bx/2-30] [expr $y_center+$height_half_center-60+60] [expr $x_center-$bx/2-10] [expr $y_center + $height_half_center-80+60]
    paint nsubstratencontact
	# m1 with diff
	box [expr $x_center-$bx/2-35] [expr $y_center+$height_half_center+$con_w/2+60] [expr $x_center-$bx/2-5] [expr $y_center + $height_half_center-120+60] 
	paint li
	return $box_size
}

proc place_nmos {x_center y_center length nf index} {
	load nmos
	box [expr $x_center]um [expr $y_center]um [expr $x_center]um [expr $y_center]um  
	magic::gencell sky130::sky130_fd_pr__nfet_01v8_lvt [format "xm%d" $index] w 4 l $length m 1 nf $nf diffcov 100 polycov 100 guard 0 glc 0 grc 0 gtc 0 gbc 0 tbcov 0 rlcov 0 topc 0 botc 0 poverlap 0 doverlap 1 lmin 0.15 wmin 0.42 compatible {sky130_fd_pr__pfet_01v8  sky130_fd_pr__pfet_01v8_lvt sky130_fd_pr__pfet_01v8_hvt  sky130_fd_pr__pfet_g5v0d10v5} full_metal 0 viasrc 100 viadrn 100 viagate 0 viagb 0 viagr 0 viagl 0 viagt 0
	set box_size [shift_to_center]
	set bx [expr {[lindex $box_size 0]/2}]
	set by [expr {[lindex $box_size 1]/2}]
	puts "by is : $by"
	set height_half_center 380
	set power_half_w 30
	set con_w 30
	### unit conversion here
	set con_sep  [expr $length*100] 
	set x_center [expr $x_center*100]
	set y_center [expr $y_center*100]
	### extend PWELL to VSS
	box [expr $x_center-$bx/2-58.8] [expr $y_center+$by/2] [expr $x_center+$bx/2+9.8] [expr $y_center-$height_half_center+$con_w/2-120]
	paint pwell
	# #------ Label VNB
	# box [expr $x_center+$bx/2-30-$con_w] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center+$bx/2-30] [expr $y_center-$height_half_center+$con_w/2-120]
	# label VNB FreeSans 50
	### paint VDD
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center - $power_half_w+60] [expr $x_center + $bx/2] [expr $y_center + $height_half_center + $power_half_w+60]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center+$bx/2] [expr $y_center + $height_half_center + $con_w/2+60]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$x+$con_w/2] [expr $y_center+$height_half_center+$con_w/2+60]
		paint viali
	}
	#------ Label VPWR
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$con_w] [expr $y_center+$height_half_center+$con_w/2+60]
	paint m1
	label VPWR FreeSans 50
	### paint VSS
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$power_half_w-120] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$power_half_w-120]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$con_w/2-120]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center-$bx/2+$x+$con_w/2] [expr $y_center-$height_half_center+$con_w/2-120]
		paint viali
	}
	#------ Label VGND
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center-$bx/2+$con_w] [expr $y_center-$height_half_center+$con_w/2-120]
	paint m1
	label VGND FreeSans 50 
	### paint SOURCE rail
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2-20] [expr $x_center+$bx/2] [expr $y_center+$height_half_center+$con_w/2-20]
	paint li
	#------ Label SOURCE
	box [expr $x_center+$bx/2-$con_w] [expr $y_center+$height_half_center-$con_w/2-20] [expr $x_center+$bx/2] [expr $y_center+$height_half_center+$con_w/2-20]
	paint li
	label SOURCE FreeSans 50
	### paint DRAIN rail
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2+80] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$con_w/2+80]
	paint li
	#------ Label DRAIN
	box [expr $x_center+$bx/2-$con_w] [expr $y_center-$height_half_center-$con_w/2+80] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$con_w/2+80]
	paint li
	label DRAIN FreeSans 50
	### paint GATE rail
	set gate_w 50  
	box [expr $x_center-$bx/2+40] [expr $y_center-$by/2-$gate_w/2-200] [expr $x_center+$bx/2] [expr $y_center-$by/2+$gate_w/2-200]
	paint p
	box [expr $x_center-$bx/2+40] [expr $y_center-$by/2-200-15] [expr $x_center+$bx/2] [expr $y_center-$by/2-200+15]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center - $bx/2 + $x - $con_w/2] [expr $y_center - $by/2 - $con_w/2 - 200] [expr $x_center - $bx/2 + $x+$con_w/2] [expr $y_center - $by/2 + $con_w/2 - 200]
		paint pcontact
	}
	#------ Label GATE
	box [expr $x_center+$bx/2-$con_w] [expr $y_center - $by/2 - $con_w/2 - 200] [expr $x_center+$bx/2] [expr $y_center - $by/2 + $con_w/2 - 200]
	paint li
	label GATE FreeSans 50
	### paint GATE connection
	for {set x 133} {$x+$con_w + 28<=$bx} {set x [expr $x + $con_sep + 28]} {
		box [expr $x_center-$bx/2+$x-$con_w] [expr $y_center-$by/2-200] [expr $x_center-$bx/2+$x+$con_w] [expr $y_center-$by/2+$con_w]
		paint p
	}
	### paint source connection
	for {set x [expr 5.5+$con_sep+29]} {$x+10<=$bx} {set x [expr $x+2*$con_sep+2*29]} {
		box [expr $x_center-$bx/2+$x] [expr $y_center+$by/2-20] [expr $x_center-$bx/2+$x+17] [expr $y_center+$height_half_center+$con_w/2-20]
		paint li
	}
	### paint drain connection
	for {set x 5.5} {$x+29<=$bx} {set x [expr $x+2*$con_sep+2*29]} {
		box [expr $x_center-$bx/2+$x] [expr $y_center-$by/2+40] [expr $x_center-$bx/2+$x+17] [expr $y_center-$height_half_center+80]
		paint li
	}
	### paint tapvpwr
	# PWR
	box [expr $x_center-$bx/2-49] [expr $y_center+$height_half_center - $power_half_w+60] [expr $x_center-$bx/2] [expr $y_center + $height_half_center + $power_half_w+60]
	paint m1
	box [expr $x_center-$bx/2-49] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2] [expr $y_center + $height_half_center + $con_w/2+60]
	paint li
	# GND
	box [expr $x_center-$bx/2-49] [expr $y_center-$height_half_center-$power_half_w-120] [expr $x_center-$bx/2] [expr $y_center-$height_half_center+$power_half_w-120]
	paint m1
	box [expr $x_center-$bx/2-49] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center-$bx/2] [expr $y_center-$height_half_center+$con_w/2-120]
	paint li
	# diff
	box [expr $x_center-$bx/2-30] [expr $y_center-$height_half_center+40-120] [expr $x_center-$bx/2-10] [expr $y_center-$height_half_center+100-120]
	paint psubstratepdiff
	# nsubstratencontact
	box [expr $x_center-$bx/2-30] [expr $y_center-$height_half_center+60-120] [expr $x_center-$bx/2-10] [expr $y_center-$height_half_center+80-120]
    paint psubstratepcontact
	# m1 with diff
	box [expr $x_center-$bx/2-35] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center-$bx/2-5] [expr $y_center - $height_half_center] 
	paint li
	return $box_size
}

proc place_cap_1 {x_center y_center index} {
	load cap_1
	# input arg [um]
	box [expr $x_center]um [expr $y_center]um [expr $x_center]um [expr $y_center]um  
	# box [expr $x_center]um [expr $y_center]um [expr $x_center]um [expr $y_center]um 
	magic::gencell sky130::sky130_fd_pr__cap_mim_m3_1 [format "xm%d" $index] w 2.00 l 2.00 val 5.36 carea 1.00 cperi 0.17 nx 10 ny 2 dummy 0 square 1 lmin 2.00 wmin 2.00 lmax 30.0 wmax 30.0 dc 0 bconnect 0 tconnect 0 ccov 100
	set box_size [shift_to_center_cap_1]
	set bx [expr {[lindex $box_size 0]/2}]
	set by [expr {[lindex $box_size 1]/2}]
	set height_half_center 380
	set power_half_w 30
	set con_w 30
	### unit conversion here
	set con_sep  [expr 2*100]
	set x_center [expr $x_center*100]
	set y_center [expr $y_center*100]
	### connect parrallel caps
	box [expr -$bx/2] [expr -$by/2] [expr $bx/2] [expr $by/2+20]
	paint m3
	# ------ label Cin
	box [expr -$bx/2] [expr $by/2-10] [expr -$bx/2+30] [expr $by/2+20]
	label Cin FreeSans 50
    ### m4 vertical connections
	set m4_w 160
	for {set x [expr -$bx/2+70]} {$x+$m4_w<=$bx/2} {set x [expr $x + 360]} {
		box [expr $x] [expr -$by/2-40] [expr $x+$m4_w]  [expr $by/2-60]
		paint m4
	}
	### m4 horizontal rail
	box [expr $x_center-$bx/2] [expr -$by/2-30] [expr $x_center + $bx/2] [expr -$by/2-80]
	paint m4
	#------ label Cout
	box [expr $x_center-$bx/2] [expr -$by/2-40] [expr $x_center - $bx/2+30] [expr -$by/2-70]
	label Cout FreeSans 50
	### paint VDD
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center - $power_half_w+60] [expr $x_center + $bx/2] [expr $y_center + $height_half_center + $power_half_w+60]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center+$bx/2] [expr $y_center + $height_half_center + $con_w/2+60]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$x+$con_w/2] [expr $y_center+$height_half_center+$con_w/2+60]
		paint viali
	}
	#------ label VPWR
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$con_w] [expr $y_center+$height_half_center+$con_w/2+60]
	paint m1
	label VPWR FreeSans 50
	### paint VSS
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$power_half_w-120] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$power_half_w-120]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$con_w/2-120]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center-$bx/2+$x+$con_w/2]  [expr $y_center-$height_half_center+$con_w/2-120]
		paint viali
	}
	#------ label VGND
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center-$bx/2+$con_w] [expr $y_center-$height_half_center+$con_w/2-120]
	paint m1
	label VGND FreeSans 50 
}

proc place_cap_2 {x_center y_center index} {
	load cap_2
	# input arg [um]
	box [expr $x_center]um [expr $y_center]um [expr $x_center]um [expr $y_center]um  
	# box [expr $x_center]um [expr $y_center]um [expr $x_center]um [expr $y_center]um 
	magic::gencell sky130::sky130_fd_pr__cap_mim_m3_2 [format "xm%d" $index] w 2.00 l 2.00 val 5.36 carea 2.00 cperi 0.17 nx 10 ny 2 dummy 0 square 1 lmin 2.00 wmin 2.00 lmax 30.0 wmax 30.0 dc 0 bconnect 1 tconnect 1 ccov 100
	set box_size [shift_to_center_cap_2]
	set bx [expr {[lindex $box_size 0]/2}]
	set by [expr {[lindex $box_size 1]/2}]
	set height_half_center 380
	set power_half_w 30
	set con_w 30
	### unit conversion here
	set con_sep  [expr 2*100]
	set x_center [expr $x_center*100]
	set y_center [expr $y_center*100]

	# ## m4 connections
	# box [expr -$bx/2] [expr -$by/2+20] [expr $bx/2] [expr $by/2+30]
	# paint m4
	# # ------ label c0
	# box [expr -$bx/2] [expr $by/2] [expr -$bx/2+30] [expr $by/2+30]
	# label c0 FreeSans 50
    # ### m5 connections
	# box [expr -$bx/2] [expr -$by/2-30] [expr $bx/2+10] [expr $by/2]
	# paint m5
	# #------ label c1
	# box [expr -$bx/2] [expr -$by/2-30] [expr -$bx/2+30] [expr -$by/2]
	# label c1 FreeSans 50


	### paint VDD
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center - $power_half_w+60] [expr $x_center + $bx/2] [expr $y_center + $height_half_center + $power_half_w+60]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center+$bx/2] [expr $y_center + $height_half_center + $con_w/2+60]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$x+$con_w/2] [expr $y_center+$height_half_center+$con_w/2+60]
		paint viali
	}
	#------ label VPWR
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$con_w] [expr $y_center+$height_half_center+$con_w/2+60]
	paint m1
	label VPWR FreeSans 50
	### paint VSS
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$power_half_w-120] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$power_half_w-120]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$con_w/2-120]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center-$bx/2+$x+$con_w/2]  [expr $y_center-$height_half_center+$con_w/2-120]
		paint viali
	}
	#------ label VGND
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2-120] [expr $x_center-$bx/2+$con_w] [expr $y_center-$height_half_center+$con_w/2-120]
	paint m1
	label VGND FreeSans 50 
}

proc place_res_1 {x_center y_center index} {
    set bx 1220
    # set by 
    set height_half_center 440
	set power_half_w 30
	set con_sep 100 ;#unit conversion
	set con_w 30

    box -394 97.5 394 382.5
    paint xpolyres

    box 402.5 105.5 601 374.5
    paint viali
    box 394 97.5 610 382.5
    paint xpolycontact
    box 394 97.5 610 382.5
    paint locali
    box 399.5 99.5 604.5 380.5
    paint metal1

    box -601 105.5 -402.5 374.5
    paint viali
    box -610 97.5 -394 382.5
    paint xpolycontact
    box -610 97.5 -394 382.5
    paint locali
    box -604.5 99.5 -399.5 380.5
    paint metal1
    box -550 210 -490 270
    label Rin FreeSans 30

    box -394 -382.5 394 -97.5
    paint xpolyres

    box 402.5 -374.5 601 -105.5
    paint viali
    box 394 -382.5 610 -97.5
    paint xpolycontact
    box 394 -382.5 610 -97.5
    paint locali
    box 399.5 -380.5 604.5 -99.5
    paint metal1

    box -601 -374.5 -402.5 -105.5
    paint viali
    box -610 -382.5 -394 -97.5
    paint xpolycontact
    box -610 -382.5 -394 -97.5
    paint locali
    box -604.5 -380.5 -399.5 -99.5
    paint metal1
    box -550 -270 -490 -210
    label Rout FreeSans 30

    box 394 -382.5 610 99.5
    paint m1
    paint locali

	### paint VPWR
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center - $power_half_w +60] [expr $x_center + $bx/2] [expr $y_center + $height_half_center + $power_half_w+60]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center+$bx/2] [expr $y_center + $height_half_center + $con_w/2+60]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$x+$con_w/2]  [expr $y_center+$height_half_center+$con_w/2+60]
		paint viali
	}
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$con_w] [expr $y_center+$height_half_center+$con_w/2+60]
	paint m1
	label VPWR FreeSans 50

	### paint VGND
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$power_half_w] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$power_half_w]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$con_w/2]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center-$height_half_center-$con_w/2] [expr $x_center-$bx/2+$x+$con_w/2]  [expr $y_center-$height_half_center+$con_w/2]
		paint viali
	}
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2] [expr $x_center-$bx/2+$con_w] [expr $y_center-$height_half_center+$con_w/2]
	paint m1
	label VGND FreeSans 50
	# bulk
	box -610 -470 610 385 
	paint pwell
	box -124 -30 124 30
	paint psubstratepcontact
	box -154 -45 154 45
	paint psubstratepdiff
	box -154 -445 154 45
	paint locali
}

# w = 2.85    l = 7.88 x 2   10.75 x 2
proc place_res_2 {x_center y_center index} {
    set bx 1507
    # set by 
    set height_half_center 440
	set power_half_w 30
	set con_sep 100 ;#unit conversion
	set con_w 30

	# box -394 97.5 394 382.5
    box -537.5 97.5 537.5 382.5
    paint xpolyres

    # box 402.5 105.5 601 374.5
	box 546 105.5 744.5 374.5
    paint viali
    box 537.5 97.5 753.5 382.5
    paint xpolycontact
    box 537.5 97.5 753.5 382.5
    paint locali
    box 543 99.5 748 380.5
    paint metal1

    box -744.5 105.5 -546 374.5
    paint viali
    box -753.5 97.5 -537.5 382.5
    paint xpolycontact
    box -753.5 97.5 -537.5 382.5
    paint locali
    box -748 99.5 -543 380.5
    paint metal1
    box -693.5 210 -633.5 270
	# box -550 210 -490 270
    label Rin FreeSans 30

    box -537.5 -382.5 537.5 -97.5
    paint xpolyres

    box 546 -374.5 744.5 -105.5
    paint viali
    box 537.5 -382.5 753.5 -97.5
    paint xpolycontact
    box 537.5 -382.5 753.5 -97.5
    paint locali
    box 543 -380.5 748 -99.5
    paint metal1

    box -744.5 -374.5 -546 -105.5
    paint viali
    box -753.5 -382.5 -537.5 -97.5
    paint xpolycontact
    box -753.5 -382.5 -537.5 -97.5
    paint locali
    box -748 -380.5 -543 -99.5
    paint metal1
    box -693.5 -270 -633.5 -210
    label Rout FreeSans 30

    box 537.5 -382.5 753.5 99.5
    paint m1
    paint locali

	### paint VPWR
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center - $power_half_w+60] [expr $x_center + $bx/2] [expr $y_center + $height_half_center + $power_half_w+60]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center+$bx/2] [expr $y_center+$height_half_center+$con_w/2+60]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$x+$con_w/2]  [expr $y_center+$height_half_center+$con_w/2+60]
		paint viali
	}
	box [expr $x_center-$bx/2] [expr $y_center+$height_half_center-$con_w/2+60] [expr $x_center-$bx/2+$con_w] [expr $y_center+$height_half_center+$con_w/2+60]
	paint m1
	label VPWR FreeSans 50

	### paint VGND
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$power_half_w] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$power_half_w]
	paint m1
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2] [expr $x_center+$bx/2] [expr $y_center-$height_half_center+$con_w/2]
	paint li
	for {set x 100} {$x+$con_w<=$bx} {set x [expr $x + $con_sep]} {
		box [expr $x_center-$bx/2+$x-$con_w/2] [expr $y_center-$height_half_center-$con_w/2] [expr $x_center-$bx/2+$x+$con_w/2]  [expr $y_center-$height_half_center+$con_w/2]
		paint viali
	}
	box [expr $x_center-$bx/2] [expr $y_center-$height_half_center-$con_w/2] [expr $x_center-$bx/2+$con_w] [expr $y_center-$height_half_center+$con_w/2]
	paint m1
	label VGND FreeSans 50

	# bulk
	box -610 -470 610 385 
	paint pwell
	box -124 -30 124 30
	paint psubstratepcontact
	box -154 -45 154 45
	paint psubstratepdiff
	box -154 -445 154 45
	paint locali
}

# set customized parameters that usually don't change in one element 
proc inst_param_customize {inst_name guard topc botc doverlap lmin wmin viagate} {
	append inst_name "_defaults"
	set params [sky130::$inst_name]
	dict set params guard $guard
	dict set params topc $topc
	dict set params botc $botc
	dict set params doverlap $doverlap
	dict set params lmin $lmin
	dict set params wmin $wmin
	dict set params viagate $viagate
	return $params
}
######################## Instance Placement Illustration #####################
#	inst_name guard topc botc lmin wmin viagate
#	inst_name x_center y_center width length nf index params
##############################################################################

### some simple test ###
# load first_try
### PFET PLACEMENT ###
# set params [inst_param_customize "sky130_fd_pr__pfet_01v8_lvt" 0 0 1 0 0.35 0.42 50]  
# place_inst "sky130_fd_pr__pfet_01v8_lvt" 0 10 12.9 2 14 1 $params
# ### NFET PLACEMENT ###
# set params [inst_param_customize "sky130_fd_pr__nfet_01v8_lvt" 0 0 1 0 0.15 0.42 50]  
# place_inst "sky130_fd_pr__nfet_01v8_lvt" 0 -10 9 2 1 2 $params

# place_sky130_fd_pr__res_xhigh_po_2p85 0 0 2.850 31.52 17 22.132k 1