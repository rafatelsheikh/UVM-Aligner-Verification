`ifndef CFS_APB_ITEM_MON_SV
    `define CFS_APB_ITEM_MON_SV

    class cfs_apb_item_mon extends cfs_apb_item_base;
        cfs_apb_response response;
        int unsigned length;
        int unsigned prev_item_delay;

        `uvm_object_utils(cfs_apb_item_mon)

        function new(string name = "cfs_apb_item_mon");
            super.new(name);
        endfunction

        virtual function string convert2string();
            string result = super.convert2string();

            result = {result, $sformatf(", data: %0h, response: %0s, length: %0d, prev_item_delay: %0d", data, response.name(), length, prev_item_delay)};

            return result;
        endfunction
    endclass
`endif