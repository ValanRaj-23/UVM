`include "uvm_macros.svh"
import uvm_pkg::*;

class parent extends uvm_component;
	`uvm_component_utils(parent)

	function new(string name = "parent", uvm_component parent);
		super.new(name,parent);
      		`uvm_info("Parent", "Parent class", UVM_LOW)

	endfunction

	function void display();
		`uvm_info("Parent", "Parent class", UVM_LOW)
	endfunction

endclass


class child extends parent;
	`uvm_component_utils(child)

	function new(string name = "child", uvm_component parent);
		super.new(name,parent);
      		`uvm_info("Child", "Child class", UVM_LOW)

	endfunction

	function void display();
		`uvm_info("Child", "Child class", UVM_LOW)
	endfunction

endclass

class test extends uvm_test;
	`uvm_component_utils(test)
	parent pr;
  	child ch;

	function new(string name = "test", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		uvm_factory factory = uvm_factory::get();
      	super.build_phase(phase);
		set_type_override_by_type(parent::get_type(), child::get_type());
		pr = parent::type_id::create("pr",this);
      	ch = child::type_id::create("ch",this);

      factory.print();
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
// 		pr.display();
//       ch.display();
      	
	endtask

endclass

module tb_test;
initial begin
  run_test("test");
end
endmodule




