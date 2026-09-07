`ifndef CFS_MD_IF_SV
    `define CFS_MD_IF_SV

    interface cfs_md_if#(int unsigned DATA_WIDTH = 32) (input clk);
        localparam OFFSET_WIDTH = ($clog2(DATA_WIDTH/8) < 1)? 1 : $clog2(DATA_WIDTH/8);
        localparam SIZE_WIDTH = $clog2(DATA_WIDTH/8) + 1;

        logic reset_n;
        logic valid;
        logic [DATA_WIDTH-1:0] data;
        logic [OFFSET_WIDTH-1:0] offset;
        logic [SIZE_WIDTH-1:0] size;
        logic ready;
        logic err;

        bit has_checks;

        initial begin
            has_checks = 1;
        end

        // check if the data width is a power of 2 before the simulation starts
        if($log10(DATA_WIDTH)/$log10(2) - $clog2(DATA_WIDTH) != 0) begin
            $error("DATA_WIDTH is not a power of two - value in binary: 'b%0b, in hex is 'h%0h, in dec is %0d", DATA_WIDTH, DATA_WIDTH, DATA_WIDTH);
        end
    
        // check if the data width isn't less than the minimum value of 8 
        if(DATA_WIDTH < 8) begin
            $error("DATA_WIDTH must be bigger than 8 but detected value %0d", DATA_WIDTH);
        end
    
        // once valid is high it must remain high until ready is high
        property valid_high_until_ready_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            $fell(valid) |-> ($past(ready) == 1);
        endproperty

        VALID_HIGH_UNTIL_READY_A: assert property (valid_high_until_ready_p)
            else $error("Valid didn't remain high until ready is high");

        // data is not unknown when valid is high
        property unknown_value_data_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            (valid == 1) |-> ($isunknown(data) == 0);
        endproperty

        UNKOWN_VALUE_DATA_A: assert property (unknown_value_data_p)
            else $error("Data is unkown when valid is high");
        
        // data must remain constant until ready is high
        property stable_data_until_ready_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            ((valid == 1) && ($past(valid) == 1) && ($past(ready) == 0)) |-> $stable(data);
        endproperty

        STABLE_DATA_UNTIL_READY_A: assert property (stable_data_until_ready_p)
            else $error("Data didn't remain stable until ready is high");

        // offset is not unknown when valid is high
        property unknown_value_offset_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            (valid == 1) |-> ($isunknown(offset) == 0);
        endproperty

        UNKOWN_VALUE_OFFSET_A: assert property (unknown_value_offset_p)
            else $error("Offset is unkown when valid is high");
        
        // offset must remain constant until ready is high
        property stable_offset_until_ready_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            ((valid == 1) && ($past(valid) == 1) && ($past(ready) == 0)) |-> $stable(offset);
        endproperty

        STABLE_OFFSET_UNTIL_READY_A: assert property (stable_offset_until_ready_p)
            else $error("Offset didn't remain stable until ready is high");

        // size is not unknown when valid is high
        property unknown_value_size_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            (valid == 1) |-> ($isunknown(size) == 0);
        endproperty

        UNKOWN_VALUE_SIZE_A: assert property (unknown_value_size_p)
            else $error("Size is unkown when valid is high");
        
        // size must remain constant until ready is high
        property stable_size_until_ready_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            ((valid == 1) && ($past(valid) == 1) && ($past(ready) == 0)) |-> $stable(size);
        endproperty

        STABLE_SIZE_UNTIL_READY_A: assert property (stable_size_until_ready_p)
            else $error("Size didn't remain stable until ready is high");

        // size can not be zero when valid is high
        property size_eq_0_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            (valid == 1) |-> (size != 0);
        endproperty

        SIZE_EQ_0_A: assert property (size_eq_0_p)
            else $error("Size equals zero");
        
        // err is valid when both valid and ready are high
        property unknown_value_err_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            ((valid == 1) && (ready == 1)) |-> ($isunknown(err) == 0);
        endproperty

        UNKNOWN_VALUE_ERR_A: assert property (unknown_value_err_p)
            else $error("Err us unknown when valid and ready are high");
        
        // err can only be high if both valid and ready are high
        property err_high_at_valid_and_ready_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            (err == 1) |-> ((valid == 1) && (ready == 1));
        endproperty

        ERR_HIGH_AT_VALID_AND_READY_A: assert property (err_high_at_valid_and_ready_p)
            else $error("Err is high but not both valid and ready are high");
        
        // valid can not be unknown
        property unknown_value_valid_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            ($isunknown(valid) == 0);
        endproperty

        UNKNOWN_VALUE_VALID_A: assert property (unknown_value_valid_p)
            else $error("Valid is unknown");
        
        // ready is not unknown when valid is high
        property unknown_value_ready_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            (valid == 1) |-> ($isunknown(ready) == 0);
        endproperty

        UNKNOWN_VALUE_READY_A: assert property (unknown_value_ready_p)
            else $error("Ready is unknown when valid is high");
        
        // offset + size can not be bigger than data width in bytes
        property size_plus_offset_gt_data_width_p;
            @(posedge clk) disable iff(!reset_n || !has_checks)
            (valid == 1) |-> ((offset + size) <= (DATA_WIDTH / 8));
        endproperty

        SIZE_PLUS_OFFSET_GT_DATA_WIDTH_A: assert property (size_plus_offset_gt_data_width_p)
            else $error("Offset + size is greater than data width in bytes");
    endinterface

`endif