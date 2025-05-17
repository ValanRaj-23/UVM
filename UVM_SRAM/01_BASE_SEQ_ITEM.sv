class base_seq_item extends uvm_sequence_item;

	rand logic			rst;
	rand logic			en;
	rand logic			wr;
	rand logic [3:0]	data_in;
		 logic [3:0]	data_out;
	randc logic [1:0]	addr;	


	`uvm_object_utils_begin(base_seq_item)
		`uvm_field_int(rst,UVM_ALL_ON)
		`uvm_field_int(en,UVM_ALL_ON)
		`uvm_field_int(wr,UVM_ALL_ON)
		`uvm_field_int(data_in,UVM_ALL_ON)
		`uvm_field_int(data_out,UVM_ALL_ON)
		`uvm_field_int(addr,UVM_ALL_ON)
	`uvm_object_utils_end


	function new(string name = "base_seq_ite");
      super.new(name);
		`uvm_info(get_type_name(), "Constructor", UVM_LOW)
	endfunction
  
  constraint c1{ rst == 1;}
  constraint c2{ en == 1;
                wr dist {1 := 50, 0:= 50};}
  constraint c3{ if(wr == 0)
                   data_in == 'h0;
               	else                      																data_in inside { [0:15] };
               }
                  
endclass
