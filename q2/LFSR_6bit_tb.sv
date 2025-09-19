module LFSR_6bit_tb;

    logic clk, rst_n;
    logic sel;
    logic [5:0] parallel_in;
    logic [5:0] parallel_out;

    LFSR_6bit uut (
        .clk(clk),
        .rst_n(rst_n),
        .sel(sel),
        .parallel_in(parallel_in),
        .parallel_out(parallel_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0; rst_n = 1'b0; sel = 1'b0; parallel_in = 6'b000000;
        #12 rst_n = 1'b1; // ativar
        #30 sel = 1'b0; parallel_in = 6'b011010;
        #30 sel = 1'b1; // LFSR mode do 3 clk cycles
        #30 sel = 1'b0; parallel_in = 6'b111111;
        #10 sel = 1'b1;
        #30 sel = 1'b0; parallel_in = 6'b000000;
        #10 sel = 1'b1;
        #30 $stop;
    end

    initial begin
        $monitor("Time=%0t | clk=%b rst_n=%b sel=%b parallel_in=%h parallel_out=%h",
                 $time, clk, rst_n, sel, parallel_in, parallel_out);
    end
endmodule
