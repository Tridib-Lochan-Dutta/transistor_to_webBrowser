module alu(
    input[31:0] a,
    input[31:0] b,
    input[3:0] OpCode,
    input z_in,
    input c_in,
    input n_in,
    input v_in,
    input c_from_shifter,
    output reg[31:0] result,
    output reg z,
    output reg c,
    output reg n,
    output reg v,
    output reg wb
);

    localparam AND = 4'b0000;
    localparam EOR = 4'b0001;
    localparam SUB = 4'b0010;
    localparam RSB = 4'b0011;
    localparam ADD = 4'b0100;
    localparam ADC = 4'b0101;
    localparam SBC = 4'b0110;
    localparam RSC = 4'b0111;
    localparam TST = 4'b1000;
    localparam TEQ = 4'b1001;
    localparam CMP = 4'b1010;
    localparam CMN = 4'b1011;
    localparam ORR = 4'b1100;
    localparam MOV = 4'b1101;
    localparam BIC = 4'b1110;
    localparam MVN = 4'b1111;

    reg[31:0] neg;

    always@(*) begin

        {n, z, c, v} <= {n_in, z_in, c_in, v_in};

        case(OpCode)
            AND:begin
                    result <= a & b;
                    c <= c_from_shifter;
                    wb <= 1;
                end 

            EOR:begin
                    result <= a ^ b;
                    c <= c_from_shifter;
                    wb <= 1;
                end 

            SUB:begin
                    neg = -b;
                    {c,result} = a + neg;
                    v = (a[31] & neg[31] & ~result[31]) | (~a[31] & ~neg[31] & result[31]);
                    wb <= 1;
                end

            RSB:begin
                    neg = -a;
                    {c,result} = b + neg;
                    v = (b[31] & neg[31] & ~result[31]) | (~b[31] & ~neg[31] & result[31]);
                    wb <= 1; 
                end
        
            ADD:begin
                    {c,result} = a + b;
                    v = (a[31] & b[31] & ~result[31]) | (~a[31] & ~b[31] & result[31]);
                    wb <= 1;
                end

            ADC:begin
                    {c,result} = a + b + c_in;
                    v = (a[31] & b[31] & ~result[31]) | (~a[31] & ~b[31] & result[31]);
                    wb <= 1;
                end

            SBC:begin
                    neg = -b;
                    {c,result} = a + neg + c_in - 1;
                    v = (a[31] & neg[31] & ~result[31]) | (~a[31] & ~neg[31] & result[31]);
                    wb <= 1;
     
                end

            RSC:begin
                    neg = -a;
                    {c,result} = b + neg + c_in - 1;
                    v = (b[31] & neg[31] & ~result[31]) | (~b[31] & ~neg[31] & result[31]); 
                    wb <= 1;
                end

            TST:begin
                    result <= a & b;
                    c <= c_from_shifter;
                    wb <= 0;
                end

            TEQ:begin
                    result <= a ^ b;
                    c <= c_from_shifter;
                    wb <= 0;
                end

            CMP:begin
                    neg = -b;
                    {c,result} = a + neg;
                    v = (a[31] & neg[31] & ~result[31]) | (~a[31] & ~neg[31] & result[31]);
                    wb <= 0;

                end

            CMN:begin
                    {c,result} = a + b;
                    v = (a[31] & b[31] & ~result[31]) | (~a[31] & ~b[31] & result[31]);
                    wb <= 0;

                end

            ORR:begin
                    result <= a | b;
                    c <= c_from_shifter;
                    wb <= 1;
                end

            MOV:begin
                    result <= b;
                    c <= c_from_shifter;
                    wb <= 1;
                end

            BIC:begin
                    result <= a & (~b);
                    c <= c_from_shifter;
                    wb <= 1;
                end

            MVN:begin
                    result <= ~b;
                    c <= c_from_shifter;
                    wb <= 1;
                end
                
        endcase

        n = result[31];
        z = (result == 0);

    end
endmodule
