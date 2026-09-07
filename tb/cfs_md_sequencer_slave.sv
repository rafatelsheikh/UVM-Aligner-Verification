`ifndef CFS_MD_SEQUENCER_SLAVE_SV
    `define CFS_MD_SEQUENCER_SLAVE_SV

    class cfs_md_sequencer_slave#(int unsigned DATA_WIDTH = 32) extends cfs_md_sequencer_base_slave;
        `uvm_component_param_utils(cfs_md_sequencer_slave#(DATA_WIDTH))

        // constructor
        function new(string name = "cfs_md_sequencer_slave", uvm_component parent);
            super.new(name, parent);
        endfunction

        // get data width function
        virtual function int unsigned get_data_width();
            return DATA_WIDTH;
        endfunction
    endclass

`endif