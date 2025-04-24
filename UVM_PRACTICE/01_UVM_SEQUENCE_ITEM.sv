`include "uvm_macros.svh"
import uvm_pkg::*;

class seq_item extends uvm_sequence_item;
  
  rand bit [3:0] data;
  rand bit [1:0] addr;
 
  function new(string name = "seq_item");
      super.new(name);
    `uvm_info("Sequence","Created the Object", UVM_LOW) // requries three arguments
   endfunction
    
    function void display();
      `uvm_info("Randomized" , $sformatf("Addr = %d | Data = %d", addr, data), UVM_LOW)
    endfunction
    
endclass
    
module test;
  seq_item st;
  
  initial begin
    st = new();
    
    repeat(4)
    begin
      void'(st.randomize());
      st.display();
      #5;
  end
  end
endmodule


// UVM_INFO testbench.sv(11) @ 0: reporter@@seq_item [Sequence] Created the Object
// UVM_INFO testbench.sv(15) @ 0: reporter@@seq_item [Randomized] Addr = 0 | Data =  9
// UVM_INFO testbench.sv(15) @ 5: reporter@@seq_item [Randomized] Addr = 0 | Data = 11
// UVM_INFO testbench.sv(15) @ 10: reporter@@seq_item [Randomized] Addr = 2 | Data = 10
// UVM_INFO testbench.sv(15) @ 15: reporter@@seq_item [Randomized] Addr = 2 | Data =  7
