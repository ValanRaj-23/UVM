class base_seq extends uvm_sequence#(seq_item);
  
  `uvm_object_utils(base_seq)
  
  
  
  function new(string name = "base_seq");
    super.new("name");
    `uvm_info(get_type_name, "CONSTRUCTOR", UVM_HIGH)
  endfunction 
  
  
  
  task body();
    
    `uvm_info(get_type_name(), "START OF BODY", UVM_MEDIUM);
    obj_base_seq	= seq::type_id::create("obj_base_seq");
    start_item(obj_base_seq);
    assert(obj_base_seq.randomize());
    finish_item(obj_base_seq);
    `uvm_info(get_type_name(), "END OF BODY", UVM_MEDIUM);
    
  endtask
  
  
endclass
