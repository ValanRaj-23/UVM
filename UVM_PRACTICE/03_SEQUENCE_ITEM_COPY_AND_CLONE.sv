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
  
//   function void display();
//     `uvm_info("FULL_ADDER", $sformatf("A = %b B = %b Cin = %b", A, B, Cin), UVM_LOW);
// 	endfunction
  
endclass
              

module test;
  seq_item st1, st2, st3;
  
  initial begin
    st1 = 	seq_item::type_id::create("st1");
    st2	=	seq_item::type_id::create("st2");
    

    void'(st1.randomize());
    st1.print();
    st2.print();
    
    st2.copy(st1);
    st2.print();
    
    st3 = seq_item'(st1.clone()); 
//     st3 = $cast(seq_item, (st1.clone()));
//     UVM doesn't automatically know that it's a seq_item.
    
    st3.print();
  end
endmodule


// ----------------------------
// Name   Type      Size  Value
// ----------------------------
// st1    seq_item  -     @336 
//   A    integral  1     'h1  
//   B    integral  1     'h0  
//   Cin  integral  1     'h1  
// ----------------------------
// ----------------------------
// Name   Type      Size  Value
// ----------------------------
// st2    seq_item  -     @340 
//   A    integral  1     'h0  
//   B    integral  1     'h0  
//   Cin  integral  1     'h0  
// ----------------------------
// ----------------------------
// Name   Type      Size  Value
// ----------------------------
// st2    seq_item  -     @340 
//   A    integral  1     'h1  
//   B    integral  1     'h0  
//   Cin  integral  1     'h1  
// ----------------------------
// ----------------------------
// Name   Type      Size  Value
// ----------------------------
// st1    seq_item  -     @344 
//   A    integral  1     'h1  
//   B    integral  1     'h0  
//   Cin  integral  1     'h1  
// ----------------------------
//            V C S   S i m u l a t i o n   R e p o r t 
