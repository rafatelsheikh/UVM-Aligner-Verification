`ifndef CFS_ALGN_REG_CTRL_SV
    `define CFS_ALGN_REG_CTRL_SV

    class cfs_algn_reg_ctrl extends uvm_reg;
        `uvm_object_utils(cfs_algn_reg_ctrl)

        // defining properties
        rand uvm_reg_field SIZE;
        rand uvm_reg_field OFFSET;
        rand uvm_reg_field CLR;
        
        local int unsigned ALGN_DATA_WIDTH;

        // constraints
        constraint legal_size {
            SIZE.value != 0;
        }

        constraint legal_size_offset {
            ((ALGN_DATA_WIDTH / 8) + OFFSET.value) % SIZE.value == 0;
            OFFSET.value + SIZE.value <= (ALGN_DATA_WIDTH / 8);
        }

        // constructor
        function new(string name = "cfs_algn_reg_ctrl");
            super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
        endfunction

        // build function
        virtual function void build();
            SIZE = uvm_reg_field::type_id::create(.name("SIZE"), .parent(null), .contxt(get_full_name()));
            OFFSET = uvm_reg_field::type_id::create(.name("OFFSET"), .parent(null), .contxt(get_full_name()));
            CLR = uvm_reg_field::type_id::create(.name("CLR"), .parent(null), .contxt(get_full_name()));

            SIZE.configure(
                .parent(this),
                .size(3),
                .lsb_pos(0),
                .access("RW"),
                .volatile(0),
                .reset(3'b001),
                .has_reset(1),
                .is_rand(1),
                .individually_accessible(0)
            );

            OFFSET.configure(
                .parent(this),
                .size(2),
                .lsb_pos(8),
                .access("RW"),
                .volatile(0),
                .reset(2'b00),
                .has_reset(1),
                .is_rand(1),
                .individually_accessible(0)
            );

            CLR.configure(
                .parent(this),
                .size(1),
                .lsb_pos(16),
                .access("WO"),
                .volatile(0),
                .reset(1'b0),
                .has_reset(1),
                .is_rand(1),
                .individually_accessible(0)
            );
        endfunction

        // algn data width getter
        virtual function int unsigned GET_ALGN_DATA_WIDTH();
            return ALGN_DATA_WIDTH;
        endfunction

        // algn data width setter
        virtual function void SET_ALGN_DATA_WIDTH(int unsigned ALGN_DATA_WIDTH);
            if (ALGN_DATA_WIDTH < 8) begin
               `uvm_fatal("ALGORITHM_ISSUE", $sformatf("The minimum legal value for ALGN_DATA_WIDTH is 8 but user tried to set it to %0d", ALGN_DATA_WIDTH)) 
            end

            if ($countones(ALGN_DATA_WIDTH) != 1) begin
               `uvm_fatal("ALGORITHM_ISSUE", $sformatf("The value for ALGN_DATA_WIDTH must be a power of 2 but user tried to set it to %0d", ALGN_DATA_WIDTH)) 
            end

            this.ALGN_DATA_WIDTH = ALGN_DATA_WIDTH;
        endfunction        
    endclass

`endif