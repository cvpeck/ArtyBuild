#!/bin/bash


vivado_project_name="myArtyA7100T_microblaze_test"
vivado_project_location="~"
xilinx_version="2019.2"
base="/opt/pkg/Xilinx"

echo "Setting up following environment variables"
echo "Petalinux_Installation_Path=/opt/petalinux"
export Petalinux_Installation_Path=/opt/pkg/PetaLinux
#echo ""
echo "Sourcing vivado environment"
source $base/Vivado/$xilinx_version/settings64.sh
echo "Sourcing vitis environment"
source $base/Vitis/$xilinx_version/settings64.sh
#the following line runs the tcl file with the same name as this script"
cmd="vivado -mode tcl -source ${0%.*}.tcl"
echo "Executing $cmd"
$cmd
echo "Vivado build complete"

echo "Starting Vitis build"
cmd="xsct ${0%.*}_vitis.tcl"
echo "Executing $cmd"
$cmd
echo "Completed vitrification"


