proc generate_workspace {args} {
	set hw 0
	set workspace "workspace"
	set source_dir 0
	set help 0
	set proc "microblaze_0"
	for {set i 0} {$i < [llength $args]} {incr i} {
		if {[lindex $args $i] == "-hw"} {
			set hw [lindex $args [expr {$i + 1}]]
			if {[file extension $hw] != ".xsa"} {
				set hw 0
			} else {
				set hw $hw
			}
		}
		if {[lindex $args $i] == "-workspace"} {
			set workspace [lindex $args [expr {$i + 1}]]
			if {[file exists $workspace] == 1} {
				file delete -force $workspace 
			}
		}
		if {[lindex $args $i] == "-proc"} {
                        set proc [lindex $args [expr {$i + 1}]]
                }
		if {[lindex $args $i] == "-src_dir"} {
			set source_dir [lindex $args [expr {$i + 1}]]
		}
		if {[lindex $args $i] == "-help"} {
			puts "generate_workspace -hw <path to xsa>.xsa"
			puts "optional -workspace <workspace name>: default workspace"
			puts "optional -src_dir <path to source directory>: default 0"
			puts "optional -proc <processor_type"
			set help 1
		}
	}
	if {$hw != 0} {
		setws $workspace
		platform create -name [file rootname [file tail $hw]]_platform_0 -hw $hw
		if {$source_dir != 0} {
			puts "Building app"
			domain create -name "app_domain" -os standalone -proc $proc
			app create -name [file rootname [file tail $source_dir]] -domain app_domain -template "Empty Application"
			importsources -name [file rootname [file tail $source_dir]] -path ${source_dir}
			app build -name [file rootname [file tail $source_dir]]
			sysproj build -name [file rootname [file tail $source_dir]]_system
		} else {
			puts "Building HelloWorld"
			domain create -name "app_domain" -os standalone -proc $proc
			app create -name "HelloWorld" -domain app_domain -template "Empty Application"
			app build -name "HelloWorld"
			sysproj build -name "HelloWorld_system"
		}
	} else {
		if {$help == 0} {
			puts "Please pass the XSA file. Use -help for more info"
			return 1
		} 
	}
}