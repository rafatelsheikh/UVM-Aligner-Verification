`ifndef CFS_MD_COVERAGE_SV
    `define CFS_MD_COVERAGE_SV

    class cfs_md_coverage#(int unsigned DATA_WIDTH = 32) extends uvm_ext_coverage#(.VIRTUAL_INTF(virtual cfs_md_if), .ITEM_MON(cfs_md_item_mon));
        `uvm_component_param_utils(cfs_md_coverage#(DATA_WIDTH))

        typedef virtual cfs_md_if#(DATA_WIDTH) cfs_md_vif;

        cfs_md_agent_config#(DATA_WIDTH) agent_config;
        uvm_ext_cover_index_wrapper#(DATA_WIDTH) wrap_cover_data_0;
        uvm_ext_cover_index_wrapper#(DATA_WIDTH) wrap_cover_data_1;

        covergroup cover_item with function sample(cfs_md_item_mon item);
            option.per_instance = 1;

            offset: coverpoint item.offset {
                option.comment = "Offset of the MD access";
                bins values[] = {[0 : (DATA_WIDTH / 8) - 1]};
            }

            size: coverpoint item.data.size() {
                option.comment = "Size of the MD access";
                bins values[] = {[1 : (DATA_WIDTH / 8)]};
            }

            response: coverpoint item.response {
                option.comment = "Response of the MD access";
            }

            length: coverpoint item.length {
                option.comment = "Length of the MD access";

                bins length_eq_1 = {1};
                bins length_le_10[9] = {[2:10]};
                bins length_gt_10 = {[11:$]};

                illegal_bins length_lt_1 = {0};
            }

            prev_item_delay: coverpoint item.prev_item_delay {
                option.comment = "Delay in clock cycles between two consecutive MD accesses";

                bins back2back = {0};
                bins delay_le_5[5] = {[1:5]};
                bins delay_gt_5 = {[6:$]};
            }

            offset_x_size: cross offset, size {
                ignore_bins ignore_offset_plus_size_gt_data_width = offset_x_size with (offset + size > (DATA_WIDTH / 8));
            }
        endgroup

        covergroup cover_reset with function sample(bit valid);
            option.per_instance = 1;

            access_ongoing: coverpoint valid {
                option.comment = "A MD access was ongoing at reset";
            }
        endgroup

        function new(string name = "cfs_md_coverage", uvm_component parent);
            super.new(name, parent);

            cover_item = new();
            cover_item.set_inst_name($sformatf("%s_%s", get_full_name(), "cover_item"));

            cover_reset = new();
            cover_reset.set_inst_name($sformatf("%s_%s", get_full_name(), "cover_reset"));
        endfunction

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            wrap_cover_data_0 = uvm_ext_cover_index_wrapper#(DATA_WIDTH)::type_id::create("wrap_cover_data_0", this);
            wrap_cover_data_1 = uvm_ext_cover_index_wrapper#(DATA_WIDTH)::type_id::create("wrap_cover_data_1", this);
        endfunction

        virtual function void end_of_elaboration_phase(uvm_phase phase);
            super.end_of_elaboration_phase(phase);

            if ($cast(agent_config, super.agent_config) == 0) begin
                `uvm_fatal("ALGORITHM_ISSUE", $sformatf("Could not cast %0s to %0s", super.agent_config.get_type_name(), cfs_md_agent_config#(DATA_WIDTH)::type_id::type_name))
            end
        endfunction

        virtual function void write_item(cfs_md_item_mon item);
            cover_item.sample(item);

            foreach (item.data[byte_idx]) begin
                for (int bit_idx = 0; bit_idx < 8; bit_idx++) begin
                    if (item.data[byte_idx][bit_idx]) begin
                        wrap_cover_data_1.sample((item.offset * 8) + (byte_idx * 8) + bit_idx);
                    end else begin
                        wrap_cover_data_0.sample((item.offset * 8) + (byte_idx * 8) + bit_idx);
                    end
                end
            end
        endfunction

        virtual function void handle_reset(uvm_phase phase);
            cfs_md_vif vif = agent_config.get_vif();

            cover_reset.sample(vif.valid);
        endfunction
    endclass

`endif