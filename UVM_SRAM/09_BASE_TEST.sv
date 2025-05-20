class base_test extends uvm_test;
	`uvm_component_utils(base_test)

	base_env env;
	base_seq seq;
  	rst_seq  	r_seq;
  	write_seq 	wr_seq;
  	read_seq	rd_seq;

  
  
  
	function new(string name = "test",uvm_component parent );
	       super.new(name, parent);
      `uvm_info(get_type_name(), "Constructor", UVM_LOW)
	endfunction

  
  
  
  
	function void build_phase(uvm_phase phase);
      super.build_phase(phase);
		env = base_env::type_id::create("env", this);
      `uvm_info(get_type_name(), "build_phase", UVM_HIGH)
      
      uvm_root::get().set_report_verbosity_level_hier(UVM_NONE);

	endfunction


  
  function void end_of_elaboration();
    `uvm_info("Test Class", "elob phase", UVM_MEDIUM)
    print();
  endfunction
  
  
  
  
  
	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
		seq 	= base_seq::type_id::create("seq");
      	r_seq	= rst_seq::type_id::create("r_seq");
      	wr_seq	= write_seq::type_id::create("wr_seq");
      	rd_seq	= read_seq::type_id::create("rd_seq");
      
      `uvm_info(get_type_name(), "RUN PHASE", UVM_NONE)

      repeat(1) r_seq.start(env.agt.seqr);
      repeat(4) wr_seq.start(env.agt.seqr);
      repeat(4) rd_seq.start(env.agt.seqr);

      phase.drop_objection(this);

	endtask


endclass
