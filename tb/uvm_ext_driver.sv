`ifndef UVM_EXT_DRIVER_SV
    `define UVM_EXT_DRIVER_SV

    class uvm_ext_driver#(type VIRTUAL_INTF = int, type ITEM_DRV = uvm_sequence_item) extends uvm_driver#(.REQ(ITEM_DRV)) implements uvm_ext_reset_handler;
        `uvm_component_param_utils(uvm_ext_driver#(VIRTUAL_INTF, ITEM_DRV))

        // defining properties
        uvm_ext_agent_config#(VIRTUAL_INTF) agent_config;
        protected process process_drive_transactions;

        // constructor
        function new(string name = "uvm_ext_driver", uvm_component parent);
            super.new(name, parent);
        endfunction

        // run phase
        virtual task run_phase(uvm_phase phase);
            forever begin
                fork
                    begin
                        wait_reset_end();
                        drive_transactions();

                        disable fork;
                    end
                join
            end
        endtask

        // drive transaction task (not realy implemented here its just for the child classes :))
        protected virtual task drive_transaction(ITEM_DRV item);
            `uvm_fatal("ALGORITHM_ISSUE", "Implement drive_transaction()")
        endtask

        // drive transactions task
        protected virtual task drive_transactions();
            fork
                begin
                    process_drive_transactions = process::self();

                    forever begin
                        ITEM_DRV item;

                        seq_item_port.get_next_item(item);
                        
                        drive_transaction(item);

                        seq_item_port.item_done();
                    end
                end
            join
        endtask

        // wait reset end task
        protected virtual task wait_reset_end();
            agent_config.wait_reset_end();
        endtask

        // handle reset function
        virtual function void handle_reset(uvm_phase phase);
            if (process_drive_transactions != null) begin
                process_drive_transactions.kill();

                process_drive_transactions = null;
            end
        endfunction
    endclass

`endif