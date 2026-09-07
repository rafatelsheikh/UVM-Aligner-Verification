`ifndef CFS_ALGN_ENV_CONFIG_SV
    `define CFS_ALGN_ENV_CONFIG_SV

    class cfs_algn_env_config extends uvm_component;
        `uvm_component_utils(cfs_algn_env_config)

        // defining interface
        protected cfs_algn_vif vif;

        // defining properties
        local bit has_checks;
        local bit has_coverage;
        local int unsigned algn_data_width;
        local int unsigned exp_rx_response_threshold;
        local int unsigned exp_tx_item_threshold;
        local int unsigned exp_irq_threshold;

        // constructor
        function new(string name = "cfs_algn_env_config", uvm_component parent);
            super.new(name, parent);

            has_checks = 1;
            has_coverage = 1;
            algn_data_width = 8;
            exp_rx_response_threshold = 10;
            exp_tx_item_threshold = 10;
            exp_irq_threshold = 10;
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

        // algn data width getter
        virtual function int unsigned get_algn_data_width();
            return algn_data_width;
        endfunction

        // algn data width setter
        virtual function void set_algn_data_width(int unsigned algn_data_width);
            if (algn_data_width < 8) begin
               `uvm_fatal("ALGORITHM_ISSUE", $sformatf("The minimum legal value for algn_data_width is 8 but user tried to set it to %0d", algn_data_width)) 
            end

            if ($countones(algn_data_width) != 1) begin
               `uvm_fatal("ALGORITHM_ISSUE", $sformatf("The value for algn_data_width must be a power of 2 but user tried to set it to %0d", algn_data_width)) 
            end
            
            this.algn_data_width = algn_data_width;
        endfunction

        // exp rx response threshold getter
        virtual function int unsigned get_exp_rx_response_threshold();
            return exp_rx_response_threshold;
        endfunction

        // exp rx response threshold setter
        virtual function void set_exp_rx_response_threshold(int unsigned exp_rx_response_threshold);
            this.exp_rx_response_threshold = exp_rx_response_threshold;
        endfunction

        // exp tx item threshold getter
        virtual function int unsigned get_exp_tx_item_threshold();
            return exp_tx_item_threshold;
        endfunction

        // exp tx item threshold setter
        virtual function void set_exp_tx_item_threshold(int unsigned exp_tx_item_threshold);
            this.exp_tx_item_threshold = exp_tx_item_threshold;
        endfunction

        // exp irq threshold getter
        virtual function int unsigned get_exp_irq_threshold();
            return exp_irq_threshold;
        endfunction

        // exp irq threshold setter
        virtual function void set_exp_irq_threshold(int unsigned exp_irq_threshold);
            this.exp_irq_threshold = exp_irq_threshold;
        endfunction

        // vif getter
        virtual function cfs_algn_vif get_vif();
            return vif;
        endfunction

        // vif setter
        virtual function void set_vif(cfs_algn_vif vif);
            if (this.vif == null) begin
                this.vif = vif;
            end else begin
               `uvm_fatal("ALGORITHM_ISSUE", "Trying to set the virtual interface more than once") 
            end
        endfunction

        // start of simulation phase
        virtual function void start_of_simulation_phase(uvm_phase phase);
            super.start_of_simulation_phase(phase);

            if (get_vif() == null) begin
                `uvm_fatal("ALGORITHM_ISSUE", "The Aligner virtual interface is not configured at \"Start of simulation\" phase")
            end else begin
                `uvm_info("CONFIG", "The Aligner virtual interface is configured at \"Start of simulation\" phase", UVM_FULL)
            end
        endfunction
    endclass

`endif