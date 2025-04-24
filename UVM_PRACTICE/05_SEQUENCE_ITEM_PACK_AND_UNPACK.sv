`include "uvm_macros.svh"
import uvm_pkg::*;

class seq_item extends uvm_sequence_item;
  rand	bit [7:0] data;
  rand  bit [3:0] addr;


  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(data,UVM_ALL_ON)
  `uvm_field_int(addr,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "seq_item");
    super.new(name);
  endfunction
  
  function void display();
    `uvm_info("MEMORY", $sformatf("DATA = %d ADDR = %d", data, addr), UVM_LOW);
	endfunction
  
endclass
              

module test;
  byte unsigned byte_packed[]; 
  
  seq_item st1, st2;
  
  initial begin
    st1 = 	seq_item::type_id::create("st1");
    st2 =   seq_item::type_id::create("st2");

    void'(st1.randomize());
    
    contents();
    compare_item();
    
    st1.pack_bytes(byte_packed);
    
    foreach(byte_packed[i])
    begin
      `uvm_info("Packed", $sformatf("byte_packed[%0d] = %b", i, byte_packed[i]), UVM_LOW);
    end
    
    st2.unpack_bytes(byte_packed); 
    contents();
    compare_item();
  end
  
  function void compare_item();
    if(st1.compare(st2))
      `uvm_info("COMPARE", "st1 and st2 are same", UVM_NONE)
      
    else
      `uvm_info("COMPARE", "st1 and st2 are not same", UVM_NONE)
  endfunction
  
  function void contents();
    st1.display();
    st2.display();
  endfunction
    

endmodule
      
// UVM_INFO testbench.sv(19) @ 0: reporter@@st1 [MEMORY] DATA = 185 ADDR = 12
// UVM_INFO testbench.sv(19) @ 0: reporter@@st2 [MEMORY] DATA =   0 ADDR =  0
// UVM_INFO /apps/vcsmx/vcs/U-2023.03-SP2//etc/uvm-1.2/src/base/uvm_comparer.svh(351) @ 0: reporter [MISCMP] Miscompare for st1.data: lhs = 'hb9 : rhs = 'h0
// UVM_INFO /apps/vcsmx/vcs/U-2023.03-SP2//etc/uvm-1.2/src/base/uvm_comparer.svh(382) @ 0: reporter [MISCMP] 1 Miscompare(s) for object st2@340 vs. st1@336
// UVM_INFO testbench.sv(56) @ 0: reporter [COMPARE] st1 and st2 are not same
// UVM_INFO testbench.sv(43) @ 0: reporter [Packed] byte_packed[0] = 10111001
// UVM_INFO testbench.sv(43) @ 0: reporter [Packed] byte_packed[1] = 11000000
// UVM_INFO testbench.sv(19) @ 0: reporter@@st1 [MEMORY] DATA = 185 ADDR = 12
// UVM_INFO testbench.sv(19) @ 0: reporter@@st2 [MEMORY] DATA = 185 ADDR = 12
// UVM_INFO testbench.sv(53) @ 0: reporter [COMPARE] st1 and st2 are same
//            V C S   S i m u l a t i o n   R e p o r t 
