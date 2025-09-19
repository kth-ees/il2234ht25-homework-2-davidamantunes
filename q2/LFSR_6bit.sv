module LFSR_6bit (
    input  logic clk, rst_n,
    input  logic sel,
    input  logic [5:0] parallel_in,
    output logic [5:0] parallel_out
);

    // …
    // Add your description here
    // …
    logic [5:0] parallel_out_next;

    always_comb begin : comb_logic
        if (sel) begin
            parallel_out_next[0] = parallel_out[5];
            parallel_out_next[1] = parallel_out[0]^parallel_out[5];
            parallel_out_next[2] = parallel_out[1];
            parallel_out_next[3] = parallel_out[2]^parallel_out[5];
            parallel_out_next[4] = parallel_out[3];
            parallel_out_next[5] = parallel_out[4];
        end else begin
            parallel_out_next = parallel_in;
        end
    end

    always_ff @( posedge clk or negedge rst_n ) begin : N_size_register
        if (!rst_n)
            parallel_out <= 6'b0;
        else
            parallel_out <= parallel_out_next;
    end

endmodule
