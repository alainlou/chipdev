`include "full_adder.sv"
module model #(parameter
    DATA_WIDTH=8
) (
    input [DATA_WIDTH-1:0] a,
    input [DATA_WIDTH-1:0] b,
    output logic [DATA_WIDTH-0:0] sum,
    output logic [DATA_WIDTH-1:0] cout_int
);

    generate
        for (genvar i = 0; i < DATA_WIDTH; i += 1)
        begin : generate_adders
            logic cin_inst = i > 0 ? cout_int[i-1] : 1'b0;
            full_adder full_adder_I
            (
                .a(a[i]),
                .b(b[i]),
                .cin(cin_inst),
                .sum(sum[i]),
                .cout(cout_int[i])
            );
        end
    endgenerate

    assign sum[DATA_WIDTH] = cout_int[DATA_WIDTH-1];

endmodule
