`ifndef CFS_ALGN_TEST_BASE_SV
    `define CFS_ALGN_TEST_BASE_SV
    
    class cfs_algn_test_base extends uvm_test;
        `uvm_component_utils(cfs_algn_test_base)

        cfs_algn_env#(`CFS_ALGN_TEST_ALGN_DATA_WIDTH) env;

        function new(string name = "cfs_algn_test_base", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            env = cfs_algn_env#(`CFS_ALGN_TEST_ALGN_DATA_WIDTH)::type_id::create("env", this);
        endfunction
    endclass
`endif