/*module clk_div(clkin,clkout);
reg [25:0] counter;
output reg clkout;
input clkin;
initial begin
    counter = 0;
    clkout = 0;
end
always @(posedge clkin) begin
    if (counter == 0) begin
        counter <= 5000000;
        clkout <= ~clkout;
    end else begin
        counter <= counter -1;
    end
	 
end

endmodule*/

/*module slowClock(clk, reset, clk_1Hz);
input clk, reset;
output clk_1Hz;

reg clk_1Hz;
reg [27:0] counter;

always@(posedge reset or posedge clk)
begin
    if (reset == 1'b1)
        begin
            clk_1Hz <= 0;
            counter <= 0;
        end
    else
        begin
            counter <= counter + 1;
            if ( counter == 25_000_000)
                begin
                    counter <= 0;
                    clk_1Hz <= ~clk_1Hz;
                end
        end
end
endmodule*/

module jamming_transition(input i_clk, output o2,o3,o4,o5,o6,o7,o8,o9,o10,o11,o12,o13,o14,o15,o16,o17,o18,o19,o20,o21);

parameter dim = 20;
parameter step = 2;
parameter t = 200;
integer n = 30;
reg [2:0] b21,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20;
reg [3:0] vel [0:99];
reg [10:0] tim [0:99];
reg [10:0] pos [0:99];
reg [1:0] ans [0:99];
integer ctr=0;
integer i;
reg [1:0] stopp = 2'b00;
integer l;				  

//clk_div(i_clk, Clk_out);
//slowClock clock_generator(i_clk, 0, clk_1Hz);
	
initial 
	begin
		for (i = 0; i < 30; i = i + 1) begin
			if (i%4 ==1) begin
				vel[i]=4'b0010;
			end
			if (i%4 ==0) begin
				vel[i]=4'b0011;
			end				
			if (i%4 ==2) begin
				vel[i]=4'b0001;
			end
			if (i%4 ==3) begin
				vel[i]=4'b0100;
			end				
		end
		
		 for (i = 0; i < 30; i = i + 1) begin
			  tim[i] = 2*i ;
			  pos[i] = 0;
		 end
		 for (i = 0; i < 20; i = i + 1) begin
			  ans[i] = 0;
		 end 
		 
	end

always @(posedge i_clk) begin
	if (stopp==2'b00) begin
		//for (ctr = 0; ctr <10; ctr = ctr + 1) begin: myblock4
			
				  //reg [1:0] stopp = 2'b00;
				  
				//if (stopp == 2'b01) begin
				//	disable myblock4; 			
				//end 
				  
		  
		  
		  
			for (i = 0; i < 30; i = i + 1) begin
					if (ctr < tim[i]) begin
						pos[i] = 0;
					end 
					if (ctr == tim[i]) begin
							pos[i] = 11'b00000000001;
					end
					if (ctr > tim[i]) begin
							pos[i] = pos[i] + vel[i];
					end
			end
		  
		  for (i = 1; i < 30; i = i + 1) begin
				if ((pos[i] != 0) && (pos[i-1] != 0) && (pos[i] >= pos[i-1])) begin
					 pos[i] = pos[i-1] - 1;
					 vel[i] = vel[i-1];
				 end
		  end
		  
		  for (l = 0; l < dim +1; l = l + 1) begin
				ans[l]=0;
			end
		  
		  for (l = 1; l < dim+1 ; l = l + 1) begin
				for (i = 0; i < 30; i = i + 1) begin
					
					 if (l == pos[i] ) begin
						  ans[l] = 3'b001;
					 end
					
				end
		  end
		  
		  for (i = 3; i < 30; i = i + 1) begin
				if ((pos[i] != 0) && (pos[i-3] < dim) && (pos[i] == pos[i-1] - 1) && (pos[i-1] == pos[i-2] - 1) && (pos[i-2] == pos[i-3] - 1)) begin
					 stopp = 2'b01;
				 end
		  end
		  
		  
			ctr <= ctr + 1;
				  
		
	
	
	b2 <= ans[1];
	b3 <= ans[2];
	b4 <= ans[3];
	b5 <= ans[4];
	b6 <= ans[5];
	b7 <= ans[6];
	b8 <= ans[7];
	b9 <= ans[8];
	b10 <= ans[9];
	b11 <= ans[10];
	b12 <= ans[11];
	b13 <= ans[12];
	b14 <= ans[13];
	b15 <= ans[14];
	b16 <= ans[15];
	b17 <= ans[16];
	b18 <= ans[17];
	b19 <= ans[18];
	b20 <= ans[19];
	b21 <= ans[20];
end
end
	
	assign o2 = b2;
	assign o3 = b3;
	assign o4 = b4;
	assign o5 = b5;
	assign o6 = b6;
	assign o7 = b7;
	assign o8 = b8;
	assign o9 = b9;
	assign o10 = b10;
	assign o11 = b11;
	assign o12 = b12;
	assign o13 = b13;
	assign o14 = b14;
	assign o15 = b15;
	assign o16 = b16;
	assign o17 = b17;
	assign o18 = b18;
	assign o19 = b19;
	assign o20 = b20;
	assign o21 = b21;
	
endmodule
