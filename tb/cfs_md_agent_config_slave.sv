`ifndef CFS_MD_AGENT_CONFIG_SLAVE_SV
    `define CFS_MD_AGENT_CONFIG_SLAVE_SV

    class cfs_md_agent_config_slave#(int unsigned DATA_WIDTH = 32) extends cfs_md_agent_config(DATA_WIDTH);
        `uvm_component_param_utils(cfs_md_agent_config_slave#(DATA_WIDTH))

        // defining properties
        local bit ready_at_reset;

        // constructor
        function new(string name = "cfs_md_agent_config_slave", uvm_component parent);
            super.new(name, parent);

            ready_at_reset = 1;
        endfunction

        // ready at reset getter
        virtual function bit get_ready_at_reset();
            return ready_at_reset;
        endfunction

        // ready at reset setter
        virtual function void set_ready_at_reset(bit ready_at_reset);
            this.ready_at_reset = ready_at_reset;
        endfunction
    endclass

`endif