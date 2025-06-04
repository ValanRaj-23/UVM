class base_mon extends uvm_monitor;
  `uvm_component_utils(base_mon)
  
  			bit 		d_start		;
  			bit			d_stop		;
  			bit			d_data		;
  			bit 		p_bit		;
  
  
  virtual base_intf vinf;
  base_seq_item seq_item;
  uvm_analysis_port# (base_seq_item) item_producer;
    
  
  
  
  function new(string name = "base_mon", parent);
    super.new(name, parent);
    `uvm_info(get_type_name, "CONSTRUCTOR", UVM_DEBUG)
  endfunction
  
  
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
		`uvm_info(get_type_name(), "BUILD_PHASE"	, UVM_FULL)
    if(!uvm_config_db#(virtual base_intf)::get(this, "", "vinf", vinf))
       `uvm_fatal("Can't retrive", " virtual interface")
      item_producer = new("item_producer", this);
    seq_item = new();
  endfunction
    
       
  
  
  task run_phase(uvm_phase phase);
    forever begin
      wait(vinf.reset)
      start_condition();
      slave_address();
      parity_condition();
      stop_condition();
      d_start = 0;
    end
  endtask
  
  
	task start_condition();
    	wait(vinf.reset)
      @(negedge vinf.baud_wire)
    		if(!vinf.tx_out)
              begin
              	`uvm_info(get_type_name(), "START_CONDITION DETECTED", UVM_MEDIUM)
                d_start = 1;
                seq_item.input_data = vinf.data;
              end
    		else 
              begin
        		`uvm_info(get_type_name(), "STOP_CONDITION DETECTED", UVM_MEDIUM)
        		break;
      		end
   
  endtask
  
  
  task slave_address();
    if(seq_item.d_start || vinf.baud_wire)
      for(int i = 0; i <= 7; i++)
        begin
        @(negedge vinf.baud_wire)
          seq_item.uart_data[i] = vinf.tx_out;
          d_start = 1;
        end
    
    seq_item.uart_data_q = seq_item.uart_data;
    d_data = 1;
    break;
  endtask
  
  
  
  task parity_condition();
    if(d_start)
      @(negedge vinf.baud_wire)
      if(vinf.p_sel)
        seq_item.p_bit = ^seq_item.uart_data;
    	else
          seq_item.p_bit = ~(^seq_item.uart_data);
      	break;
    
  endtask
  
  
  
  task stop_condition();
    if(d_start)
      @(negedge vinf.baud_wire)
      if(vinf.baud_wire)
        begin
        seq_item.d_stop = 1;
          `uvm_info(get_type_name(), "STOP_CONDITION DETECTED", UVM_MEDIUM)
        end
    else 
      begin
        `uvm_info(get_type_name(), "STOP_CONDITION DETECTED", UVM_MEDIUM)
        break;
      end
    item_producer.write(seq_item);
  endtask
    	    
  
endclass
