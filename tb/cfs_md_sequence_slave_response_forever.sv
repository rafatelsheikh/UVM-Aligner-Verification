`ifndef CFS_MD_SEQUENCE_SLAVE_RESPONSE_FOREVER_SV
    `define CFS_MD_SEQUENCE_SLAVE_RESPONSE_FOREVER_SV

    class cfs_md_sequence_slave_response_forever extends cfs_md_sequence_base_slave;
        `uvm_object_utils(cfs_md_sequence_slave_response_forever)
        
        // constructor
        function new(string name = "cfs_md_sequence_slave_response_forever");
            super.new(name);
        endfunction

        // body task
        virtual task body();
            forever begin
                cfs_md_sequence_slave_response seq = cfs_md_sequence_slave_response::type_id::create("seq");

                `uvm_do_on(seq, p_sequencer)
            end
        endtask
    endclass

`endif