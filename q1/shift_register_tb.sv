module shift_register_tb;

    localparam int N = 4;

    logic clk, rst_n, serial_parallel, load_enable, serial_in;
    logic [N-1:0] parallel_in;
    logic [N-1:0] parallel_out;
    logic serial_out;

    shift_register #(
        .N(N)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .serial_parallel(serial_parallel),
        .load_enable(load_enable),
        .serial_in(serial_in),
        .parallel_in(parallel_in),
        .parallel_out(parallel_out),
        .serial_out(serial_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0; rst_n = 1'b0; load_enable = 1'b0; parallel_in = 4'h0;
        serial_parallel = 1'b0; serial_in = 1'b0;
        #12 rst_n = 1'b1; // ativar
        #10 load_enable = 1'b1; serial_parallel = 1'b1; parallel_in = 4'h5;
        #10 load_enable = 1'b0; serial_parallel = 1'b1; parallel_in = 4'hC;
        #10 load_enable = 1'b1; serial_parallel = 1'b1; parallel_in = 4'hE;
        #10 load_enable = 1'b1; serial_parallel = 1'b1; parallel_in = 4'hF;
        #10 rst_n = 1'b0; load_enable = 1'b1; serial_parallel = 1'b1; parallel_in = 4'h5;
        #12 rst_n = 1'b1; // ativar
        #10 load_enable = 1'b1; parallel_in = 4'hF;
        #10 load_enable = 1'b1; serial_parallel = 1'b1; parallel_in = 4'hF;
        #10 load_enable = 1'b1; serial_parallel = 1'b0; serial_in = 1'b0;
        #10 load_enable = 1'b1; serial_parallel = 1'b0; serial_in = 1'b1;
        #10 load_enable = 1'b0; serial_parallel = 1'b0; serial_in = 1'b1;
        #10 load_enable = 1'b1; serial_parallel = 1'b0; serial_in = 1'b0;
        #10 load_enable = 1'b1; serial_parallel = 1'b0; serial_in = 1'b1;
        #10 rst_n = 1'b0; load_enable = 1'b1; serial_parallel = 1'b0; serial_in = 1'b1;
        #30 $stop;
    end

    initial begin
        $monitor("Time=%0t | clk=%b rst_n=%b load_enable=%b parallel_in=%h parallel_out=%h", 
                 $time, clk, rst_n, load_enable, parallel_in, parallel_out);
    end

// complete here

endmodule
