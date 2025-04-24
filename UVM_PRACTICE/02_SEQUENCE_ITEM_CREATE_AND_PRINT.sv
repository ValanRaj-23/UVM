`include "uvm_macros.svh"
import uvm_pkg::*;

class seq_item extends uvm_sequence_item;
  rand 	bit A, B, Cin;

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
  seq_item st;
  
  initial begin
    st = seq_item::type_id::create();
    
    repeat(3)
      begin
        void'(st.randomize());
        st.print();
      end
  end
endmodule

// -------------------------------
// Name      Type      Size  Value
// -------------------------------
// seq_item  seq_item  -     @336 
//   A       integral  1     'h1  
//   B       integral  1     'h0  
//   Cin     integral  1     'h1  
// -------------------------------
// -------------------------------
// Name      Type      Size  Value
// -------------------------------
// seq_item  seq_item  -     @336 
//   A       integral  1     'h1  
//   B       integral  1     'h0  
//   Cin     integral  1     'h0  
// -------------------------------
// -------------------------------
// Name      Type      Size  Value
// -------------------------------
// seq_item  seq_item  -     @336 
//   A       integral  1     'h0  
//   B       integral  1     'h0  
//   Cin     integral  1     'h1  
// -------------------------------
