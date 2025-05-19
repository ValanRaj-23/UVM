`define PASSED `uvm_info(get_type_name()," CONDITION PASSED ", UVM_NONE)
`define FAILED `uvm_error(get_type_name()," CONDITION FAILED ")




class base_scb extends uvm_scoreboard;
	`uvm_component_utils(base_scb)
	base_seq_item seq_item_q[$];
  uvm_analysis_imp #(base_seq_item, base_scb) item_receiver;

  reg [3:0] t_mem [8];
  	reg [3:0] t_data;

	function new(string name = "base_scb",uvm_component parent);
		super.new(name, parent);
		`uvm_info(get_type_name(), "Constructor", UVM_LOW)
	endfunction




	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item_receiver = new("item_receiver", this);
		`uvm_info(get_type_name(), "Build_phase", UVM_HIGH)
	endfunction




  function void write(base_seq_item tx_write);
		`uvm_info(get_type_name(), "Write function", UVM_LOW)
    seq_item_q.push_back(tx_write);
	endfunction 




  task run_phase(uvm_phase phase);
      base_seq_item tx;
      super.run_phase(phase);
    
		forever begin
          `uvm_info("RUN_PHASE", "BEFORE WAIT", UVM_LOW)
          wait(seq_item_q.size() > 0);
          if(seq_item_q.size() > 0)
            begin
              tx = seq_item_q.pop_front();
              `uvm_info("SCORE_BOARD", $sformatf(" rst = %0d en = %0d wr = %0d addr = %0d  data_in = %0d data_out = %0d", tx.rst,  tx.en,  tx.wr,  tx.addr,  tx.data_in,  tx.data_out), UVM_MEDIUM)
              golden_model(tx);
            end
		end
	endtask
  
  
  
    
  task golden_model(base_seq_item tx);
    		if(!tx.rst)
              begin
                foreach(t_mem[i])
                  t_mem[i] = 0;
                `uvm_info(" SCB RST", " RESET CONDITION PASSED" ,UVM_NONE)
              end
            else
                if(tx.en && tx.wr)
                  	begin
					t_mem[tx.addr] = tx.data_in;
                      `uvm_info("SCB WIRTE", $sformatf(" wr = %0d addr = %0d data_in = %0d", tx.wr, tx.addr, tx.data_in),UVM_NONE)  
                	end
              	else if(tx.en && !tx.wr)
                  	begin
    				t_data = t_mem[tx.addr];
                      `uvm_info("SCB READ", $sformatf(" wr = %0d addr = %0d data_out = %0d  t_data = %0d", tx.wr, tx.addr, tx.data_out, t_data),UVM_NONE)  

                    	if(tx.data_out == t_data) 	`PASSED
                    	else						`FAILED
                     
					end
endtask

endclass

