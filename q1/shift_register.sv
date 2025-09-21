module shift_register #(
    parameter int N=4
) (
    input logic clk,
    input logic rst_n,
    input logic serial_parallel,
    input logic load_enable,
    input logic serial_in,
    input logic [N-1:0] parallel_in,
    output logic [N-1:0] parallel_out,
    output logic serial_out
);

logic [N-1:0] parallel_out_next;

//If load_enable then parallel_out_next = parallel_in, else parallel_out_next = parallel_out
// If 0, load serially; if 1, load parallel
assign parallel_out_next = (load_enable&serial_parallel) ? parallel_in :
                        (load_enable&(~serial_parallel)) ? {serial_in, parallel_out[N-1:1]} :
                        parallel_out;

assign serial_out = parallel_out[0];

//complete here
/*
always_ff @( posedge clk or negedge arst_n ) begin : N_size_register
    if (!arst_n)
        s_rst <= 1'b1;
    else
        s_rst <= 1'b0;
end
*/



always_ff @( posedge clk or negedge rst_n ) begin : N_size_register
    if (!rst_n)
        parallel_out <= {N{1'b0}};
    else
        parallel_out <= parallel_out_next;
end


endmodule
