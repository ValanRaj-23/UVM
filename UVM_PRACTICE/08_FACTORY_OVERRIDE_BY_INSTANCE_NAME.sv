`include "uvm_macros.svh"
import uvm_pkg::*;

class write extends uvm_object; 
  `uvm_object_utils(write)
  
  function new(string name = "write");
    super.new(name);
    `uvm_info("WRITE", "UVM_SEQUENCE", UVM_LOW)
  endfunction

  function void display();
    `uvm_info("WRITE", "Display from WRITE class", UVM_LOW)
  endfunction
  
endclass

class read extends write;
  `uvm_object_utils(read)
  
  function new(string name = "read");
    super.new(name);
  endfunction
  
  function void display();
    `uvm_info("READ", "Display from READ class", UVM_LOW)
  endfunction
  
endclass

class container extends uvm_object;
  `uvm_object_utils(container)

  read rd;
  read rd1;

  function new (string name = "container");
    super.new(name);
  endfunction
 
  function void build();
    uvm_factory::get().set_inst_override_by_type(read::get_type(), write::get_type(), "rd");

    rd  = read::type_id::create("rd",this);
    rd1 = read::type_id::create("rd1",this);

    rd.display();
    rd1.display();
  endfunction
  	
endclass
  
module my_test;
   container cr;

   initial begin
     cr = container::type_id::create("cr");
     cr.build();
   end
  
endmodule
