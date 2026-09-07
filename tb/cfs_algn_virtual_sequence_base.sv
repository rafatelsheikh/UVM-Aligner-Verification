`ifndef CFS_ALGN_VIRTUAL_SEQUENCE_BASE_SV
    `define CFS_ALGN_VIRTUAL_SEQUENCE_BASE_SV

    class cfs_algn_virtual_sequence_base extends uvm_sequence;
        `uvm_object_utils(cfs_algn_virtual_sequence_base)

        `uvm_declare_p_sequencer(cfs_algn_virtual_sequencer)

        function new(string name = "cfs_algn_virtual_sequence_base");
            super.new(name);
        endfunction
    endclass

`endif