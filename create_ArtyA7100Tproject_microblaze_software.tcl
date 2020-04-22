#openhw /home/peckc/artytest/artytest.sdk/design_1_wrapper.hdf
set project_name artytest
set project_location /home/peckc
set project_dir $project_location/$project_name
set sdk_dir $project_dir/$project_name.sdk

# execute this scipt with this command "xsdk -batch -source setup.tcl"
set hwspec $sdk_dir/design_1_wrapper.hdf
cd $sdk_dir
# delete the old
puts "cleaning up software files"
file delete -force ./.metadata
file delete -force ./hw
file delete -force ./fsbl_bsp
file delete -force ./fsbl
file delete -force ./pmufw_bsp
file delete -force ./pmufw


# Create workspace and import the project into
puts "creating workspace and importing project"
setws .

createhw -name hw -hwspec $hwspec

puts "creating test app"
createapp -name hello_world -app {Hello World} -proc microblaze_0 -hwproject hw -os standalone
# Create arm fsbl
#createapp -name fsbl -app {Zynq MP FSBL} -proc psu_cortexa53_0 -hwproject hw -os standalone
#configapp -app  fsbl define-compiler-symbols FSBL_DEBUG_INFO




# Create pmu firmware
#createapp -name pmufw -app {ZynqMP PMU Firmware} -proc psu_pmu_0 -hwproject hw -os standalone

# Clean and build all projects
projects -clean
projects -build

#puts "generating BOOT.bin from images"
#exec bootgen -arch zynqmp -w on -log trace -image output.bif -w -o BOOT.bin
#
#
#
puts "Programming FPGA"
exec updatemem -force -meminfo \
/home/peckc/artytest/artytest.sdk/design_1_wrapper_hw_platform_0/design_1_wrapper.mmi -bit \
/home/peckc/artytest/artytest.sdk/design_1_wrapper_hw_platform_0/design_1_wrapper.bit \
-data /opt/pkg/Xilinx/SDK/2018.3/data/embeddedsw/lib/microblaze/mb_bootloop_le.elf -proc \
design_1_i/microblaze_0 -out \
/home/peckc/artytest/artytest.sdk/design_1_wrapper_hw_platform_0/download.bit


exec updatemem -force -meminfo \
/home/peckc/artytest/artytest.sdk/design_1_wrapper_hw_platform_0/design_1_wrapper.mmi -bit \
/home/peckc/artytest/artytest.sdk/design_1_wrapper_hw_platform_0/design_1_wrapper.bit \
-data /opt/pkg/Xilinx/SDK/2018.3/data/embeddedsw/lib/microblaze/mb_bootloop_le.elf -proc \
design_1_i/microblaze_0 -out \
/home/peckc/artytest/artytest.sdk/design_1_wrapper_hw_platform_0/download.bit 
#
#
#
#
puts "Connecting to HW server"

#targets -set -nocase -filter {name =~ "xc7a100t"}
#need to program fpga here first
#
connect -url tcp:127.0.0.1:3121
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Arty A7-100T 210319A8C76FA"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "microblaze*#0" && bscan=="USER2"  && jtag_cable_name =~ "Digilent Arty A7-100T 210319A8C76FA"} -index 0
dow /home/peckc/artytest/artytest.sdk/hello_world/Debug/hello_world.elf
exit
