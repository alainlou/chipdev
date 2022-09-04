module model #(parameter
  DATA_WIDTH = 4
) (
  input clk,
  input resetn,
  output logic [DATA_WIDTH-1:0] out
);
  logic [DATA_WIDTH-1:0] data_r;

  always_ff @(posedge clk)
  begin
    if (!resetn)
    begin
      data_r <= '0;
    end
    else
    begin
      data_r <= data_r + 1;
    end
  end

  generate
    if (DATA_WIDTH > 1)
    begin
        assign out = data_r ^ data_r[DATA_WIDTH-1:1];
    end
    else
    begin
        assign out = data_r;
    end
  endgenerate
endmodule
