class rst_seq extends uvm_sequence #(base_seq_item);
	`uvm_object_utils(rst_seq)
	base_seq_item seq_item;


	function new(string name = "rst_seq");
		super.new(name);
            `uvm_info(get_type_name(), "Constructor", UVM_LOW)

	endfunction



	task body();
    repeat(2) begin
          
		`uvm_info(get_type_name(), "RST START_BODY", UVM_LOW)
      
		seq_item = base_seq_item::type_id::create("seq_item");
		start_item(seq_item);
    void'(seq_item.randomize() with  {reset == 0; p_sel == 0; start == 0;});
		finish_item(seq_item);
      
    `uvm_info(get_type_name(), "RST FINISH_BODY", UVM_LOW)
          
        end
	endtask


endclass
