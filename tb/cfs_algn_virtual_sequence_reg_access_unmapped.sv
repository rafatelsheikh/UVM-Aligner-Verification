`ifndef CFS_ALGN_VIRTUAL_SEQUENCE_REG_ACCESS_UNMAPPED_SV
    `define CFS_ALGN_VIRTUAL_SEQUENCE_REG_ACCESS_UNMAPPED_SV

    class cfs_algn_virtual_sequence_reg_access_unmapped extends cfs_algn_virtual_sequence_base;
        `uvm_object_utils(cfs_algn_virtual_sequence_reg_access_unmapped)

        // defining number of accesses
        rand int unsigned num_accesses;

        // constraints
        constraint num_access_default {
            soft num_accesses inside {[150:200]};
        }

        // constructor
        function new(string name = "cfs_algn_virtual_sequence_reg_access_unmapped");
            super.new(name);
        endfunction

        // body task
        virtual task body();
            uvm_reg_addr_t addresses[$];
      
            get_reg_addresses(addresses);
            
            for (int unsigned access_idx = 0; access_idx < num_accesses; access_idx++) begin
                cfs_apb_sequence_simple seq;
                
                `uvm_do_on_with(seq, p_sequencer.apb_sequencer, {
                    !(item.addr inside {addresses});
                });
                
                wait_random_time();
            end
        endtask

        // get reg addresses function
        protected virtual function void get_reg_addresses(ref uvm_reg_addr_t addresses[$]);
            uvm_reg registers[$];
            p_sequencer.model.reg_block.get_registers(registers);
            
            foreach (registers[reg_idx]) begin
                for (int byte_idx = 0; byte_idx < registers[reg_idx].get_n_bits() / 8; byte_idx++) begin
                    addresses.push_back(registers[reg_idx].get_address() + byte_idx);
                end
            end
        endfunction

        // wait random time task
        protected virtual task wait_random_time();
            cfs_algn_vif vif = p_sequencer.model.env_config.get_vif();
            int unsigned delay = $urandom_range(20, 0);

            repeat (delay) begin
                @(posedge vif.clk);
            end
        endtask
    endclass

`endif