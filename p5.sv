module model #(parameter
  DATA_WIDTH=32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

    always_comb
    begin
        for (int i = 0; i < DATA_WIDTH; i += 1)
        begin
            dout[i] = din[DATA_WIDTH-1-i];
        end
    end

endmodule
