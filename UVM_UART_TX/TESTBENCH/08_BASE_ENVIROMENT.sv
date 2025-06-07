class base_env extends uvm_env;
	`uvm_component_utils(base_env)

	base_agt	agt;
	base_scb	scb;

	function new(string name = "base_env", uvm_component parent);
		super.new(name, parent);

	endfunction



	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		agt = base_agt::type_id::create("agt", this);
		scb	= base_scb::type_id::create("scb", this);

	endfunction



	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
      agt.mon.item_tx.connect(scb.item_rx);
	endfunction

endclass
