interface base_intf(input bit clk);

	logic 			reset;
	logic 			start;
	logic 			p_sel;
	logic	[7:0]	data;
	logic 			tx_out;
	logic 			baud_wire;

endinterface
