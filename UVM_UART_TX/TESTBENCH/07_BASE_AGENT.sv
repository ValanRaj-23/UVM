class base_agent extends uvm_agent;
	`uvm_component_utils(base_agent)

	base_seqr	seqr;
	base_drv 	drv;
	base_mon	mon;
  
//   	event drv_mon;


	function new(string name = "base_agent",uvm_component parent);
		super.new(name, parent);
    `uvm_info(get_type_name, "CONSTRUCTOR", UVM_DEBUG)
	endfunction




	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      	seqr 	= base_seqr	::type_id::create("seqr",this);
      	drv	= base_drv	::type_id::create("drv",this);	 
      	mon	= base_mon	::type_id::create("mon",this);
      	`uvm_info(get_type_name, "BUILD_PHASE", UVM_FULL)
	endfunction 




	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
      `uvm_info(get_type_name(),"CONNECT_PHASE", UVM_HIGH)
		drv.seq_item_port.connect(seqr.seq_item_export);
	endfunction 
  
  
endclass	
