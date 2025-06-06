class base_scb extends uvm_scoreboard;
	`uvm_component_utils(base_scb)
  	uvm_analysis_imp#(base_seq_item, base_scb) item_rx;
  	base_seq_item 	scb_q[$];
  	base_seq_item   scb_item;
	uvm_event sb_done;
  
  

	function new(string name = "base_scb", uvm_component parent);
		super.new(name, parent);
            `uvm_info(get_type_name(), "Constructor", UVM_LOW)
      scb_item = new();
	endfunction



	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item_rx = new("item_rx", this);

      if(!uvm_config_db#(uvm_event)::get(this, " ", "sb_done_id", sb_done))
             `uvm_fatal("GET_EVT", "Cannot get sb_done_evt")
	endfunction

	
  
  function void write(base_seq_item dummy);
    scb_q.push_front(dummy);
  endfunction

  
  
  task run_phase(uvm_phase phase);
		super.run_phase(phase);
          `uvm_info(get_type_name(), "RUN_PHASE STARTED", UVM_LOW)
    	check_output();
	endtask


  
  
 	task check_output();
		forever begin
          wait(scb_q.size() > 0);
          scb_item = scb_q.pop_back();
          
          if(scb_item.data == scb_item.tx_data)
            `uvm_info(get_type_name(), "CASE PASSED", UVM_LOW)
          else
            `uvm_error(get_type_name(), "CASE FAILED")
            sb_done.trigger();
          
		end
	endtask

            
            
endclass

