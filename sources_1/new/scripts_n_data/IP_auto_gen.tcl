
set coe_dir "C:/Users/41536/Desktop/ELM_auto/ELM_auto/ELM_auto.srcs/sources_1/new"
set mem_width 12
set mem_depth 128

set sigmoid_depth 4096


for {set i 0} {$i < 50} {incr i} {
    set ip_name "Weight_Memory_1_${i}_IP"
    set coe_file_layer1 "$coe_dir/Weight_mem_1_${i}.coe"

    puts "Processing IP: $ip_name with COE: $coe_file_layer1"

    # Delete old IP if exists
    if {[llength [get_ips $ip_name]] != 0} {
        delete_ip [get_ips $ip_name]
    }

    # Create fresh IP
    create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name $ip_name

    # Configure properties (ONLY existing ones)
    set_property -dict [list \
        CONFIG.Memory_Type {Single_Port_ROM} \
        CONFIG.Write_Width_A $mem_width \
        CONFIG.Write_Depth_A $mem_depth \
        CONFIG.Load_Init_File {true} \
        CONFIG.coe_file "$coe_file_layer1" \
        CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
        CONFIG.Use_Byte_Write_Enable {false} \
    ] [get_ips $ip_name]
}

# Generate output products
generate_target all [get_ips]

for {set i 0} {$i < 2} {incr i} {
    set ip_name "Weight_Memory_2_${i}_IP"
    set coe_file_layer2 "$coe_dir/Weight_mem_2_${i}.coe"

    puts "Processing IP: $ip_name with COE: $coe_file_layer2"

    # Delete old IP if exists
    if {[llength [get_ips $ip_name]] != 0} {
        delete_ip [get_ips $ip_name]
    }

    # Create fresh IP
    create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name $ip_name

    # Configure properties (ONLY existing ones)
    set_property -dict [list \
        CONFIG.Memory_Type {Single_Port_ROM} \
        CONFIG.Write_Width_A $mem_width \
        CONFIG.Write_Depth_A $mem_depth \
        CONFIG.Load_Init_File {true} \
        CONFIG.coe_file "$coe_file_layer2" \
        CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
        CONFIG.Use_Byte_Write_Enable {false} \
    ] [get_ips $ip_name]
}

# Generate output products
generate_target all [get_ips]

puts "Successfully created 50 ROMs (12-bit wide, 128 depth)"
puts "Successfully created 2 ROMs (12-bit wide, 128 depth)"


set sigmoid_coe_dir "C:/Users/41536/Desktop/ELM_auto/ELM_auto/ELM_auto.srcs/sources_1/new"
set ip_name "sig_normal_IP"
set coe_file_sig_nor "$sigmoid_coe_dir/sigmoid_rom.coe"

    create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name $ip_name

    # Configure properties (ONLY existing ones)
    set_property -dict [list \
        CONFIG.Memory_Type {Single_Port_ROM} \
        CONFIG.Write_Width_A $mem_width \
        CONFIG.Write_Depth_A $sigmoid_depth \
        CONFIG.Load_Init_File {true} \
        CONFIG.coe_file "$coe_file_sig_nor" \
        CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
        CONFIG.Use_Byte_Write_Enable {false} \
    ] [get_ips $ip_name]

set ip_name "sig_LU_IP"
set coe_file_LU "$sigmoid_coe_dir/LU_LUT.coe"
    create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name $ip_name

    # Configure properties (ONLY existing ones)
    set_property -dict [list \
        CONFIG.Memory_Type {Single_Port_ROM} \
        CONFIG.Write_Width_A $mem_width \
        CONFIG.Write_Depth_A $sigmoid_depth \
        CONFIG.Load_Init_File {true} \
        CONFIG.coe_file "$coe_file_LU" \
        CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
        CONFIG.Use_Byte_Write_Enable {false} \
    ] [get_ips $ip_name]

puts "Successfully created 50 ROMs (12-bit wide, 128 depth)"
