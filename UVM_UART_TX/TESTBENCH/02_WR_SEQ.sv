class wr_seq extends uvm_sequence#(base_seq_item);
	`uvm_object_utils(wr_seq)
	base_seq_item seq_item;


	function new(string name = "wr_seq");
		super.new(name);
            `uvm_info(get_type_name(), "Constructor", UVM_LOW)
	endfunction



	task body();
      
      repeat(3)
        begin
          
        `uvm_info(get_type_name(), "WRITE START_BODY", UVM_LOW)
          
		    seq_item = base_seq_item::type_id::create("seq_item");
		    start_item(seq_item);
      	assert(seq_item.randomize() with  {reset == 1; p_sel == 1; start == 1;});
		    finish_item(seq_item);
          
        `uvm_info(get_type_name(), "WRITE FINISH_BODY", UVM_LOW)  

        end
	endtask


endclass
	
//      `uvm_do_with(req, {req.<variable> == 0;}); // any constraint
