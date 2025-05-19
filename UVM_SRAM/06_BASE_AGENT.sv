class base_agent extends uvm_agent;
	`uvm_component_utils(base_agent)

	base_seqr 		seqr;
	base_driver 	drv;
	base_monitor	mon;
  
  	event drv_mon;


	function new(string name = "base_agent",uvm_component parent);
		super.new(name, parent);
		`uvm_info(get_type_name(), "Constructor", UVM_LOW)
	endfunction




	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "Build_phase", UVM_HIGH)
      	seqr 	= base_seqr		::type_id::create("seqr",this);
      	drv		= base_driver	::type_id::create("drv",this);	 
      	mon		= base_monitor	::type_id::create("mon",this);
      
      	drv.drv_mon	= drv_mon;
      	mon.drv_mon = drv_mon;
      
	endfunction 




	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(seqr.seq_item_export);
	endfunction 
  
endclass	
