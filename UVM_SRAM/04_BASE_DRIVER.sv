class base_driver extends uvm_driver#(base_seq_item);
	`uvm_component_utils(base_driver)
	virtual base_inf vinf;


	
	function new(string name = "base_driver",uvm_component parent);
		super.new(name, parent);
		`uvm_info(get_type_name(), "Constructor", UVM_LOW)
	endfunction




  function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "Build_phase", UVM_HIGH)
		
    if(!uvm_config_db#(virtual base_inf)::get(this, "", "vinf", vinf))
			`uvm_fatal("Interface is not set","unable to retrive virtual intf")
	endfunction




	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
				vinf.rst		<=	req.rst;
      			vinf.en			<=	req.en;
      			vinf.wr			<=	req.wr;
      			vinf.data_in	<=	req.data_in;
      			vinf.data_out	<=	req.data_out;
      			vinf.addr		<=	req.addr;							seq_item_port.item_done();
		end
	endtask
    
    
    
    
    
//     task drive();

//     endtask

endclass



	
