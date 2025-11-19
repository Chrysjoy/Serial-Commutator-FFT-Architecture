module SC_4_point_tb;
reg [5:0] in0,in1;
reg clk,s0,s1,s2,s3;
wire [5:0] out0,out1;

SC_4_point f1(.in0(in0),.in1(in1),.s0(s0),.s1(s1),.s2(s2),.s3(s3),.clk(clk),.out0(out0),.out1(out1));

always #50 clk = ~clk;

initial 
	begin
			  clk = 1; s0 = 1; s1 = 1;
		@(posedge clk);
		     in0 = 5'b00000; //0
			  in1 = 5'b00001; //1
		@(posedge clk); 
			  in0 = 5'b00010; //2
			  in1 = 5'b00011; //3
			  s0 = ~s0;
		@(posedge clk);
		     in0 = 5'b00100; //4
			  in1 = 5'b00101; //5
			  s0 = ~s0;
			  s1 = ~s1;
			  s2 = 1;
		@(posedge clk);
		     in0 = 5'b00110; //6
			  in1 = 5'b00111; //7
			  s0 = ~s0;			  
		@(posedge clk);			  
			  s0 = ~s0;
			  s1 = ~s1;
			  s2 = ~s2;
			  s3 = 1;
		@(posedge clk);
			  s3 = ~s3;
		@(posedge clk);
			  s2 = ~s2;
			  s3 = ~s3;
		@(posedge clk);
			  s3 = ~s3;
		@(posedge clk);
			  s3 = ~s3;
		@(posedge clk);
			  s3 = ~s3;	
		$stop;
	end
