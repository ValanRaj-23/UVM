`include "uvm_macros.svh"
import uvm_pkg::*;

`include "package.sv"
`include "base_intf.sv"



module uart_test;

bit clk;
always #1 clk = ~clk;
  
			uart_tx_top	top(
						.clk      	(clk    	   	),
  						.reset      (intf.reset    	),
  						.start		(intf.start    	),
  						.p_sel	   	(intf.p_sel    	),
  						.data       (intf.data     	),
  						.tx_out	    (intf.tx_out   	),
  						.baud_wire  (intf.baud_wire	)			
			);


			base_intf	intf(
              			.clk		(clk			));


	initial begin
		clk = 0;
	end

	initial begin
      uvm_config_db#(virtual base_intf)::set(null, "*", "vinf", intf);
	       	$dumpfile("dump.vcd");
       		$dumpvars;
 			#1000000;
			$finish;
	end		


	initial begin
      run_test("base_test");
	end

endmodule
