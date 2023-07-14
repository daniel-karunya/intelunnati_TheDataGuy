module Restoring_Slow_Division(
  input         clk, reset,
  input  [4:0] n_in,
  input  [3:0] d_in,
  output reg [3:0] r_out,
  output reg [4:0] q_out,
  output reg done);

  parameter s0=0, s1=1, s2=2, s3=3; // State assignments

  
  always @(posedge clk or posedge reset) 
  begin : F // Finite state machine 
    reg [2:0] count;
    reg [1:0] s;          // FSM state 
    reg  [9:0] d;        // Double bit width unsigned
    reg  signed [9:0] r; // Double bit width signed
    reg  [4:0] q;

    if (reset)              // Asynchronous reset
      s <= s0;
    else
      case (s) 
        s0 : begin         // Initialization step 
          s <= s1;
          count = 0;
          q <= 0;           // Reset quotient register
          d <= d_in << 5;   // Load aligned denominator
          r <= n_in;        // Remainder = numerator
          done <= 0;
        end                                           
        s1 : begin         // Processing step 
          r <= r - d;      // Subtract denominator
          s <= s2;
        end
        s2 : begin          // Restoring step
          if (r < 0) begin  // Check r < 0 
            r <= r + d;     // Restore previous remainder
            q <= q << 1;     // LSB = 0 and SLL
            end
          else
            q <= (q << 1) + 1; // LSB = 1 and SLL
          count = count + 1;
          d <= d >> 1;

          if (count == 5)   // Division ready 
            s <= s3;
          else             
            s <= s1;
        end
        s3 : begin       // Output of result
          q_out <= q[4:0]; 
          r_out <= r[3:0]; 
          done <= 1;
          s <= s0;   // Start next division
        end
      endcase  
  end

endmodule