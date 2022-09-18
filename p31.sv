module model #(parameter
    DATA_WIDTH = 16
) (
    input [DATA_WIDTH-1:0] din,
    input [4:0] wad1,
    input [4:0] rad1, rad2,
    input wen1, ren1, ren2,
    input clk,
    input resetn,
    output logic [DATA_WIDTH-1:0] dout1, dout2,
    output logic collision
);
    logic [DATA_WIDTH-1:0] mem[31:0], mem_next[31:0];
    logic [DATA_WIDTH-1:0] dout1_c, dout2_c;
    logic collision_c;

    always_comb
    begin
        mem_next = mem;
        dout1_c = '0;
        dout2_c = '0;
        collision_c = 1'b0;

        if (!resetn)
        begin
            for (int i = 0; i < 32; i = i+1)
            begin
                mem_next[i] = '0;
            end
        end
        else if ((wen1 && ren1 && wad1 == rad1)
            || (ren1 && ren2 && rad1 == rad2)
            || (wen1 && ren2 &&  wad1 == rad2))
        begin
            collision_c = 1'b1;
        end
        else
        begin
            if (wen1)
                mem_next[wad1] = din;
            if (ren1)
                dout1_c = mem[rad1];
            if (ren2)
                dout2_c = mem[rad2];
        end
    end

    always_ff @(posedge clk)
    begin
        mem <= mem_next;
        dout1 <= dout1_c;
        dout2 <= dout2_c;
        collision <= collision_c;
    end

endmodule
