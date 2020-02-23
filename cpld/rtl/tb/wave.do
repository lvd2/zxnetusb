onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/fclk
add wave -noupdate /tb/rst_n
add wave -noupdate /tb/clk
add wave -noupdate -divider <NULL>
add wave -noupdate -radix hexadecimal /tb/a
add wave -noupdate -radix hexadecimal -childformat {{{/tb/d[7]} -radix hexadecimal} {{/tb/d[6]} -radix hexadecimal} {{/tb/d[5]} -radix hexadecimal} {{/tb/d[4]} -radix hexadecimal} {{/tb/d[3]} -radix hexadecimal} {{/tb/d[2]} -radix hexadecimal} {{/tb/d[1]} -radix hexadecimal} {{/tb/d[0]} -radix hexadecimal}} -subitemconfig {{/tb/d[7]} {-radix hexadecimal} {/tb/d[6]} {-radix hexadecimal} {/tb/d[5]} {-radix hexadecimal} {/tb/d[4]} {-radix hexadecimal} {/tb/d[3]} {-radix hexadecimal} {/tb/d[2]} {-radix hexadecimal} {/tb/d[1]} {-radix hexadecimal} {/tb/d[0]} {-radix hexadecimal}} /tb/d
add wave -noupdate /tb/mreq_n
add wave -noupdate /tb/iorq_n
add wave -noupdate /tb/rd_n
add wave -noupdate /tb/wr_n
add wave -noupdate /tb/int_n
add wave -noupdate /tb/blkrom
add wave -noupdate /tb/iorqge
add wave -noupdate /tb/csrom_n
add wave -noupdate -divider <NULL>
add wave -noupdate -radix hexadecimal /tb/where_rom
add wave -noupdate /tb/usb_power
add wave -noupdate -divider <NULL>
add wave -noupdate /tb/brd_n
add wave -noupdate /tb/bwr_n
add wave -noupdate -radix hexadecimal /tb/bd
add wave -noupdate -divider <NULL>
add wave -noupdate /tb/sl811_a0
add wave -noupdate /tb/sl811_cs_n
add wave -noupdate /tb/sl811_intrq
add wave -noupdate /tb/sl811_ms_n
add wave -noupdate /tb/sl811_rst_n
add wave -noupdate /tb/s/rd
add wave -noupdate /tb/s/wr
add wave -noupdate -divider <NULL>
add wave -noupdate /tb/s/rst_n
add wave -noupdate /tb/s/a0
add wave -noupdate /tb/s/cs_n
add wave -noupdate /tb/s/rd_n
add wave -noupdate /tb/s/wr_n
add wave -noupdate /tb/s/ms
add wave -noupdate /tb/s/intrq
add wave -noupdate -radix hexadecimal /tb/s/d
add wave -noupdate /tb/s/access_addr
add wave -noupdate /tb/s/access_rnw
add wave -noupdate -radix hexadecimal /tb/s/wr_data
add wave -noupdate -radix hexadecimal /tb/s/rd_data
add wave -noupdate /tb/s/rd
add wave -noupdate /tb/s/wr
add wave -noupdate -divider <NULL>
add wave -noupdate /tb/DUT/ports/w5300_ports
add wave -noupdate /tb/DUT/ports/w5300_hi
add wave -noupdate -divider <NULL>
add wave -noupdate -radix hexadecimal -childformat {{{/tb/w5300_addr[9]} -radix hexadecimal} {{/tb/w5300_addr[8]} -radix hexadecimal} {{/tb/w5300_addr[7]} -radix hexadecimal} {{/tb/w5300_addr[6]} -radix hexadecimal} {{/tb/w5300_addr[5]} -radix hexadecimal} {{/tb/w5300_addr[4]} -radix hexadecimal} {{/tb/w5300_addr[3]} -radix hexadecimal} {{/tb/w5300_addr[2]} -radix hexadecimal} {{/tb/w5300_addr[1]} -radix hexadecimal} {{/tb/w5300_addr[0]} -radix hexadecimal}} -subitemconfig {{/tb/w5300_addr[9]} {-radix hexadecimal} {/tb/w5300_addr[8]} {-radix hexadecimal} {/tb/w5300_addr[7]} {-radix hexadecimal} {/tb/w5300_addr[6]} {-radix hexadecimal} {/tb/w5300_addr[5]} {-radix hexadecimal} {/tb/w5300_addr[4]} {-radix hexadecimal} {/tb/w5300_addr[3]} {-radix hexadecimal} {/tb/w5300_addr[2]} {-radix hexadecimal} {/tb/w5300_addr[1]} {-radix hexadecimal} {/tb/w5300_addr[0]} {-radix hexadecimal}} /tb/w5300_addr
add wave -noupdate /tb/w5300_cs_n
add wave -noupdate /tb/w5300_int_n
add wave -noupdate /tb/w5300_rst_n
add wave -noupdate /tb/w/rd
add wave -noupdate /tb/w/wr
add wave -noupdate -divider <NULL>
add wave -noupdate /tb/w/rst_n
add wave -noupdate -radix hexadecimal /tb/w/addr
add wave -noupdate /tb/w/cs_n
add wave -noupdate /tb/w/rd_n
add wave -noupdate /tb/w/wr_n
add wave -noupdate /tb/w/int_n
add wave -noupdate -radix hexadecimal /tb/w/d
add wave -noupdate -radix hexadecimal /tb/w/access_addr
add wave -noupdate /tb/w/access_rnw
add wave -noupdate -radix hexadecimal /tb/w/rd_data
add wave -noupdate -radix hexadecimal /tb/w/wr_data
add wave -noupdate /tb/w/rd
add wave -noupdate /tb/w/wr
add wave -noupdate -divider <NULL>
add wave -noupdate /tb/DUT/fclk
add wave -noupdate /tb/DUT/usb_clk
add wave -noupdate /tb/DUT/usb_ckreg
add wave -noupdate -radix hexadecimal /tb/DUT/za
add wave -noupdate -radix hexadecimal /tb/DUT/zd
add wave -noupdate -radix hexadecimal /tb/DUT/bd
add wave -noupdate /tb/DUT/ziorq_n
add wave -noupdate /tb/DUT/zrd_n
add wave -noupdate /tb/DUT/zwr_n
add wave -noupdate /tb/DUT/zmreq_n
add wave -noupdate /tb/DUT/ziorqge
add wave -noupdate /tb/DUT/zblkrom
add wave -noupdate /tb/DUT/zcsrom_n
add wave -noupdate /tb/DUT/zrst_n
add wave -noupdate /tb/DUT/zint_n
add wave -noupdate /tb/DUT/brd_n
add wave -noupdate /tb/DUT/bwr_n
add wave -noupdate /tb/DUT/w5300_rst_n
add wave -noupdate /tb/DUT/w5300_addr
add wave -noupdate /tb/DUT/w5300_cs_n
add wave -noupdate /tb/DUT/w5300_int_n
add wave -noupdate /tb/DUT/sl811_rst_n
add wave -noupdate /tb/DUT/sl811_intrq
add wave -noupdate /tb/DUT/sl811_ms_n
add wave -noupdate /tb/DUT/sl811_cs_n
add wave -noupdate /tb/DUT/sl811_a0
add wave -noupdate /tb/DUT/usb_power
add wave -noupdate /tb/DUT/pre_brd_n
add wave -noupdate /tb/DUT/bwr_n_r
add wave -noupdate /tb/DUT/bwr_n_rr
add wave -noupdate /tb/DUT/shreg
add wave -noupdate /tb/DUT/ena_w5300_int
add wave -noupdate /tb/DUT/ena_sl811_int
add wave -noupdate /tb/DUT/ena_zxbus_int
add wave -noupdate /tb/DUT/internal_int
add wave -noupdate /tb/DUT/ports_wrdata
add wave -noupdate /tb/DUT/ports_rddata
add wave -noupdate /tb/DUT/ports_addr
add wave -noupdate /tb/DUT/ports_wrena
add wave -noupdate /tb/DUT/ports_wrstb_n
add wave -noupdate /tb/DUT/rommap_win
add wave -noupdate /tb/DUT/rommap_ena
add wave -noupdate /tb/DUT/w5300_a0inv
add wave -noupdate /tb/DUT/w5300_ports
add wave -noupdate /tb/DUT/w5300_hi
add wave -noupdate /tb/DUT/pre_w5300_addr
add wave -noupdate -divider <NULL>
add wave -noupdate /tb/DUT/zbus/fclk
add wave -noupdate -radix hexadecimal /tb/DUT/zbus/za
add wave -noupdate -radix hexadecimal /tb/DUT/zbus/zd
add wave -noupdate -radix hexadecimal /tb/DUT/zbus/bd
add wave -noupdate /tb/DUT/zbus/ziorq_n
add wave -noupdate /tb/DUT/zbus/zrd_n
add wave -noupdate /tb/DUT/zbus/zwr_n
add wave -noupdate /tb/DUT/zbus/zmreq_n
add wave -noupdate /tb/DUT/zbus/ziorqge
add wave -noupdate /tb/DUT/zbus/zblkrom
add wave -noupdate /tb/DUT/zbus/zcsrom_n
add wave -noupdate /tb/DUT/zbus/zrst_n
add wave -noupdate /tb/DUT/zbus/ports_wrena
add wave -noupdate /tb/DUT/zbus/ports_wrstb_n
add wave -noupdate -radix hexadecimal /tb/DUT/zbus/ports_addr
add wave -noupdate -radix hexadecimal /tb/DUT/zbus/ports_wrdata
add wave -noupdate -radix hexadecimal /tb/DUT/zbus/ports_rddata
add wave -noupdate /tb/DUT/zbus/rommap_win
add wave -noupdate /tb/DUT/zbus/rommap_ena
add wave -noupdate /tb/DUT/zbus/sl811_cs_n
add wave -noupdate /tb/DUT/zbus/sl811_a0
add wave -noupdate /tb/DUT/zbus/w5300_cs_n
add wave -noupdate /tb/DUT/zbus/w5300_ports
add wave -noupdate -radix hexadecimal /tb/DUT/zbus/async_w5300_addr
add wave -noupdate -radix hexadecimal /tb/DUT/zbus/w5300_addr
add wave -noupdate /tb/DUT/zbus/bwr_n
add wave -noupdate /tb/DUT/zbus/brd_n
add wave -noupdate /tb/DUT/zbus/io_addr_ok
add wave -noupdate /tb/DUT/zbus/mrd
add wave -noupdate /tb/DUT/zbus/mwr
add wave -noupdate /tb/DUT/zbus/ena_dbuf
add wave -noupdate /tb/DUT/zbus/ena_din
add wave -noupdate /tb/DUT/zbus/ena_dout
add wave -noupdate /tb/DUT/zbus/async_w5300_cs_n
add wave -noupdate /tb/DUT/zbus/async_sl811_cs_n
add wave -noupdate /tb/DUT/zbus/r_w5300_cs_n
add wave -noupdate /tb/DUT/zbus/r_sl811_cs_n
add wave -noupdate /tb/DUT/zbus/async_sl811_a0
add wave -noupdate /tb/DUT/zbus/r_sl811_a0
add wave -noupdate /tb/DUT/zbus/wr_regs
add wave -noupdate /tb/DUT/zbus/rd_regs
add wave -noupdate /tb/DUT/zbus/wr_state
add wave -noupdate /tb/DUT/zbus/rd_state
add wave -noupdate /tb/DUT/zbus/wr_start
add wave -noupdate /tb/DUT/zbus/rd_start
add wave -noupdate -radix unsigned /tb/DUT/zbus/ctr_5
add wave -noupdate -radix hexadecimal /tb/DUT/zbus/read_latch
add wave -noupdate -radix hexadecimal /tb/DUT/zbus/write_latch
add wave -noupdate /tb/DUT/zbus/ports_rd
add wave -noupdate /tb/DUT/zbus/b_ena_dbuf
add wave -noupdate /tb/DUT/zbus/b_ena_din
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3203200 ps} 0}
configure wave -namecolwidth 257
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 208
configure wave -griddelta 8
configure wave -timeline 1
configure wave -timelineunits ns
update
WaveRestoreZoom {2937100 ps} {3419700 ps}
