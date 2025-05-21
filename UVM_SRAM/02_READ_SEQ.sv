class read_seq extends uvm_sequence #(base_seq_item);
  `uvm_object_utils(read_seq)

	base_seq_item	seq_item;

	
  function new(string name = "read_seq");
		super.new(name);
    `uvm_info(get_type_name(), "Constructor", UVM_LOW)
    seq_item = base_seq_item::type_id::create("seq_item");
	endfunction


  
	//body task runs when were called by start func from test_class
	task body();
      `uvm_info(get_type_name(), "read sequence task body_start", UVM_NONE)
        line();
		start_item(seq_item);
      	void'(seq_item.randomize() with { rst == 1; en == 1; wr == 0; data_in == 0; addr inside {[4:8]};});
		finish_item(seq_item);
      `uvm_info(get_type_name(), "read sequence task body finish", UVM_NONE)
	endtask
  
  
  
  
  	function void line();
    $display("_________________________________________________________________");
    endfunction
	
endclass
