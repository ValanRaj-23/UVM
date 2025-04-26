`include "uvm_macros.svh"
import uvm_pkg::*;

class write extends uvm_object; 
  `uvm_object_utils(write)
  
  function new(string name = "write");
    super.new(name);
    `uvm_info("WRITE", "UVM_SEQUENCE", UVM_LOW)
  endfunction
 
endclass

class read extends write;
  `uvm_object_utils(read)
  
  function new(string name = "read");
    super.new(name);
  endfunction
  
  function void display();
    `uvm_info("READ", "UVM_SEQUENCE", UVM_LOW)
  endfunction
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  
  write wr;
  
  function new(string name = "test", uvm_component parent = "null");
    super.new(name, parent);
  endfunction
 
  function void build_phase(uvm_phase phase);
    uvm_factory factory = uvm_factory::get();
    super.build_phase(phase);
    write::type_id::set_inst_override(read::get_type(), "get_full_name().wr");
    factory.print();
  endfunction
   
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask
    
endclass
  
module test;
  
initial begin
  run_test("test");
end
  
endmodule
    
    
  
