module model #(parameter
  DATA_WIDTH = 16
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  input din_en,
  output logic dout
);
    logic [DATA_WIDTH-1:0] data_r;

    always_ff @(posedge clk)
    begin
        if (!resetn)
        begin
            data_r <= '0;
        end
        else if (din_en)
        begin
            data_r <= din;
        end
        else
        begin
            data_r <= data_r >> 1;
        end
    end

    assign dout = data_r[0];

endmodule
