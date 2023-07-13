module Lookuptable_Fast_Division_tb;

	// Inputs
	reg [7:0] xin;
	reg [7:0] yin;
	reg clk;
	reg enbl;

	// Outputs
	wire [15:0] xyout;

	// Instantiate the Unit Under Test (UUT)
	Lookuptable_Fast_Division uut (
		.xin(xin), 
		.yin(yin), 
		.clk(clk), 
		.enbl(enbl), 
		.xyout(xyout)
	);

	initial begin
		// Initialize Inputs
		xin = 0;
		yin = 0;
		clk = 0;
		enbl = 0;

		// Wait 100 ns for global reset to finish
        #100;
        xin = 8'b01000000;// 64
        yin = 8'b00000010;// 2
        clk = 0;
        enbl = 1;

        #100;
		   @(posedge clk);
    $display("%d / %d = %b ", xin, yin, xyout);
	 
        xin = 8'b00000101;//5
        yin = 8'b00000010;//2
        clk = 0;
        enbl = 1;

        #100;
		   @(posedge clk);
    $display("%d / %d = %b ", xin, yin, xyout);
	 
        xin = 8'b00010101;//21
        yin = 8'b00000100;//4
        clk = 0;
        enbl = 1;

		  #100;
		   @(posedge clk);
    $display("%d / %d = %b ", xin, yin, xyout);


	 
	 
	end
    always #10 clk=~clk;
	 
	initial #5000 $finish; 
endmodule
