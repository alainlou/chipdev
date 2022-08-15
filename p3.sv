module model #(parameter
  DIV_LOG2=3,
  OUT_WIDTH=32,
  IN_WIDTH=OUT_WIDTH+DIV_LOG2
) (
  input [IN_WIDTH-1:0] din,
  output logic [OUT_WIDTH-1:0] dout
);

  function [OUT_WIDTH-1:0] saturate(input int value);
    saturate = value >= {OUT_WIDTH{1'b1}} ? {OUT_WIDTH{1'b1}} : value;
  endfunction

  assign dout = saturate((din >> DIV_LOG2) + din[DIV_LOG2-1]);

endmodule
