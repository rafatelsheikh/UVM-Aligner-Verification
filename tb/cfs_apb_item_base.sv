`ifndef CFS_APB_ITEM_BASE_SV
    `define CFS_APB_ITEM_BASE_SV

    class cfs_apb_item_base extends uvm_sequence_item;
        rand cfs_apb_dir dir;
        rand cfs_apb_addr addr;
        rand cfs_apb_data data;
        
        `uvm_object_utils(cfs_apb_item_base)

        function new(string name = "cfs_apb_item_base");
            super.new(name);
        endfunction

        virtual function string convert2string();
            string result = $sformatf("dir: %0s, addr: %0h", dir.name(), addr);

            return result;
        endfunction
    endclass
`endif