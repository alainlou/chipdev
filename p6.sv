module model (
  input clk,
  input resetn,
  input din,
  output dout
);

    logic dout_r;
    logic din_r;

    always_ff @(posedge clk)
    begin
        din_r <= din;
        if (!resetn)
        begin
            dout_r <= 1'b0;
        end
        else
        begin
            dout_r <= !din_r && din;
        end
    end

    assign dout = dout_r;

endmodule
