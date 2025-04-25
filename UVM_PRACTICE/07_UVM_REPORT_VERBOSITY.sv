`include "uvm_macros.svh"
import uvm_pkg::*;

class driver extends uvm_driver;
    
  `uvm_component_utils(driver)
  
  function new(string name = "driver",uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void display();
    `uvm_info("INFO", $sformatf("REPORT VERBOSITY : LOW "), 	UVM_LOW)
    `uvm_info("INFO", $sformatf("REPORT VERBOSITY : NONE "), 	UVM_NONE)
    `uvm_info("INFO", $sformatf("REPORT VERBOSITY : MEDIUM "), 	UVM_MEDIUM)
    `uvm_info("INFO", $sformatf("REPORT VERBOSITY : HIGH "), 	UVM_HIGH)
    `uvm_info("INFO", $sformatf("REPORT VERBOSITY : FULL"), 	UVM_FULL)
    `uvm_info("INFO", $sformatf("REPORT VERBOSITY : DEBUG "), 	UVM_DEBUG)

    `uvm_warning("WARNING", "REPORT SEVERITY")
    `uvm_error("ERROR", "REPORT SEVERITY")
    `uvm_error("FATAL", "REPORT SEVERITY ERROR CHANGED TO [FATAL]")
    
  endfunction    
  
endclass

module test;
  driver drv;
  initial begin
    
    drv = driver::type_id::create("drv", null);
    drv.display();
    
    drv.set_report_verbosity_level(UVM_DEBUG);
    drv.set_report_severity_id_override(UVM_ERROR,"FATAL",UVM_FATAL);
    drv.display();
    
  end
endmodule

   
// UVM_INFO testbench.sv(14) @ 0: drv [INFO] REPORT VERBOSITY : LOW 
// UVM_INFO testbench.sv(15) @ 0: drv [INFO] REPORT VERBOSITY : NONE 
// UVM_INFO testbench.sv(16) @ 0: drv [INFO] REPORT VERBOSITY : MEDIUM 
// UVM_WARNING testbench.sv(21) @ 0: drv [WARNING] REPORT SEVERITY
// UVM_ERROR testbench.sv(22) @ 0: drv [ERROR] REPORT SEVERITY
// UVM_ERROR testbench.sv(23) @ 0: drv [FATAL] REPORT SEVERITY ERROR CHANGED TO [FATAL]
// UVM_INFO testbench.sv(14) @ 0: drv [INFO] REPORT VERBOSITY : LOW 
// UVM_INFO testbench.sv(15) @ 0: drv [INFO] REPORT VERBOSITY : NONE 
// UVM_INFO testbench.sv(16) @ 0: drv [INFO] REPORT VERBOSITY : MEDIUM 
// UVM_INFO testbench.sv(17) @ 0: drv [INFO] REPORT VERBOSITY : HIGH 
// UVM_INFO testbench.sv(18) @ 0: drv [INFO] REPORT VERBOSITY : FULL
// UVM_INFO testbench.sv(19) @ 0: drv [INFO] REPORT VERBOSITY : DEBUG 
// UVM_WARNING testbench.sv(21) @ 0: drv [WARNING] REPORT SEVERITY
// UVM_ERROR testbench.sv(22) @ 0: drv [ERROR] REPORT SEVERITY
// UVM_FATAL testbench.sv(23) @ 0: drv [FATAL] REPORT SEVERITY ERROR CHANGED TO [FATAL]
  
