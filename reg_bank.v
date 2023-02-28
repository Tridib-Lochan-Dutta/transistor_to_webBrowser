module reg_bank(
    input[3:0] in_addr_1, input[3:0] in_addr_2, input[3:0] in_addr_3, input[3:0] in_addr_4, input[3:0] in_addr_5, input[3:0] in_addr_6, input[3:0] in_addr_7, input[3:0] in_addr_8, input[3:0] in_addr_9, input[3:0] in_addr_10, input[3:0] in_addr_11, input[3:0] in_addr_12, input[3:0] in_addr_13, input[3:0] in_addr_14, input[3:0] in_addr_15, input[3:0] in_addr_16,

    output[31] out_data_1, output[31] out_data_2, output[31] out_data_3, output[31] out_data_4, output[31] out_data_5, output[31] out_data_6, output[31] out_data_7, output[31] out_data_8, output[31] out_data_9, output[31] out_data_10, output[31] out_data_11, output[31] out_data_12, output[31] out_data_13, output[31] out_data_14, output[31] out_data_15, output[31] out_data_16,  

    input[4:0] mode,
    
);

    reg[31:0] R[15:0];
    reg[31:0] cpsr;
    

endmodule
