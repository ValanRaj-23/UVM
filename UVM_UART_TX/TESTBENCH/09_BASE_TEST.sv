class base_test extends uvm_test;
	`uvm_component_utils(base_test)

	base_env	env;
	rst_seq		rst;
	wr_seq		wr;
	
  uvm_event sb_done;

	function new(string name = "base_test", uvm_component parent);
		super.new(name, parent);
    `uvm_info(get_type_name, "CONSTRUCTOR", UVM_DEBUG)
	endfunction



	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env	= base_env	::type_id::create("env", this);
      uvm_root::get().set_report_verbosity_level_hier(UVM_DEBUG);
      
      
      uvm_config_db#(uvm_event )::set(null, "*", "sb_done_id", sb_done);
            
    `uvm_info(get_type_name(),"BUILD_PHASE", UVM_FULL)
	endfunction

	
  
  
  function void end_of_elaboration();  
    print();
  endfunction

	
  
  
  task run_phase(uvm_phase phase);
    
		super.run_phase(phase);
      `uvm_info(get_type_name(), "RUN_PHASE STARTED", UVM_MEDIUM)
		phase.raise_objection(this);
      `uvm_info(get_type_name(), "RUN_PHASE STARTED CREATE OBJECT", UVM_MEDIUM)

		rst = rst_seq	::type_id::create("rst");
    	wr 	= wr_seq	::type_id::create("wr");

      `uvm_info(get_type_name(), "RUN_PHASE STARTED CREATE DONE", UVM_MEDIUM)

		#10 rst.start(env.agt.seqr);
		#10 wr.start(env.agt.seqr);
      `uvm_info(get_type_name(), "RUN_PHASE STARTED SEQUENCE", UVM_MEDIUM)

		phase.drop_objection(this);

	endtask


endclass
