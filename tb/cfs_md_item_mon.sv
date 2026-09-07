`ifndef CFS_MD_ITEM_MON_SV
    `define CFS_MD_ITEM_MON_SV

    class cfs_md_item_mon extends cfs_md_item_base;
        `uvm_object_utils(cfs_md_item_mon)

        // defining properties
        int unsigned prev_item_delay;
        int unsigned length;
        bit [7:0] data[$];
        int unsigned offset;
        cfs_md_response response;
        bit is_in_progress;

        // constructor
        function new(string name = "cfs_md_item_mon");
            super.new(name);

            is_in_progress = 0;
        endfunction

        // convert2string function
        virtual function string convert2string();
            string data_as_string = "{";

            foreach (data[i]) begin
                data_as_string = $sformatf("%0s 'h%0h%0s", data_as_string, data[i], ((i == data.size() - 1)? "" : ", "));
            end

            data_as_string = {data_as_string, " }"};

            return $sformatf("[%0t..%0s] data: %0s, size: %0d, offset: %0d, response: %0s, length: %0d, prev_item_delay: %0d", get_begin_time(), (is_in_progress)? "" : $sformatf("%0t", get_end_time()), data_as_string, data.size(), offset, response.name(), length, prev_item_delay);
        endfunction
    endclass

`endif