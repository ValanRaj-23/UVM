class rst_seq extends uvm_sequence #(base_seq_item);
  `uvm_object_utils(rst_seq)

	base_seq_item	seq_item;

	
  
  
  function new(string name = "rst_seq");
		super.new(name);
		`uvm_info(get_type_name(), "Constructor", UVM_LOW)
    		seq_item = base_seq_item::type_id::create("seq_item");

	endfunction


	
	task body();
      `uvm_info(get_type_name(), "rst sequence task body_start", UVM_NONE)
       line();
		start_item(seq_item);
        void'(seq_item.randomize() with { rst == 0 ; en == 0; wr == 0; addr == 0; data_in == 0;});
		finish_item(seq_item);
        `uvm_info(get_type_name(), "rst sequence task body finish", UVM_NONE)

      	endtask
  
  
  
	function void line();
    $display("_________________________________________________________________");
  	endfunction
	
endclass
