class transmitter extends uvm_component;
  `uvm_component_utils(transmitter)

  uvm_blocking_put_port#(int) send;
  int A = 50;

  function new(string name = "Transmitter", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    send = new("send", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("TX", $sformatf("Sending: %0d", A), UVM_NONE);
    send.put(A);
    phase.drop_objection(this);
  endtask

endclass


class receiver extends uvm_component;
  `uvm_component_utils(receiver)
  int A;

  uvm_blocking_put_imp#(int, receiver) receive;

  function new(string name = "receiver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    receive = new("receive", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    receive.get(A);
    `uvm_info("RX", $sformatf("Received: %0d", A), UVM_NONE);
    phase.drop_objection(this);
  endtask
  
 function void put(int data);
    A = data;
    `uvm_info("RX", $sformatf("Received: %0d", A), UVM_NONE);
  endfunction
endclass


class environment extends uvm_env;
  `uvm_component_utils(environment)

  transmitter tx;
  receiver rx;

  function new(string name = "environment", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx = transmitter::type_id::create("tx", this);
    rx = receiver::type_id::create("rx", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    tx.send.connect(rx.receive);
  endfunction

endclass


class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  environment env;

  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env", this);
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

endclass


module test;
  initial begin
    run_test("my_test");
  end
endmodule



// UVM_INFO @ 0: reporter [RNTST] Running test my_test...
// UVM_INFO /apps/vcsmx/vcs/U-2023.03-SP2//etc/uvm-1.2/src/base/uvm_root.svh(589) @ 0: reporter [UVMTOP] UVM testbench topology:
// -------------------------------------------------
// Name           Type                   Size  Value
// -------------------------------------------------
// uvm_test_top   my_test                -     @336 
//   env          environment            -     @349 
//     rx         receiver               -     @367 
//       receive  uvm_blocking_put_imp   -     @376 
//     tx         transmitter            -     @358 
//       send     uvm_blocking_put_port  -     @386 
// -------------------------------------------------

// UVM_ERROR @ 0: reporter [get] TLM interface task not implemented
// UVM_INFO testbench.sv(44) @ 0: uvm_test_top.env.rx [RX] Received: 0
// UVM_INFO testbench.sv(18) @ 0: uvm_test_top.env.tx [TX] Sending: 50
// UVM_INFO testbench.sv(50) @ 0: uvm_test_top.env.rx [RX] Received: 50
// UVM_INFO /apps/vcsmx/vcs/U-2023.03-SP2//etc/uvm-1.2/src/base/uvm_objection.svh(1276) @ 0: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
// UVM_INFO /apps/vcsmx/vcs/U-2023.03-SP2//etc/uvm-1.2/src/base/uvm_report_server.svh(904) @ 0: reporter [UVM/REPORT/SERVER] 
// --- UVM Report Summary ---

// ** Report counts by severity
// UVM_INFO :    7
// UVM_WARNING :    0
// UVM_ERROR :    1
// UVM_FATAL :    0
// ** Report counts by id
// [RNTST]     1
// [RX]     2
// [TEST_DONE]     1
// [TX]     1
// [UVM/RELNOTES]     1
// [UVMTOP]     1
// [get]     1
