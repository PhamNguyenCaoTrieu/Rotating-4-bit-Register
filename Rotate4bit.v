module Rotate4bit (
    input wire [3:0] data_in,  
    input wire clk,            
    input wire reset,          
    input wire rotate,         
    output reg [3:0] data_out
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        data_out <= 4'b0000;   
    end else if (!rotate) begin
        data_out <= data_in;
    end else begin
        data_out <= {data_out[0], data_out[3:1]};
    end
end
endmodule

module tb_rotate4bit;

	reg [3:0] data_in;
	reg clk;
	reg reset;
	reg rotate;
	wire [3:0] data_out;

	Rotate4bit uut (
    		.data_in(data_in),
    		.clk(clk),
    		.reset(reset),
    		.rotate(rotate),
    		.data_out(data_out)
	);

initial begin
    clk = 0;
    reset = 1;
    rotate = 0;
    data_in = 4'b1101;
    
    #10 reset = 0;          
    #10 rotate = 1;         
    #10 rotate = 0;         
    #10 data_in = 4'b1010;   
    #10 rotate = 1;          
    #10 rotate = 0;          
    #50;               
end

always #5 clk = ~clk; 

endmodule
