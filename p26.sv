module model #(parameter
    DATA_WIDTH=8
) (
    input clk,
    input resetn,
    input [DATA_WIDTH-1:0] din,
    input wr,
    output logic [DATA_WIDTH-1:0] dout,
    output logic full,
    output logic empty
);

    logic [DATA_WIDTH-1:0] mem [1:0];
    logic [DATA_WIDTH-1:0] mem_next [1:0];
    logic rd_pntr, rd_pntr_next, wr_pntr, wr_pntr_next;
    logic full_next, empty_next;

    always_comb
    begin
        if (!resetn)
        begin
            rd_pntr_next = 1'b0;
            wr_pntr_next = 1'b0;
            full_next = 1'b0;
            empty_next = 1'b1;
            for (int i = 0; i < 2; i = i+1)
            begin
                mem_next[i] = '0;
            end
        end
        else
        begin
            rd_pntr_next = rd_pntr;
            wr_pntr_next = wr_pntr;
            full_next = full;
            empty_next = empty;
            mem_next = mem;
            if (wr)
            begin
                full_next = full || wr_pntr == 1'b1;
                empty_next = 1'b0;
                wr_pntr_next = wr_pntr + 1'b1;
                mem_next[wr_pntr] = din;
                if (full)
                begin
                    rd_pntr_next = rd_pntr + 1'b1;
                end
            end
        end
    end

    always_ff @(posedge clk)
    begin
        rd_pntr <= rd_pntr_next;
        wr_pntr <= wr_pntr_next;
        mem <= mem_next;
        full <= full_next;
        empty <= empty_next;
    end

    assign dout = mem[rd_pntr];

endmodule
