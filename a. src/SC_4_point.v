module SC_4_point (in0,in1,s0,s1,s2,s3,clk,out0,out1);
input [5:0] in0,in1;
input clk,s0,s1,s2,s3;
output [5:0] out0,out1;
wire [5:0] a1,a2,b1,b2,y1,y2,h,c1,c2,d1,d2,e,f;
wire[5:0] z0,z1,z2,z3,z4,z5,z6,z7; 
reg[5:0] tw;

//###############INPUT REORDERING############\\

dflip D1(in1,clk,a1);
mux2_1 m1(a1,in0,s0,y1);
mux2_1 m2(in0,a1,s0,y2);
dflip D2(y2,clk,a2);
mux2_1 m3(a2,y1,s1,b1);
mux2_1 m4(y1,a2,s1,z1);
dflip D3(b1,clk,b2);
dflip D4(b2,clk,z0);

//#################STAGE 1####################\\

///////////////butterfly (stage1)\\\\\\\\\\\\\\\
assign z2 = z0+z1;
assign h = z0-z1;

//////////////rotator (stage1)\\\\\\\\\\\\\\\\\\

assign z3 = tw * h;
reg [1:0] count; 
initial count = 2'b01;
always @ (posedge clk) 
begin
    case(count)
        2'b00, 2'b01,2'b10: 
		  begin
           tw = 1;
           count <= count + 1'b1;
        end
        2'b11: 
		  begin
            tw = -1;
				count <= count + 1'b1;
        end
        default: 
		  begin
            count <= 2'b00; 
        end
    endcase
end

////////////reordering (stage1)\\\\\\\\\\\\\\\\\
dflip D8(z3,clk,c1);
dflip D9(c1,clk,c2);
mux2_1 m6(z2,c2,s2,z5);
mux2_1 m7(c2,z2,s2,d1);
dflip D10(d1,clk,d2);
dflip D11(d2,clk,z4);

//################STAGE 2###################\\

////////////butterfly (stage2)\\\\\\\\\\\\\

assign z6 = z4+z5;
assign z7 = z4-z5;

//###############OUTPUT REORDERING############\\

dflip D12(z7,clk,e);
mux2_1 m8(z6,e,s3,out1);
mux2_1 m9(e,z6,s3,f);
dflip D13(f,clk,out0);
endmodule

module dflip (d,clk,q);
input [5:0]d;
input clk;
output reg [5:0]q;
always @(posedge clk)
begin
		q <= d;
end
endmodule

module mux2_1 (d0, d1, s, y);
output [5:0]y;
input [5:0]d0, d1;
input s;
assign y = (s)? d1:d0;
endmodule
