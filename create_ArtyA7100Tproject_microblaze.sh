#!/bin/bash


export vivado_project_name myArtyA7100T_microblaze_test
export vivado_project_location ~ 


echo "Setting up following environment variables"
echo "Petalinux_Installation_Path=/opt/petalinux"
export Petalinux_Installation_Path=/opt/pkg/PetaLinux
#echo "SDK_Installation_Path=/opt/pkg/Xilinx/SDK/2019.2"
#echo ""
#export SDK_Installation_Path=/opt/pkg/Xilinx/SDK/2019.2
#echo ""
#echo "Sourcing vivado environment"
source /opt/pkg/Xilinx/Vivado/2019.2/settings64.sh
cmd="vivado -mode tcl -source ${0%.*}.tcl &"
echo "Executing $cmd"
$cmd

xsct create_ArtyA7100Tproject_microblaze_vitis.tcl
