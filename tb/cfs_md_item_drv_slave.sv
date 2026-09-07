`ifndef CFS_MD_ITEM_DRV_SLAVE_SV
    `define CFS_MD_ITEM_DRV_SLAVE_SV

    class cfs_md_item_drv_slave extends cfs_md_item_drv;
        `uvm_object_utils(cfs_md_item_drv_slave)

        // defining properties
        rand int unsigned length;
        rand cfs_md_response response;
        rand bit ready_at_end;

        // default soft constraints
        constraint length_default {
            soft length <= 5;
        }

        // constructor
        function new(string name = "cfs_md_item_drv_slave");
            super.new(name);
        endfunction

        // convert2string function
        virtual function string convert2string();
            return $sformatf("length: %0d, response: %0s, ready_at_end: %0d", length, response.name(), ready_at_end);
        endfunction
    endclass

`endif