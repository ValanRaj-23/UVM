class base_seqr extends uvm_sequencer#(seq_item);
  `uvm_component_utils(base_sequence)
 
  
  
  function new (string name = "base_seqr", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name, "CONSTRUCTOR", UVM_HIGH)
  endfunction

  
endclass
