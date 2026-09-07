`ifndef CFS_MD_SEQUENCE_SLAVE_RESPONSE_SV
    `define CFS_MD_SEQUENCE_SLAVE_RESPONSE_SV

    class cfs_md_sequence_slave_response extends cfs_md_sequence_base_slave;
        `uvm_object_utils(cfs_md_sequence_slave_response)
        
        // constructor
        function new(string name = "cfs_md_sequence_slave_response");
            super.new(name);
        endfunction

        // body task
        virtual task body();
            cfs_md_item_mon item_mon;

            p_sequencer.pending_items.get(item_mon);
            
            begin
                cfs_md_sequence_simple_slave seq;
        
                `uvm_do(seq)
            end
        endtask
    endclass

`endif