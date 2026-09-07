`ifndef CFS_ALGN_VIRTUAL_SEQUENCE_REG_ACCESS_RANDOM_SV
    `define CFS_ALGN_VIRTUAL_SEQUENCE_REG_ACCESS_RANDOM_SV

    class cfs_algn_virtual_sequence_reg_access_random extends cfs_algn_virtual_sequence_base;
        `uvm_object_utils(cfs_algn_virtual_sequence_reg_access_random)

        // defining number of accesses
        rand int unsigned num_accesses;

        // constraints
        constraint num_access_default {
            soft num_accesses inside {[150:200]};
        }

        // constructor
        function new(string name = "cfs_algn_virtual_sequence_reg_access_random");
            super.new(name);
        endfunction

        // body task
        virtual task body();
            uvm_reg registers[$];
            uvm_status_e status;
            uvm_reg_data_t data;

            p_sequencer.model.reg_block.get_registers(registers);

            for (int unsigned access_idx = 0; access_idx < num_accesses; access_idx++) begin
                int unsigned reg_idx = $urandom_range(registers.size() - 1, 0);
                uvm_access_e access = get_random_access(registers[reg_idx], access_idx);

                case (access)
                    UVM_READ: begin
                        registers[reg_idx].read(status, data);
                    end

                    UVM_WRITE: begin
                        void'(registers[reg_idx].randomize());

                        registers[reg_idx].update(status);
                    end

                    default: begin
                        `uvm_fatal("ALGORITHM_ISSUE", $sformatf("Un-supported value for access: %0s", access.name()))
                    end
                endcase

                wait_random_time();
            end
        endtask

        // get random access function
        protected virtual function uvm_access_e get_random_access(uvm_reg register, int unsigned access_idx);
            uvm_access_e result;

            void'(std::randomize(result) with {
                result inside {UVM_READ, UVM_WRITE};
            });

            return result;
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