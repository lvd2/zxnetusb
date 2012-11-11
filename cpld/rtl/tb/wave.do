onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb/rst_n
add wave -noupdate -format Logic /tb/clk
add wave -noupdate -divider <NULL>
add wave -noupdate -format Literal -radix hexadecimal /tb/a
add wave -noupdate -format Literal -radix hexadecimal /tb/d
add wave -noupdate -format Logic /tb/mreq_n
add wave -noupdate -format Logic /tb/iorq_n
add wave -noupdate -format Logic /tb/rd_n
add wave -noupdate -format Logic /tb/wr_n
add wave -noupdate -divider <NULL>
add wave -noupdate -format Logic /tb/brd_n
add wave -noupdate -format Logic /tb/bwr_n
add wave -noupdate -format Literal -radix hexadecimal /tb/bd
add wave -noupdate -divider <NULL>
add wave -noupdate -format Logic /tb/sl811_a0
add wave -noupdate -format Logic /tb/sl811_cs_n
add wave -noupdate -format Logic /tb/sl811_intrq
add wave -noupdate -format Logic /tb/sl811_ms_n
add wave -noupdate -format Logic /tb/sl811_rst_n
add wave -noupdate -divider <NULL>
add wave -noupdate -format Literal -radix hexadecimal /tb/w5300_addr
add wave -noupdate -format Logic /tb/w5300_cs_n
add wave -noupdate -format Logic /tb/w5300_int_n
add wave -noupdate -format Logic /tb/w5300_rst_n
add wave -noupdate -divider <NULL>
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {824 ns} 0}
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
configure wave -timeline 1
update
WaveRestoreZoom {0 ns} {1 us}
