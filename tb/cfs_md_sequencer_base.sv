`ifndef CFS_MD_SEQUENCER_BASE_SV
    `define CFS_MD_SEQUENCER_BASE_SV

    class cfs_md_sequencer_base#(type ITEM_DRV = cfs_md_item_drv) extends uvm_ext_sequencer#(.ITEM_DRV(ITEM_DRV));
        `uvm_component_param_utils(cfs_md_sequencer_base#(ITEM_DRV))

        // constructor
        function new(string name = "cfs_md_sequencer_base", uvm_component parent);
            super.new(name, parent);
        endfunction

        // get data width function (not realy implemented here its just for the child classes :))
        virtual function int unsigned get_data_width();
            `uvm_fatal("ALGORITHM_ISSUE", "Implement get_data_width()")
        endfunction
    endclass

`endif