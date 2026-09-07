`ifndef UVM_EXT_MONITOR_SV
    `define UVM_EXT_MONITOR_SV

    class uvm_ext_monitor#(type VIRTUAL_INTF = int, type ITEM_MON = uvm_sequence_item) extends uvm_monitor implements uvm_ext_reset_handler;
        `uvm_component_param_utils(uvm_ext_monitor#(VIRTUAL_INTF, ITEM_MON))

        // defining properties
        uvm_ext_agent_config#(VIRTUAL_INTF) agent_config;
        uvm_analysis_port#(ITEM_MON) output_port;
        protected process process_collect_transactions;

        // constructor
        function new(string name = "uvm_ext_monitor", uvm_component parent);
            super.new(name, parent);

            output_port = new("output_port", this);
        endfunction

        // run phase
        virtual task run_phase(uvm_phase phase);
            forever begin
                fork
                    begin
                        wait_reset_end();
                        collect_transactions();

                        disable fork;
                    end 
                join
            end
        endtask

        // collect transaction task (not actually implemented here but making sure you should implement it in the child classes)
        protected virtual task collect_transaction();
            `uvm_fatal("ALGORITHM_ISSUE", "Must implement collect_transaction() task")
        endtask

        // collect transactions task
        protected virtual task collect_transactions();
            fork
                begin
                    process_collect_transactions = process::self();

                    forever begin
                        collect_transaction();
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
            if (process_collect_transactions != null) begin
                process_collect_transactions.kill();

                process_collect_transactions = null;
            end
        endfunction
    endclass

`endif