onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk
add wave -noupdate /tb/rst_n
add wave -noupdate -divider <NULL>
add wave -noupdate /tb/mreq_n
add wave -noupdate /tb/iorq_n
add wave -noupdate /tb/rd_n
add wave -noupdate /tb/wr_n
add wave -noupdate -radix hexadecimal /tb/a
add wave -noupdate -radix hexadecimal /tb/d
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 150
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
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {990 ns}
