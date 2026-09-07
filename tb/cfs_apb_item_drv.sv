`ifndef CFS_APB_ITEM_DRV_SV
    `define CFS_APB_ITEM_DRV_SV

    class cfs_apb_item_drv extends cfs_apb_item_base;
        rand int unsigned pre_drive_delay;
        rand int unsigned post_drive_delay;

        constraint pre_drive_delay_default {
            soft pre_drive_delay <= 5;
        }

        constraint post_drive_delay_default {
            soft post_drive_delay <= 5;
        }

        `uvm_object_utils(cfs_apb_item_drv)

        function new(string name = "cfs_apb_item_drv");
            super.new(name);
        endfunction

        virtual function string convert2string();
            string result = super.convert2string();

            if (dir == CFS_APB_WRITE) begin
                result = {result, $sformatf(", data: %0h", data)};
            end

            result = {result, $sformatf(", pre_drive_delay: %0d, post_drive_delay: %0d", pre_drive_delay, post_drive_delay)};

            return result;
        endfunction
    endclass
`endif