`ifndef CFS_ENV_PKG_SV
    `define CFS_ENV_PKG_SV

    // inculde the interfaces
    `include "cfs_apb_if.sv"
    `include "cfs_md_if.sv"
    `include "cfs_algn_if.sv"

    package cfs_env_pkg;
        // bring in uvm
        import uvm_pkg::*;
        `include "uvm_macros.svh"

        // uvm extension classes
        `include "uvm_ext_reset_handler.sv"
        `include "uvm_ext_sequencer.sv"
        `include "uvm_ext_agent_config.sv"
        `include "uvm_ext_driver.sv"
        `include "uvm_ext_monitor.sv"
        `include "uvm_ext_coverage.sv"
        `include "uvm_ext_agent.sv"

        // include APB classes
        `include "cfs_apb_types.sv"
        `include "cfs_apb_item_base.sv"
        `include "cfs_apb_item_drv.sv"
        `include "cfs_apb_item_mon.sv"
        `include "cfs_apb_agent_config.sv"
        `include "cfs_apb_driver.sv"
        `include "cfs_apb_monitor.sv"
        `include "cfs_apb_coverage.sv"
        `include "cfs_apb_sequence_base.sv"
        `include "cfs_apb_sequence_simple.sv"
        `include "cfs_apb_sequence_rw.sv"
        `include "cfs_apb_sequence_random.sv"
        `include "cfs_apb_agent.sv"
        `include "cfs_apb_reg_adapter.sv"

        // include MD classes
        `include "cfs_md_types.sv"
        `include "cfs_md_item_base.sv"
        `include "cfs_md_item_drv.sv"
        `include "cfs_md_item_drv_master.sv"
        `include "cfs_md_item_drv_slave.sv"
        `include "cfs_md_item_mon.sv"
        `include "cfs_md_sequencer_base.sv"
        `include "cfs_md_sequencer_base_master.sv"
        `include "cfs_md_sequencer_base_slave.sv"
        `include "cfs_md_sequencer_master.sv"
        `include "cfs_md_sequencer_slave.sv"
        `include "cfs_md_agent_config.sv"
        `include "cfs_md_agent_config_master.sv"
        `include "cfs_md_agent_config_slave.sv"
        `include "cfs_md_driver.sv"
        `include "cfs_md_driver_master.sv"
        `include "cfs_md_driver_slave.sv"
        `include "cfs_md_monitor.sv"
        `include "cfs_md_coverage.sv"
        `include "cfs_md_sequence_base.sv"
        `include "cfs_md_sequence_base_master.sv"
        `include "cfs_md_sequence_base_slave.sv"
        `include "cfs_md_sequence_simple_master.sv"
        `include "cfs_md_sequence_simple_slave.sv"
        `include "cfs_md_sequence_slave_response.sv"
        `include "cfs_md_sequence_slave_response_forever.sv"
        `include "cfs_md_agent.sv"
        `include "cfs_md_agent_master.sv"
        `include "cfs_md_agent_slave.sv"

        // include reg classes
        `include "cfs_algn_types.sv"
        `include "cfs_algn_reg_ctrl.sv"
        `include "cfs_algn_reg_status.sv"
        `include "cfs_algn_reg_irqen.sv"
        `include "cfs_algn_reg_irq.sv"
        `include "cfs_algn_reg_block.sv"
        `include "cfs_algn_env_config.sv"
        `include "cfs_algn_split_info.sv"
        `include "cfs_algn_clr_cnt_drop.sv"
        `include "cfs_algn_reg_access_status_info.sv"
        `include "cfs_algn_reg_predictor.sv"
        `include "cfs_algn_seq_reg_config.sv"

        // include aligner classes
        `include "cfs_algn_test_defines.sv"
        `include "cfs_algn_model.sv"
        `include "cfs_algn_scoreboard.sv"
        `include "cfs_algn_coverage.sv"
        `include "cfs_algn_virtual_sequencer.sv"
        `include "cfs_algn_virtual_sequence_base.sv"
        `include "cfs_algn_virtual_sequence_slow_pace.sv"
        `include "cfs_algn_virtual_sequence_reg_access_random.sv"
        `include "cfs_algn_virtual_sequence_reg_access_unmapped.sv"
        `include "cfs_algn_virtual_sequence_reg_config.sv"
        `include "cfs_algn_virtual_sequence_reg_status.sv"
        `include "cfs_algn_virtual_sequence_rx.sv"
        `include "cfs_algn_virtual_sequence_rx_err.sv"
        `include "cfs_algn_env.sv"

        // include test classes
        `include "cfs_algn_test_base.sv"
        `include "cfs_algn_test_reg_access.sv"
        `include "cfs_algn_test_random.sv"
        `include "cfs_algn_test_random_rx_err.sv"
    endpackage
`endif