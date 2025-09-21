module up_down_counter #(
    parameter int N = 4
)(
    input  logic clk,
    input  logic rst_n,
    input  logic up_down,
    input  logic load,
    input  logic [N-1:0] input_load,
    output logic [N-1:0] count_out,
    output logic carry_out
);

logic [N-1:0] count_out_next;
logic carry_out_next;

    always_comb begin : counter_logic
        if (load) begin
            count_out_next = input_load;
        end else begin
            count_out_next = (up_down) ? count_out + 1 : count_out - 1;
        end
    end

    always_comb begin : carry_out_logic
        carry_out_next = 1'b0;
        if (up_down) begin
            carry_out_next = (count_out == {N{1'b1}}) & (count_out_next == {N{1'b0}});
        end else begin
            carry_out_next = (count_out == {N{1'b0}}) & (count_out_next == {N{1'b1}});
        end
    end

  // complete here
    always_ff @(posedge clk or negedge rst_n) begin : N_register_counter
        if (!rst_n) begin
            count_out <= {N{1'b0}};
            carry_out <= 1'b0;
        end
        else begin
            count_out <= count_out_next;
            carry_out <= carry_out_next;
        end
    end


endmodule