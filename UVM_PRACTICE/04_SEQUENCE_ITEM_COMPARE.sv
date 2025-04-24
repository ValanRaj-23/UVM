`include "uvm_macros.svh"
import uvm_pkg::*;

class seq_item extends uvm_sequence_item;
  rand	bit A, B, Cin;

  `uvm_object_utils_begin(seq_item)
  		`uvm_field_int(A,UVM_ALL_ON)
		`uvm_field_int(B,UVM_ALL_ON)
  		`uvm_field_int(Cin,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "seq_item");
    super.new(name);
  endfunction
  
  function void display();
    `uvm_info("FULL_ADDER", $sformatf("A = %b B = %b Cin = %b", A, B, Cin), UVM_LOW);
	endfunction
  
endclass
              

module test;
  seq_item st1, st2;
  
  initial begin
    st1 = 	seq_item::type_id::create("st1");
    st2	=	seq_item::type_id::create("st2");
    

    void'(st1.randomize());
    st1.display();
    st2.display();
    
    compare_item();
    
    st2.copy(st1);
    st2.display();
    
    compare_item();
    
  end
  
  function void compare_item();
    if(st1.compare(st2))
      `uvm_info("COMPARE", "st1 and st2 are same", UVM_NONE)
    else
      `uvm_info("COMPARE", "st1 and st2 are not same", UVM_NONE)
  endfunction
endmodule
      
      
// UVM_INFO testbench.sv(18) @ 0: reporter@@st1 [FULL_ADDER] A = 1 B = 0 Cin = 1
// UVM_INFO testbench.sv(18) @ 0: reporter@@st2 [FULL_ADDER] A = 0 B = 0 Cin = 0
// UVM_INFO /apps/vcsmx/vcs/U-2023.03-SP2//etc/uvm-1.2/src/base/uvm_comparer.svh(351) @ 0: reporter [MISCMP] Miscompare for st1.A: lhs = 'h1 : rhs = 'h0
// UVM_INFO /apps/vcsmx/vcs/U-2023.03-SP2//etc/uvm-1.2/src/base/uvm_comparer.svh(382) @ 0: reporter [MISCMP] 1 Miscompare(s) for object st2@340 vs. st1@336
// UVM_INFO testbench.sv(49) @ 0: reporter [COMPARE] st1 and st2 are not same
// UVM_INFO testbench.sv(18) @ 0: reporter@@st2 [FULL_ADDER] A = 1 B = 0 Cin = 1
// UVM_INFO testbench.sv(47) @ 0: reporter [COMPARE] st1 and st2 are same
