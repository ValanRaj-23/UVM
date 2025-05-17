class base_seqr extends uvm_sequencer#(base_seq_item);
	`uvm_component_utils(base_seqr)



	
	function new(string name = "base_seqr",uvm_component parent);
      super.new(name, parent);
		`uvm_info(get_type_name(), "Constructor", UVM_LOW)
	endfunction 

endclass

