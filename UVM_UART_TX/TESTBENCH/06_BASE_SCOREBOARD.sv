class base_scb extends uvm_scoreboard;
  `uvm_component_utils(base_scb)
  bit [7:0]	scb_input_data[$];
  bit [7:0] scb_output_data[$];
  base_seq_item	seq_item_q[$];
  base_seq_item scb_item;
  int q_size;
  event trans_done;--------------
  
  uvm_analysis_imp #(base_seq_item, base_scb) item_receiver;
  
  
  
  function new(string name = "base_scb", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name, "CONSTRUCTOR", UVM_DEBUG)
  endfunction
  
  
      
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
		`uvm_info(get_type_name(), "BUILD_PHASE"	, UVM_FULL)
    item_receiver = new("item_receiver", this);
  endfunction
  
  
  
  
  fuction void write(base_seq_item seq_item);
  seq_item_q.push_back(seq_item);
  `uvm_info(get_type_name(), "WRITE_FUNCTION", UVM_MEDIUM)
  endfunction
  
  
  

  task run(uvm_phase phase)
    base_seq_item seq_item;
    forever begin
    if(seq_item_q.size(); != 0)
        scb_item 	= seq_item_q.pop_front();
      if(scb_item.uart_data  == scb_item.data)
        `uvm_info(get_type_name(), $sformatf(" PASSED INPUT_DATA = %0d | UART_DATA = %0d:",scb_item.data, scb_item.uart_data) UVM_MEDIUM)
        else
        `uvm_info(get_type_name(), $sformatf(" FAILED INPUT_DATA = %0d | UART_DATA = %0d:",scb_item.data, scb_item.uart_data) UVM_MEDIUM)
    end
   --> trans_done;
  endtask
   
endclass

