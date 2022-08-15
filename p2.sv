module model #(parameter
  DATA_WIDTH = 32
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

  logic [DATA_WIDTH-1:0] big1, big2, big1_next, big2_next;

  always_comb
  begin
    if (din >= big1)
    begin
      big1_next = din;
      big2_next = big1;
    end
    else if (din >= big2)
    begin
      big1_next = big1;
      big2_next = din;
    end
    else
    begin
      big1_next = big1;
      big2_next = big2;
    end
  end

  always_ff @(posedge clk)
  begin
    if (!resetn)
    begin
      big1 <= '0;
      big2 <= '0;
    end
    else
    begin
      big1 <= big1_next;
      big2 <= big2_next;
    end
  end

  assign dout = big2;

endmodule
