class base_mon extends uvm_monitor;
	`uvm_component_utils(base_mon)
	base_seq_item		m_item	;
  	virtual base_intf 	vinf;
	uvm_analysis_port#(base_seq_item) item_tx;
	



	function new(string name = "base_mon", uvm_component parent);
		super.new(name, parent);
      		m_item = new();
	endfunction



	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item_tx = new("item_tx", this);
      
      if(!uvm_config_db#(virtual base_intf)::get(this, " ", "vinf", vinf))
        `uvm_fatal("VIRTUAL INTERFACE", "NOT AVAILABLE")
      
	endfunction



	task run_phase(uvm_phase phase);
		super.run_phase(phase);
            `uvm_info(get_type_name(), "RUN_PHASE STARTED", UVM_LOW)
      drive_to_scb();
	endtask

	
  task drive_to_scb();
		forever begin
          start_condition();        
		end   
  endtask

  
  
  task start_condition();
    forever begin
      @(posedge vinf.baud_wire)
      if(vinf.tx_out == 0)
        begin
          `uvm_info(get_type_name(), "START CONDITION DETECTED", UVM_MEDIUM)
          		
          	m_item.data 	<= vinf.data;
          `uvm_info(get_type_name(), $sformatf("input_data = %0d", vinf.data), UVM_MEDIUM)

          
	for(int i = 0; i <= 8; i++)
            begin
    	    @(posedge vinf.baud_wire)
            m_item.tx_data[i]	= vinf.tx_out;
            end
             
          
          `uvm_info(get_type_name(), $sformatf("uart_data = %0d", m_item.tx_data), UVM_MEDIUM)

          
            @(posedge vinf.baud_wire)
          	begin
            if(vinf.tx_out == 1)
              `uvm_info(get_type_name(), "STOP CONDITION DETECTED", UVM_MEDIUM)
			end
             
              item_tx.write(m_item);
		end
	else
      break;
      end
endtask
       
endclass
