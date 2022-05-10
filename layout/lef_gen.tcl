# in magic, alway draw a box and use key "s" to select 
# the exact inst before running this proc function 
proc addlef {inst_name output_folder} {
    select clear
    append inst_name "_flat"
    flatten $inst_name
    load $inst_name
    box -1000 -1000 1000 1000
    select cell
    set box_pos [box position]    
    set llx [lindex $box_pos 0]    
    set lly [lindex $box_pos 1]    
    move origin right [expr $llx/2]  
    move origin bottom [expr -$lly/2-30]
    puts "Now the origin is:"    
    box
    # Property add here 
    property LEFclass CORE 
    property LEFsite unitasc
    
    if {$inst_name=={pmos_1_flat}} {
        property FIXED_BBOX {0 0 686 1880}
        # GATE
        findlabel GATE
        port GATE make "nsew"
        port class inout
        port use signal 
        # SOURCE
        findlabel SOURCE
        port SOURCE make "nsew"
        port class inout 
        port use signal 
        # DRAIN
        findlabel DRAIN
        port DRAIN make "nsew"
        port class inout 
        port use signal 
        # # VPB
        # findlabel VPB
        # port make
        # port class inout
        # port use power  
        # VPWR
        findlabel VPWR
        port VPWR make "nsew"
        port class bidirectional
        port use power
        # VGND
        findlabel VGND
        port VGND make "nsew"
        port class bidirectional
        port use ground
        # set mag_file [file join a b $output_folder sky130_asc_pfet_01v8_lvt_1.mag] 
        # set lef_file [file join a b $output_folder sky130_asc_pfet_01v8_lvt_1.lef]
        cd $output_folder
        cd ./mag
        save sky130_asc_pfet_01v8_lvt_1.mag
        cd ../lef
        lef write sky130_asc_pfet_01v8_lvt_1.lef
        cd ../gds
        gds write sky130_asc_pfet_01v8_lvt_1.gds
        cd ../spi
        extract all
        ext2spice lvs
        ext2spice -o sky130_asc_pfet_01v8_lvt_1.spice
        # puts "mag_file: $mag_file"
        # puts "lef_file: $lef_file"
        # save $mag_file
        # lef write $lef_file
    } elseif {$inst_name=={pmos_12_flat}} {
        property FIXED_BBOX {0 0 5723 1880}
        # GATE
        findlabel GATE
        port GATE make "nsew"
        port class inout
        port use signal 
        # SOURCE
        findlabel SOURCE
        port SOURCE make "nsew"
        port class inout 
        port use signal 
        # DRAIN
        findlabel DRAIN
        port DRAIN make "nsew"
        port class inout 
        port use signal 
        # # VPB
        # findlabel VPB
        # port make
        # port class inout
        # port use power  
        # VPWR
        findlabel VPWR
        port VPWR make "nsew"
        port class bidirectional
        port use power
        # VGND
        findlabel VGND
        port VGND make "nsew"
        port class bidirectional
        port use ground
        # set mag_file [file join a b $output_folder sky130_asc_pfet_01v8_lvt_1.mag] 
        # set lef_file [file join a b $output_folder sky130_asc_pfet_01v8_lvt_1.lef]
        cd $output_folder
        cd ./mag
        save sky130_asc_pfet_01v8_lvt_12.mag
        cd ../lef
        lef write sky130_asc_pfet_01v8_lvt_12.lef
        cd ../gds
        gds write sky130_asc_pfet_01v8_lvt_12.gds
        cd ../spi
        extract all
        ext2spice lvs
        ext2spice -o sky130_asc_pfet_01v8_lvt_12.spice
        # puts "mag_file: $mag_file"
        # puts "lef_file: $lef_file"
        # save $mag_file
        # lef write $lef_file
    } elseif {$inst_name=={pmos_60_flat}} {
        property FIXED_BBOX {0 0 27707 1880}
        # GATE
        findlabel GATE
        port GATE make "nsew"
        port class inout
        port use signal 
        # SOURCE
        findlabel SOURCE
        port SOURCE make "nsew"
        port class inout 
        port use signal 
        # DRAIN
        findlabel DRAIN
        port DRAIN make "nsew"
        port class inout 
        port use signal 
        # # VPB
        # findlabel VPB
        # port make
        # port class inout
        # port use power  
        # VPWR
        findlabel VPWR
        port VPWR make "nsew"
        port class bidirectional
        port use power
        # VGND
        findlabel VGND
        port VGND make "nsew"
        port class bidirectional
        port use ground
        # set mag_file [file join a b $output_folder sky130_asc_pfet_01v8_lvt_1.mag] 
        # set lef_file [file join a b $output_folder sky130_asc_pfet_01v8_lvt_1.lef]
        cd $output_folder
        cd ./mag
        save sky130_asc_pfet_01v8_lvt_60.mag
        cd ../lef
        lef write sky130_asc_pfet_01v8_lvt_60.lef
        cd ../gds
        gds write sky130_asc_pfet_01v8_lvt_60.gds
        cd ../spi
        extract all
        ext2spice lvs
        ext2spice -o sky130_asc_pfet_01v8_lvt_60.spice
        # puts "mag_file: $mag_file"
        # puts "lef_file: $lef_file"
        # save $mag_file
        # lef write $lef_file
    } elseif {$inst_name=={nmos_1_flat}} {
        property FIXED_BBOX {0 0 614 1880}
        # GATE
        findlabel GATE
        port make 
        port class inout
        # SOURCE
        findlabel SOURCE
        port make 
        port class inout
        # DRAIN
        findlabel DRAIN
        port make 
        port class inout
        # # VNB
        # findlabel VNB
        # port make 
        # port class inout
        # port use ground
        # VPWR
        findlabel VPWR
        port make 
        port class inout
        port use power
        # VGND
        findlabel VGND
        port make 
        port class inout
        port use ground
        cd $output_folder
        cd ./mag
        save sky130_asc_nfet_01v8_lvt_1.mag
        cd ../lef
        lef write sky130_asc_nfet_01v8_lvt_1.lef
        cd ../gds
        gds write sky130_asc_nfet_01v8_lvt_1.gds
        cd ../spi
        extract all
        ext2spice lvs
        ext2spice -o sky130_asc_nfet_01v8_lvt_1.spice
    } elseif {$inst_name=={res_1_flat}} {
        property FIXED_BBOX {0 0 2440 1880}
        # Rin
        findlabel Rin
        port make
        port class inout
        # Rout
        findlabel Rout
        port make
        port class inout
        # VPWR
        findlabel VPWR
        port make 
        port class inout
        port use power
        # VGND
        findlabel VGND
        port make 
        port class inout
        port use ground
        cd $output_folder
        cd ./mag
        save sky130_asc_res_xhigh_po_2p85_1.mag
        cd ../lef
        lef write sky130_asc_res_xhigh_po_2p85_1.lef
        cd ../gds
        gds write sky130_asc_res_xhigh_po_2p85_1.gds
        cd ../spi
        extract all
        ext2spice lvs
        ext2spice -o sky130_asc_res_xhigh_po_2p85_1.spice
    } elseif {$inst_name=={res_2_flat}} {
        property FIXED_BBOX {0 0 3014 1880}
        # Rin
        findlabel Rin
        port make
        port class inout
        # Rout
        findlabel Rout
        port make
        port class inout
        # VPWR
        findlabel VPWR
        port make 
        port class inout
        port use power
        # VGND
        findlabel VGND
        port make 
        port class inout
        port use ground
        cd $output_folder
        cd ./mag
        save sky130_asc_res_xhigh_po_2p85_2.mag
        cd ../lef
        lef write sky130_asc_res_xhigh_po_2p85_2.lef
        cd ../gds
        gds write sky130_asc_res_xhigh_po_2p85_2.gds
        cd ../spi
        extract all
        ext2spice lvs
        ext2spice -o sky130_asc_res_xhigh_po_2p85_2.spice
    } elseif {$inst_name=={cap_1_flat}} {
        property FIXED_BBOX {0 0 7171 1880}
        # c0
        findlabel Cin
        port make 
        port class inout
        # c1 
        findlabel Cout
        port make 
        port class inout
        # VPWR
        findlabel VPWR
        port make 
        port class inout
        port use power
        # VGND
        findlabel VGND
        port make 
        port class inout
        port use ground
        cd $output_folder
        cd ./mag
        save sky130_fd_pr__cap_mim_m3_1.mag
        cd ../lef
        lef write sky130_fd_pr__cap_mim_m3_1.lef
        cd ../gds
        gds write sky130_fd_pr__cap_mim_m3_1.gds
        cd ../spi
        extract all
        ext2spice lvs
        ext2spice -o sky130_fd_pr__cap_mim_m3_1.spice
    } else {
        puts "No inst lef generated ..."
    }
}
