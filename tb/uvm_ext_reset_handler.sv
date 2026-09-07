`ifndef UVM_EXT_RESET_HANDLER_SV
    `define UVM_EXT_RESET_HANDLER_SV

    interface class uvm_ext_reset_handler;
        pure virtual function void handle_reset(uvm_phase phase);
    endclass

`endif