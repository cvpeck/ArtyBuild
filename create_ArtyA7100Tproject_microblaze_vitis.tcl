platform create -name {artytest_vitis} -hw {/home/peckc/artytest/artytest.vitis/design_1_wrapper.xsa} -proc {microblaze_0} -os {linux} -out {/home/peckc/artytest};platform write
platform read {/home/peckc/artytest/artytest_vitis/platform.spr}
platform active {artytest_vitis}

