module up_down_counter_tb;
    localparam int N = 4;

    logic clk;
    logic rst_n;
    logic up_down;
    logic load;
    logic [N-1:0] input_load;
    logic [N-1:0] count_out;
    logic carry_out;


    up_down_counter #(
        .N(N)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .up_down(up_down),
        .load(load),
        .input_load(input_load),
        .count_out(count_out),
        .carry_out(carry_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0; rst_n = 1'b0; up_down = 1'b0; load = 1'b0; input_load = 4'b0000;
        #12
        rst_n = 1'b1; // ativar
        up_down = 1'b1; input_load = 4'b0000; load = 1'b1;
        #10
        load = 1'b0;
        #30
        up_down = 1'b0;
        #40
        up_down = 1'b1; input_load = 4'b1101; load = 1'b1;
        #10
        load = 1'b0;
        #40
        $stop;
    end

    initial begin
        $monitor("Time=%0t | clk=%b rst_n=%b up_down=%b load=%b input_load=%h count_out=%h carry_out=%b",
                 $time, clk, rst_n, up_down, load, input_load, count_out, carry_out);
    end


endmodule
