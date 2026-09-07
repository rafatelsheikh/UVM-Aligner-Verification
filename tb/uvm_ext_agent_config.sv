`ifndef UVM_EXT_AGENT_CONFIG_SV
    `define UVM_EXT_AGENT_CONFIG_SV

    class uvm_ext_agent_config#(type VIRTUAL_INTF = int) extends uvm_component;
        `uvm_component_param_utils(uvm_ext_agent_config#(VIRTUAL_INTF))

        // defining properties
        protected VIRTUAL_INTF vif;
        protected uvm_active_passive_enum active_passive;
        protected bit has_checks;
        protected bit has_coverage;

        // constructor
        function new(string name = "uvm_ext_agent_config", uvm_component parent);
            super.new(name, parent);

            active_passive = UVM_ACTIVE;
            has_checks = 1;
            has_coverage = 1;
        endfunction

        // virtual interface getter
        virtual function VIRTUAL_INTF get_vif();
            return vif;
        endfunction

        // virtual interface setter
        virtual function void set_vif(VIRTUAL_INTF vif);
            if (this.vif == null) begin
                this.vif = vif;
            end else begin
                `uvm_fatal("ALGORITHM_ISSUE", "Trying to set virtual interface more than once")
            end
        endfunction

        // active passive getter
        virtual function uvm_active_passive_enum get_active_passive();
            return active_passive;
        endfunction

        // active passive setter
        virtual function void set_active_passive(uvm_active_passive_enum active_passive);
            this.active_passive = active_passive;
        endfunction

        // has checks getter
        virtual function bit get_has_checks();
            return has_checks;
        endfunction

        // has checks setter
        virtual function void set_has_checks(bit has_checks);
            this.has_checks = has_checks;
        endfunction

        // has coverage getter
        virtual function bit get_has_coverage();
            return has_coverage;
        endfunction

        // has coverage setter
        virtual function void set_has_coverage(bit has_coverage);
            this.has_coverage = has_coverage;
        endfunction

        // start of simulation phase
        virtual function void start_of_simulation_phase(uvm_phase phase);
            super.start_of_simulation_phase(phase);

            if (get_vif() == null) begin
                `uvm_fatal("ALGORITHM_ISSUE", "The virtual interface is not configured at \"Start of simulation\" phase")
            end else begin
                `uvm_info("CONFIG", "The virtual interface is configured at \"Start of simulation\" phase", UVM_FULL)
            end
        endfunction

        // wait reset start task (not actually implemented here but making sure you should implement it in the child classes)
        virtual task wait_reset_start();
            `uvm_fatal("ALGORITHM_ISSUE", "Must implement wait_reset_start() task")
        endtask

        // wait reset end task (not actually implemented here but making sure you should implement it in the child classes)
        virtual task wait_reset_end();
            `uvm_fatal("ALGORITHM_ISSUE", "Must implement wait_reset_end() task")
        endtask
    endclass
`endif