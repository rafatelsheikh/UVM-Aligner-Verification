`ifndef CFS_ALGN_COVERAGE_SV
    `define CFS_ALGN_COVERAGE_SV

    `uvm_analysis_imp_decl(_in_split_info)

    class cfs_algn_coverage extends uvm_component implements uvm_ext_reset_handler;
        `uvm_component_utils(cfs_algn_coverage)

        // defining ports
        uvm_analysis_imp_in_split_info#(cfs_algn_split_info, cfs_algn_coverage) port_in_split_info;

        // covergroups
        covergroup cover_split with function sample(cfs_algn_split_info info);
            option.per_instance = 1;

            ctrl_offset : coverpoint info.ctrl_offset {
                option.comment = "Value of CTRL.OFFSET";
                
                bins values[] = {[0:3]};
            }

            ctrl_size : coverpoint info.ctrl_size {
                option.comment = "Value of CTRL.SIZE";
                
                bins values[] = {[1:4]};
            }

            md_offset : coverpoint info.md_offset {
                option.comment = "Value of the MD transaction offset";
                
                bins values[] = {[0:3]};
            }

            md_size : coverpoint info.md_size {
                option.comment = "Value of the MD transaction size";
                
                bins values[] = {[1:4]};
            }

            num_bytes_needed : coverpoint info.num_bytes_needed {
                option.comment = "Number of bytes needed during the split";
                
                bins values[] = {[1:3]};
            }

            all : cross ctrl_offset, ctrl_size, md_offset, md_size, num_bytes_needed {
                ignore_bins ignore_ctrl = (binsof(ctrl_offset) intersect {0} && binsof(ctrl_size) intersect {3}) ||
                                            (binsof(ctrl_offset) intersect {1} && binsof(ctrl_size) intersect {2, 3, 4}) ||
                                            (binsof(ctrl_offset) intersect {2} && binsof(ctrl_size) intersect {3, 4}) ||
                                            (binsof(ctrl_offset) intersect {3} && binsof(ctrl_size) intersect {2, 3, 4});
                
                // TODO: other combinations should be ignored from this cross
            }
        endgroup

        // constructor
        function new(string name = "cfs_algn_coverage", uvm_component parent);
            super.new(name, parent);

            port_in_split_info = new("port_in_split_info", this);

            cover_split = new();
            cover_split.set_inst_name($sformatf("%0s_%0s", get_full_name(), "cover_split"));
        endfunction

        // write in split info function
        virtual function void write_in_split_info(cfs_algn_split_info info);
            cover_split.sample(info);
        endfunction

        // handle reset function
        virtual function void handle_reset(uvm_phase phase);
        
        endfunction
    endclass

`endif