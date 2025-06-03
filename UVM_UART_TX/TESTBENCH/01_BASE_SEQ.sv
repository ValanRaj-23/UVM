class seq_item extends uvm_sequence_item;
  
  
	rand 	bit		 	reset		;
  	rand 	bit		 	start		;
  	rand 	bit		 	p_sel		;
  	rand 	bit	[7:0]	data		;
  			bit		 	tx_out		;
  			bit			baud_wire	;
  
  
  
  
  `uvm_object_utils_begin(seq_item)
  		`uvm_field_int(reset		, UVM_ALL_ON)
  		`uvm_field_int(start		, UVM_ALL_ON)
  		`uvm_field_int(p_sel		, UVM_ALL_ON)
  		`uvm_field_int(data 		, UVM_ALL_ON)
  		`uvm_field_int(tx_out		, UVM_ALL_ON)
  		`uvm_field_int(baud_wire	, UVM_ALL_ON)
  `uvm_object_utils_end

  
  
  
  function new(string name = "seq_item");
    super.new(name);
    `uvm_info(get_type_name, "CONSTRUCTOR", UVM_HIGH)
  endfunction
  
  
endclass
