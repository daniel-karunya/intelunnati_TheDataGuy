module Restoring_Slow_Division_tb;

  reg clk, reset;
  reg [4:0] n_in;
  reg [3:0] d_in;
  wire [3:0] r_out;
  wire [4:0] q_out;
  wire done;

  Restoring_Slow_Division_5_4 uut (
    .clk(clk),
    .reset(reset),
    .n_in(n_in),
    .d_in(d_in),
    .r_out(r_out),
    .q_out(q_out),
    .done(done)
  );


  initial begin
    clk = 0;
    reset = 1;
    
    #10 reset = 0;
    
    
    #10 n_in = 5; d_in = 2; // Test case 1
    #100;
    @(posedge done);
    @(posedge done);
    $display("Test case 1: %d / %d = %d R %d", n_in, d_in, q_out, r_out);
    
    
    #10 n_in = 10; d_in = 6; // Test case 2
    #100;
    @(posedge done);
    @(posedge done);
    $display("Test case 2: %d / %d = %d R %d", n_in, d_in, q_out, r_out);
    

  end

  always #5 clk = ~clk;

endmodule