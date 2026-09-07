`ifndef CFS_ALGN_VIRTUAL_SEQUENCER_SV
    `define CFS_ALGN_VIRTUAL_SEQUENCER_SV

    class cfs_algn_virtual_sequencer extends uvm_sequencer;
        `uvm_component_utils(cfs_algn_virtual_sequencer)
        
        // defining sequencers handles
        uvm_sequencer_base apb_sequencer;
        cfs_md_sequencer_base_master md_rx_sequencer;
        cfs_md_sequencer_base_slave md_tx_sequencer;

        // defining the model handler
        cfs_algn_model model;

        // constructor
        function new(string name = "cfs_algn_virtual_sequencer", uvm_component parent);
            super.new(name, parent);
        endfunction
    endclass

`endif