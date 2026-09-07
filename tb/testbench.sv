`include "cfs_apb_if.sv"
`include "cfs_md_if.sv"

module testbench();
    localparam ALGN_DATA_WIDTH = 32;

    import uvm_pkg::*;
    import cfs_env_pkg::*;

    reg clk;

    // clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // interfaces
    cfs_apb_if apb_if(.pclk(clk));
    cfs_md_if#(ALGN_DATA_WIDTH) md_rx_if(.clk(clk));
    cfs_md_if#(ALGN_DATA_WIDTH) md_tx_if(.clk(clk));
    cfs_algn_if algn_if(.clk(clk));

    // reset at the start of the simulation
    initial begin
        apb_if.preset_n = 1;

        #(3ns);

        apb_if.preset_n = 0;
        
        #(30ns);

        apb_if.preset_n = 1;
    end

    // sync the resets
    assign md_rx_if.reset_n = apb_if.preset_n;
    assign md_tx_if.reset_n = apb_if.preset_n;
    assign algn_if.reset_n = apb_if.preset_n;

    // put the configuration objects in the database
    initial begin
        uvm_config_db#(virtual cfs_apb_if)::set(null, "uvm_test_top.env.apb_agent", "vif", apb_if);
        uvm_config_db#(virtual cfs_md_if#(ALGN_DATA_WIDTH))::set(null, "uvm_test_top.env.md_rx_agent", "vif", md_rx_if);
        uvm_config_db#(virtual cfs_md_if#(ALGN_DATA_WIDTH))::set(null, "uvm_test_top.env.md_tx_agent", "vif", md_tx_if);
        uvm_config_db#(virtual cfs_algn_if)::set(null, "uvm_test_top.env", "vif", algn_if);

        run_test("");
    end

    // dut instantiation
    cfs_aligner dut(
        .clk(clk),
        .reset_n(apb_if.preset_n),
        .paddr(apb_if.paddr),
        .pwrite(apb_if.pwrite),
        .psel(apb_if.psel),
        .penable(apb_if.penable),
        .pwdata(apb_if.pwdata),
        .pready(apb_if.pready),
        .prdata(apb_if.prdata),
        .pslverr(apb_if.pslverr),

        .md_rx_valid(md_rx_if.valid),
        .md_rx_data(md_rx_if.data),
        .md_rx_offset(md_rx_if.offset),
        .md_rx_size(md_rx_if.size),
        .md_rx_ready(md_rx_if.ready),
        .md_rx_err(md_rx_if.err),

        .md_tx_valid(md_tx_if.valid),
        .md_tx_data(md_tx_if.data),
        .md_tx_offset(md_tx_if.offset),
        .md_tx_size(md_tx_if.size),
        .md_tx_ready(md_tx_if.ready),
        .md_tx_err(md_tx_if.err),

        .irq(algn_if.irq)
    );

    // sync the push and pop signals
    assign algn_if.rx_fifo_push = dut.core.rx_fifo.push_valid & dut.core.rx_fifo.push_ready;
    assign algn_if.rx_fifo_pop = dut.core.rx_fifo.pop_valid & dut.core.rx_fifo.pop_ready;
    assign algn_if.tx_fifo_push = dut.core.tx_fifo.push_valid & dut.core.tx_fifo.push_ready;
    assign algn_if.tx_fifo_pop = dut.core.tx_fifo.pop_valid & dut.core.tx_fifo.pop_ready;
endmodule