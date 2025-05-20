interface base_inf(input logic clk);
	
		logic		rst;
        logic		en;
        logic		wr;
  		logic [2:0]	addr;	
        logic [3:0]	data_in;
        logic [3:0]	data_out;

endinterface
