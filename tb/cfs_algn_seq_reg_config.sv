`ifndef CFS_ALGN_SEQ_REG_CONFIG_SV
    `define CFS_ALGN_SEQ_REG_CONFIG_SV

    class cfs_algn_seq_reg_config extends uvm_reg_sequence;
        `uvm_object_utils(cfs_algn_seq_reg_config)

        // defining properties
        cfs_algn_reg_block reg_block;

        // constructor
        function new(string name = "cfs_algn_seq_reg_config");
            super.new(name);
        endfunction

        // body task
        virtual task body();
            uvm_status_e status;
            uvm_reg_data_t data;

            void'(reg_block.CTRL.randomize());

            reg_block.CTRL.update(status);
            
            reg_block.CTRL.read(status, data);
        endtask
    endclass

`endif