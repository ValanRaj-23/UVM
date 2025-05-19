class base_monitor extends uvm_monitor;
	`uvm_component_utils(base_monitor)
	virtual base_inf vinf;
	base_seq_item seq_item;	
	uvm_analysis_port #(base_seq_item) item_producer;
	event drv_mon;
  function new(string name = "base_monitor",uvm_component parent);
		super.new(name, parent);
		`uvm_info(get_type_name(), "Constructor", UVM_LOW)
		seq_item = new();
	endfunction 
	

	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "Build_phase", UVM_HIGH)
		item_producer = new("item_producer", this);

      if(!(uvm_config_db#(virtual base_inf)::get(this, " ", "vinf", vinf)))
			`uvm_fatal("Interface is not set","unable to retrive virtual intf")
	endfunction


          

        task run_phase(uvm_phase phase);
		forever begin
//           @(drv_mon);
		@(posedge vinf.clk)
          		
				seq_item.rst		<=	vinf.rst;		
				seq_item.en			<=	vinf.en;			
				seq_item.wr			<=	vinf.wr;			
				seq_item.data_in	<=	vinf.data_in;	
				seq_item.addr		<=	vinf.addr;

          `uvm_info("MON - INPUT " ,$sformatf(" rst = %0d en = %0d wr = %0d addr = %0d  data_in = %0d data_out = %0d",vinf.rst, vinf.en, vinf.wr, vinf.addr, vinf.data_in, vinf.data_out), UVM_NONE)                   
				#1;
          
   				seq_item.data_out	<=	vinf.data_out;
          `uvm_info("MON - OUTPUT", $sformatf(" rst = %0d en = %0d wr = %0d addr = %0d  data_in = %0d data_out = %0d",vinf.rst, vinf.en, vinf.wr, vinf.addr, vinf.data_in, vinf.data_out), UVM_NONE)
                          
          		#1;
                          item_producer.write(seq_item);
          `uvm_info(get_type_name, "DONE WRITE", UVM_NONE)
		end
	endtask

endclass

