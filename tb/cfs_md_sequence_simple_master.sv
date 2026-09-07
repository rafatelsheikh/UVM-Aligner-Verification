`ifndef CFS_MD_SEQUENCE_SIMPLE_MASTER_SV
    `define CFS_MD_SEQUENCE_SIMPLE_MASTER_SV

    class cfs_md_sequence_simple_master extends cfs_md_sequence_base_master;
        `uvm_object_utils(cfs_md_sequence_simple_master)
        
        // defining properties
        rand cfs_md_item_drv_master item;
        local int unsigned data_width; // used to calculate the data width to use it in constraints (as some simulators doesn't support using function in constraints)

        // constraints
        constraint item_hard {
            item.data.size() > 0;
            item.data.size() <= data_width / 8;
            item.offset < data_width / 8;
            item.data.size() + item.offset <= data_width / 8;
        }

        // constructor
        function new(string name = "cfs_md_sequence_simple_master");
            super.new(name);

            item = cfs_md_item_drv_master::type_id::create("item");

            item.data_default.constraint_mode(0);
            item.offset_default.constraint_mode(0);
        endfunction

        // pre randomize function
        function void pre_randomize();
            data_width = p_sequencer.get_data_width();
        endfunction

        // body task
        virtual task body();
            `uvm_send(item)
        endtask
    endclass

`endif