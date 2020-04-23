#-----------------------------------------------------------
# Vivado v2019.2.1 (64-bit)
#-----------------------------------------------------------
set project_name artytest
set project_location /home/peckc 
set project_dir $project_location/$project_name
#start_gui
cd $project_location
create_project $project_name $project_dir -part xc7a100tcsg324-1 -force
set_param board.repoPaths [list "/opt/pkg/Xilinx/Vivado/2019.2/data/boards/board_files/"]
set_property board_part digilentinc.com:arty-a7-100:part0:1.0 [current_project]
set_property target_language VHDL [current_project]
update_ip_catalog
create_bd_design "design_1" -verbose
update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
apply_board_connection -board_interface "sys_clock" -ip_intf "clk_wiz_0/clock_CLK_IN1" -diagram "design_1" 
endgroup
startgroup
set_property -dict [list CONFIG.CLKOUT2_USED {true} CONFIG.CLKOUT3_USED {true} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {166.667} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {200} CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {25} CONFIG.RESET_TYPE {ACTIVE_LOW} CONFIG.MMCM_DIVCLK_DIVIDE {1} CONFIG.MMCM_CLKOUT0_DIVIDE_F {6.000} CONFIG.MMCM_CLKOUT1_DIVIDE {5} CONFIG.MMCM_CLKOUT2_DIVIDE {40} CONFIG.NUM_OUT_CLKS {3} CONFIG.RESET_PORT {resetn} CONFIG.CLKOUT1_JITTER {118.758} CONFIG.CLKOUT2_JITTER {114.829} CONFIG.CLKOUT2_PHASE_ERROR {98.575} CONFIG.CLKOUT3_JITTER {175.402} CONFIG.CLKOUT3_PHASE_ERROR {98.575}] [get_bd_cells clk_wiz_0]
endgroup
startgroup
make_bd_pins_external  [get_bd_pins clk_wiz_0/clk_out3]
endgroup
set_property name eth_ref_clk [get_bd_ports clk_out3_0]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Board_Interface {reset ( System Reset ) } Manual_Source {New External Port (ACTIVE_LOW)}}  [get_bd_pins clk_wiz_0/resetn]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series:4.2 mig_7series_0
apply_board_connection -board_interface "ddr3_sdram" -ip_intf "mig_7series_0/mig_ddr_interface" -diagram "design_1" 
endgroup
delete_bd_objs [get_bd_nets clk_ref_i_1] [get_bd_ports clk_ref_i]
delete_bd_objs [get_bd_nets sys_clk_i_1] [get_bd_ports sys_clk_i]
connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins mig_7series_0/sys_clk_i]
connect_bd_net [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins mig_7series_0/clk_ref_i]
connect_bd_net [get_bd_ports reset] [get_bd_pins mig_7series_0/sys_rst]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:microblaze -config { axi_intc {1} axi_periph {Enabled} cache {32KB} clk {/mig_7series_0/ui_clk (83 MHz)} debug_module {Debug Only} ecc {None} local_mem {64KB} preset {Application}}  [get_bd_cells microblaze_0]
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/mig_7series_0/ui_clk (83 MHz)} Clk_slave {/mig_7series_0/ui_clk (83 MHz)} Clk_xbar {/mig_7series_0/ui_clk (83 MHz)} Master {/microblaze_0 (Cached)} Slave {/mig_7series_0/S_AXI} intc_ip {Auto} master_apm {0}}  [get_bd_intf_pins mig_7series_0/S_AXI]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 axi_ethernetlite_0
apply_board_connection -board_interface "eth_mii" -ip_intf "axi_ethernetlite_0/MII" -diagram "design_1" 
apply_board_connection -board_interface "eth_mdio_mdc" -ip_intf "axi_ethernetlite_0/MDIO" -diagram "design_1" 
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0
apply_board_connection -board_interface "qspi_flash" -ip_intf "axi_quad_spi_0/SPI_0" -diagram "design_1" 
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0
apply_board_connection -board_interface "led_4bits" -ip_intf "axi_gpio_0/GPIO" -diagram "design_1" 
endgroup
apply_board_connection -board_interface "push_buttons_4bits" -ip_intf "axi_gpio_0/GPIO2" -diagram "design_1" 
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_1
apply_board_connection -board_interface "rgb_led" -ip_intf "axi_gpio_1/GPIO" -diagram "design_1" 
endgroup
apply_board_connection -board_interface "dip_switches_4bits" -ip_intf "axi_gpio_1/GPIO2" -diagram "design_1" 
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0
apply_board_connection -board_interface "usb_uart" -ip_intf "axi_uartlite_0/UART" -diagram "design_1" 
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0
endgroup
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/mig_7series_0/ui_clk (83 MHz)} Clk_slave {Auto} Clk_xbar {/mig_7series_0/ui_clk(83 MHz)} Master {/microblaze_0 (Periph)} Slave {/axi_ethernetlite_0/S_AXI} intc_ip {/microblaze_0_axi_periph} master_apm {0}}  [get_bd_intf_pins axi_ethernetlite_0/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/mig_7series_0/ui_clk (83 MHz)} Clk_slave {Auto} Clk_xbar {/mig_7series_0/ui_clk(83 MHz)} Master {/microblaze_0 (Periph)} Slave {/axi_quad_spi_0/AXI_LITE} intc_ip {/microblaze_0_axi_periph} master_apm {0}}  [get_bd_intf_pins axi_quad_spi_0/AXI_LITE]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config {Clk "/mig_7series_0/ui_clk (83 MHz)" }  [get_bd_pins axi_quad_spi_0/ext_spi_clk]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/mig_7series_0/ui_clk (83 MHz)} Clk_slave {Auto} Clk_xbar {/mig_7series_0/ui_clk(83 MHz)} Master {/microblaze_0 (Periph)} Slave {/axi_gpio_0/S_AXI} intc_ip {/microblaze_0_axi_periph} master_apm {0}}  [get_bd_intf_pins axi_gpio_0/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/mig_7series_0/ui_clk (83 MHz)} Clk_slave {Auto} Clk_xbar {/mig_7series_0/ui_clk(83 MHz)} Master {/microblaze_0 (Periph)} Slave {/axi_gpio_1/S_AXI} intc_ip {/microblaze_0_axi_periph} master_apm {0}}  [get_bd_intf_pins axi_gpio_1/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/mig_7series_0/ui_clk (83 MHz)} Clk_slave {Auto} Clk_xbar {/mig_7series_0/ui_clk(83 MHz)} Master {/microblaze_0 (Periph)} Slave {/axi_uartlite_0/S_AXI} intc_ip {/microblaze_0_axi_periph} master_apm {0}}  [get_bd_intf_pins axi_uartlite_0/S_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/mig_7series_0/ui_clk (83 MHz)} Clk_slave {Auto} Clk_xbar {/mig_7series_0/ui_clk(83 MHz)} Master {/microblaze_0 (Periph)} Slave {/axi_timer_0/S_AXI} intc_ip {/microblaze_0_axi_periph} master_apm {0}}  [get_bd_intf_pins axi_timer_0/S_AXI]
endgroup
startgroup
set_property -dict [list CONFIG.NUM_PORTS {6}] [get_bd_cells microblaze_0_xlconcat]
endgroup
connect_bd_net [get_bd_pins axi_ethernetlite_0/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In0]
connect_bd_net [get_bd_pins axi_quad_spi_0/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In1]
connect_bd_net [get_bd_pins axi_uartlite_0/interrupt] [get_bd_pins microblaze_0_xlconcat/In2]
connect_bd_net [get_bd_pins axi_timer_0/interrupt] [get_bd_pins microblaze_0_xlconcat/In3]
startgroup
set_property -dict [list CONFIG.G_TEMPLATE_LIST {4} CONFIG.C_USE_FPU {0} CONFIG.C_FPU_EXCEPTION {0} CONFIG.C_NUMBER_OF_PC_BRK {1} CONFIG.C_NUMBER_OF_RD_ADDR_BRK {0} CONFIG.C_NUMBER_OF_WR_ADDR_BRK {0} CONFIG.C_ADDR_TAG_BITS {16} CONFIG.C_CACHE_BYTE_SIZE {16384} CONFIG.C_DCACHE_ADDR_TAG {16} CONFIG.C_DCACHE_BYTE_SIZE {16384} CONFIG.C_DCACHE_USE_WRITEBACK {0} CONFIG.C_DCACHE_VICTIMS {8}] [get_bd_cells microblaze_0]
endgroup
startgroup
set_property -dict [list CONFIG.C_INTERRUPT_PRESENT {1}] [get_bd_cells axi_gpio_1]
endgroup
startgroup
set_property -dict [list CONFIG.C_INTERRUPT_PRESENT {1}] [get_bd_cells axi_gpio_0]
endgroup
connect_bd_net [get_bd_pins axi_gpio_0/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In4]
connect_bd_net [get_bd_pins axi_gpio_1/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In5]
save_bd_design
make_wrapper -files [get_files $project_dir/$project_name.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files $project_dir/$project_name.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.vhd
update_compile_order -fileset sources_1
save_bd_design
launch_runs synth_1 -jobs 2
wait_on_run synth_1
open_run synth_1 -name synth_1

set_property IOSTANDARD LVCMOS33 [get_ports eth_ref_clk]
set_property PACKAGE_PIN G18 [get_ports eth_ref_clk]
file mkdir $project_dir/$project_name.srcs/constrs_1
file mkdir $project_dir/$project_name.srcs/constrs_1/new
#close [ open $project_dir/$project_name.srcs/constrs_1/new/constraints.xdc w ]
write_xdc $project_dir/$project_name.srcs/constrs_1/new/constraints.xdc
add_files -fileset constrs_1 -norecurse $project_dir/$project_name.srcs/constrs_1/new/constraints.xdc

create_ip_run [get_files -of_objects [get_fileset sources_1] $project_dir/$project_name.srcs/sources_1/bd/design_1/design_1.bd]
refresh_design

launch_runs impl_1 -jobs 2
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 2
wait_on_run impl_1

# following line for pre 2019.2
#write_sysdef -force -hwdef $project_name.runs/synth_1/design_1_wrapper.hwdef -bitfile $project_name/$project_name.runs/impl_1/design_1_wrapper.bit -file $project_name/$project_name.runs/impl_1/design_1_wrapper.sysdef
# follwoing for newer systems without SDK that use vitis
write_hw_platform -fixed -force -file $project_name/$project_name.runs/impl_1/design_1_wrapper.xsa
#file mkdir $project_dir/$project_name.sdk
#file copy -force $project_dir/$project_name.runs/impl_1/design_1_wrapper.sysdef $project_dir/$project_name.sdk/design_1_wrapper.hdf
#save_project_as $project_dir/$project_name
file mkdir $project_dir/$project_name.vitis
file copy -force $project_dir/$project_name.runs/impl_1/design_1_wrapper.xsa $project_dir/$project_name.vitis/design_1_wrapper.xsa

exit
