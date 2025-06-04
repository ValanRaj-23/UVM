class base_drv extends uvm_driver#(base_seq_item);
  `uvm_component_utils(base_drv)
  virtual base_intf vinf;
  
  event drv_to_scb;
   
  
  
  function new(string name = "base_drv", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name, "CONSTRUCTOR", UVM_DEBUG)
  endfunction
  
  
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(),"BUILD_PHASE", UVM_FULL)
    
    if(!uvm_config_db#(virtual base_intf)::get(this, "", "vinf", vinf))
       `uvm_fatal("Can't retrive", " virtual interface")
  endfunction
    
       
 
      
      task run_phase(uvm_phase phase);
   		forever begin
          `uvm_info(get_type_name(), "RUN_PHASE", UVM_MEDIUM)
			seq_item_port.get_next_item(req);
          		@(posedge vinf.clk)
          		vinf.data 	<= req.data;
          		@(drv_to_scb);
          	seq_item_port.item_done();
          `uvm_info(get_type_name(), $sformatf("RUN_PHASE : data = %0d", vinf.data), UVM_MEDIUM)
        end
      endtask    

  
endclass
  
  
  
