module BalaBArController (
    input clk,                          // Clock 
    input rst,                        // signal for reset
    input [4:0] buttons_ex,       // request from out
    input [4:0] buttons_in,       // request from in
    input [4:0] floor_cur,          // Current floor
    output reg direction,               // Move Direction signal : 1 ->  up, 0 -> down
    output reg motor                    // Motor movement : 1 -> motor, 0 -> stop 
);

    // local variable
    reg [4:0] requests;
    integer i;
    integer target;
    bit [2:0] queue [$:4]; 
    bit new_target;
    localparam STOP = 2'b00;
    localparam UP_going = 2'b11;
    localparam DOWN_going = 2'b10;

    // initial
    initial begin
        {motor, direction} = STOP;
        requests = {5{1'b0}};
    end

    function automatic void clear();
        int val;
        while (queue.size() != 0)
            val = queue.pop_front();
    endfunction

    // always to the reg map for requests
    always @(negedge clk or posedge rst) begin
        if (rst) begin
            new_target <= 1'b1;
            requests <= {5{1'b0}};
        end 
        else
            requests <= buttons_in | requests | buttons_ex;
    end

    // updating destination
    always @(posedge rst) begin
        if (rst)
            target = floor_cur;
    end


    // always for the control logic
    always @(negedge clk or posedge rst) begin
        if (rst)
            {motor, direction} <= STOP;
        else begin
            case ({motor, direction})
                STOP: begin
                    if (requests != {5{1'b0}}) begin
                        if (queue.size() > 0 && new_target)begin
                            target = queue.pop_front();
                            new_target = 0;
                        end
                        if (target > floor_cur)
                            {motor, direction} <= UP_going;
                        else if (target < floor_cur)
                            {motor, direction} <= DOWN_going;
                    end
                    if (target == floor_cur) begin
                            requests[floor_cur] <= 1'b0;
                            new_target = 1;
                        end
                end

                DOWN_going: begin
                    if (0 == floor_cur) begin
                        {motor, direction} <= STOP;
                    end
                    else begin
                        if (requests[floor_cur] == 1'b1) begin
                            {motor, direction} <= STOP;
                            requests[floor_cur] <= 1'b0;
                        end
                        if (target == floor_cur) begin
                            new_target = 1;
                            {motor, direction} = STOP;
                        end
                    end
                end

                UP_going: begin
                    if (5 == floor_cur) begin
                        {motor, direction} <= STOP;
                    end
                    else begin
                        if (requests[floor_cur] == 1'b1) begin
                            {motor, direction} <= STOP;
                            requests[floor_cur] <= 1'b0;
                        end
                        if (target == floor_cur) begin
                            new_target = 1;
                            {motor, direction} = STOP;
                        end
                    end 
                end
            endcase
        end
    end


    // always for the request queue
    always @(negedge clk or posedge rst) begin
        if (rst) 
            clear();

        else begin
            for (i = 0; i < 5 ; i= i+1) begin
                if (buttons_in[i] | buttons_ex[i] == 1'b1) begin
                    case ({motor, direction})
                        STOP: begin
                            if (target > floor_cur) begin
                                if (i < floor_cur)
                                    queue.push_back(i);
                                else if (i > target)
                                    queue.push_back(i);
                            end
                            else if (target < floor_cur) begin
                                if (i > floor_cur)
                                    queue.push_back(i);
                                else if (i < target)
                                    queue.push_back(i);
                            end
                            else
                                queue.push_back(i);
                        end

                        DOWN_going: begin
                            if(i < target || i > floor_cur)
                                queue.push_back(i);
                        end

                        UP_going: begin
                            if(i > target || floor_cur > i)
                                queue.push_back(i);
                        end

                    endcase
                end
            end
        end
    end

endmodule
