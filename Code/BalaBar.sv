module BalaBar (
    input clk,                                  // Clock
    input rst,                                // signal for reset
    input [1:0] state,                          // state of BalaBar
    output reg [4:0] floor_cur,             // Current floor
    output reg [1:0] floor_state [4:0]      //  floor states 
);

    // local variable
    integer i;
    localparam STOP = 2'b00;
    localparam UP_going = 2'b11;
    localparam DOWN_going = 2'b10;

    // initial
    initial begin
        floor_cur = {5{1'b0}};
        for( i = 0; i < 5; i=i+1)
            floor_state[i] = 2'b00;
    end

    // update states
    always @(posedge clk or posedge rst) begin
        for( i = 0; i < 5; i=i+1)
            floor_state[i] = 2'b00;

        if (rst) begin
            floor_cur = {5{1'b0}};
        end else begin
            case (state)
                STOP: begin
                    floor_state[floor_cur] = 2'b11;
                    #100;
                end

                DOWN_going: begin
                    if (floor_cur > 0) begin
                        floor_state[floor_cur] = 2'b01;
                        floor_cur = floor_cur - 1;
                        floor_state[floor_cur] = 2'b10;
                    end
                    #10;
                end

                UP_going: begin
                    if (floor_cur < 5) begin
                        floor_state[floor_cur] = 2'b01;
                        floor_cur = floor_cur + 1;
                        floor_state[floor_cur] = 2'b10;
                    end
                    #10;
                end

            endcase
        end
    end
endmodule
