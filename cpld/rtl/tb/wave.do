onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 15 /tb/fclk
add wave -noupdate -height 15 /tb/rst_n
add wave -noupdate -height 15 /tb/clk
add wave -noupdate -divider <NULL>
add wave -noupdate -height 15 -radix hexadecimal /tb/a
add wave -noupdate -height 15 -radix hexadecimal -childformat {{{/tb/d[7]} -radix hexadecimal} {{/tb/d[6]} -radix hexadecimal} {{/tb/d[5]} -radix hexadecimal} {{/tb/d[4]} -radix hexadecimal} {{/tb/d[3]} -radix hexadecimal} {{/tb/d[2]} -radix hexadecimal} {{/tb/d[1]} -radix hexadecimal} {{/tb/d[0]} -radix hexadecimal}} -subitemconfig {{/tb/d[7]} {-height 15 -radix hexadecimal} {/tb/d[6]} {-height 15 -radix hexadecimal} {/tb/d[5]} {-height 15 -radix hexadecimal} {/tb/d[4]} {-height 15 -radix hexadecimal} {/tb/d[3]} {-height 15 -radix hexadecimal} {/tb/d[2]} {-height 15 -radix hexadecimal} {/tb/d[1]} {-height 15 -radix hexadecimal} {/tb/d[0]} {-height 15 -radix hexadecimal}} /tb/d
add wave -noupdate -height 15 /tb/mreq_n
add wave -noupdate -height 15 /tb/iorq_n
add wave -noupdate -height 15 /tb/rd_n
add wave -noupdate -height 15 /tb/wr_n
add wave -noupdate -height 15 /tb/int_n
add wave -noupdate -height 15 /tb/blkrom
add wave -noupdate -height 15 /tb/iorqge
add wave -noupdate -height 15 /tb/csrom_n
add wave -noupdate -divider <NULL>
add wave -noupdate -height 15 -radix hexadecimal /tb/where_rom
add wave -noupdate -height 15 /tb/usb_power
add wave -noupdate -divider <NULL>
add wave -noupdate -height 15 /tb/brd_n
add wave -noupdate -height 15 /tb/bwr_n
add wave -noupdate -height 15 -radix hexadecimal /tb/bd
add wave -noupdate -divider <NULL>
add wave -noupdate -height 15 /tb/sl811_a0
add wave -noupdate -height 15 /tb/sl811_cs_n
add wave -noupdate -height 15 /tb/sl811_intrq
add wave -noupdate -height 15 /tb/sl811_ms_n
add wave -noupdate -height 15 /tb/sl811_rst_n
add wave -noupdate -height 15 /tb/s/rd
add wave -noupdate -height 15 /tb/s/wr
add wave -noupdate -divider <NULL>
add wave -noupdate -height 15 /tb/DUT/ports/w5300_ports
add wave -noupdate -height 15 /tb/DUT/ports/w5300_hi
add wave -noupdate -divider <NULL>
add wave -noupdate -height 15 -radix hexadecimal /tb/w5300_addr
add wave -noupdate -height 15 /tb/w5300_cs_n
add wave -noupdate -height 15 /tb/w5300_int_n
add wave -noupdate -height 15 /tb/w5300_rst_n
add wave -noupdate -height 15 /tb/w/rd
add wave -noupdate -height 15 /tb/w/wr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6539055 ns} 0}
configure wave -namecolwidth 257
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 70
configure wave -griddelta 8
configure wave -timeline 1
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {825 ns}
