# ================================
# TCL SCRIPT: Scan .coe files
# ================================

# Set your .coe directory
set coe_dir "C:/Users/41536/Desktop/ELM_auto/ELM_auto/ELM_auto.srcs/sources_1/new"

# How many .coe files you expect
set num_coe_l1 50
set num_coe_l2 2

puts "🔎 Scanning .coe files in $coe_dir..."

# Loop over all expected .coe files
for {set i 0} {$i < $num_coe_l1} {incr i} {
    set coe_file "$coe_dir/Weight_mem_1_${i}.coe"

    # Check if file exists
    if {![file exists $coe_file]} {
        puts "❌ ERROR: Missing COE file: $coe_file"
        continue
    }

    # Check if file is empty
    set file_size [file size $coe_file]
    if {$file_size == 0} {
        puts "❌ ERROR: Empty COE file: $coe_file"
        continue
    }

    # Open and check basic content
    set fh [open $coe_file r]
    set content [read $fh]
    close $fh

    if {![regexp {memory_initialization_vector} $content]} {
        puts "❌ ERROR: Bad format (missing vector) in: $coe_file"
        continue
    }

    if {![regexp {memory_initialization_radix} $content]} {
        puts "❌ ERROR: Bad format (missing radix) in: $coe_file"
        continue
    }

    puts "OK: $coe_file"
}

# Loop over all expected .coe files
for {set i 0} {$i < $num_coe_l2} {incr i} {
    set coe_file "$coe_dir/Weight_mem_2_${i}.coe"

    # Check if file exists
    if {![file exists $coe_file]} {
        puts "❌ ERROR: Missing COE file: $coe_file"
        continue
    }

    # Check if file is empty
    set file_size [file size $coe_file]
    if {$file_size == 0} {
        puts "❌ ERROR: Empty COE file: $coe_file"
        continue
    }

    # Open and check basic content
    set fh [open $coe_file r]
    set content [read $fh]
    close $fh

    if {![regexp {memory_initialization_vector} $content]} {
        puts "❌ ERROR: Bad format (missing vector) in: $coe_file"
        continue
    }

    if {![regexp {memory_initialization_radix} $content]} {
        puts "❌ ERROR: Bad format (missing radix) in: $coe_file"
        continue
    }

    puts "OK: $coe_file"
}

puts "COE file scan complete."
