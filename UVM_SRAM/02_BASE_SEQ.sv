class base_seq extends uvm_sequence #(base_seq_item);
	`uvm_object_utils(base_seq)

	base_seq_item	seq_item;

	
	function new(string name = "base_seq");
		super.new(name);
		`uvm_info(get_type_name(), "Constructor", UVM_LOW)
	endfunction



	
	//body task runs when were called by start func from test_class
	task body();
		seq_item = base_seq_item::type_id::create("seq_item");
		start_item(seq_item);
		assert(seq_item.randomize());
		finish_item(seq_item);
	endtask
	
endclass
