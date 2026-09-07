`ifndef CFS_MD_AGENT_CONFIG_SV
    `define CFS_MD_AGENT_CONFIG_SV

    class cfs_md_agent_config#(int unsigned DATA_WIDTH = 32) extends uvm_ext_agent_config#(.VIRTUAL_INTF(virtual cfs_md_if#(DATA_WIDTH)));
        `uvm_component_param_utils(cfs_md_agent_config#(DATA_WIDTH))

        // define the type for the virtual interface
        typedef virtual cfs_md_if#(DATA_WIDTH) cfs_md_vif;

        // defining the properties
        local time sample_delay_start_tr;
        local int unsigned stuck_threshold;

        // the constructor
        function new(string name = "cfs_md_agent_config", uvm_component parent);
            super.new(name, parent);

            sample_delay_start_tr = 1ns;
            stuck_threshold = 1000;
        endfunction

        // virtual interface setter
        virtual function void set_vif(cfs_md_vif vif);
            super.set_vif(vif);

            set_has_checks(get_has_checks());
        endfunction

        // has checks setter
        virtual function void set_has_checks(bit has_checks);
            super.set_has_checks(has_checks);

            if (vif != null) begin
                vif.has_checks = has_checks;
            end
        endfunction

        // sample delay start tr getter
        virtual function time get_sample_delay_start_tr();
            return sample_delay_start_tr;
        endfunction

        // sample delay start tr setter
        virtual function void set_sample_delay_start_tr(time sample_delay_start_tr);
            this.sample_delay_start_tr = sample_delay_start_tr;
        endfunction

        // stuck threshold getter
        virtual function int unsigned get_stuck_threshold();
            return stuck_threshold;
        endfunction

        // stuck threshold setter
        virtual function void set_stuck_threshold(int unsigned stuck_threshold);
            this.stuck_threshold = stuck_threshold;
        endfunction

        // run phase
        virtual task run_phase(uvm_phase phase);
            forever begin
                @(vif.has_checks);

                if (vif.has_checks != get_has_checks()) begin
                    `uvm_error("ALGORITHM_ISSUE", $sformatf("Can not change \"has_checks\" from MD interface directly - use %0s.set_has_checks()", get_full_name()))
                end
            end
        endtask

        // wait reset start task
        virtual task wait_reset_start();
            if (vif.reset_n !== 0) begin
                @(negedge vif.reset_n);
            end
        endtask

        // wait reset end task
        virtual task wait_reset_end();
            while (vif.reset_n == 0) begin
                @(posedge vif.clk);
            end
        endtask
    endclass

`endif