module TESTBENCH;

    // variable
    reg clk;
    reg rst;
    reg [4:0] buttons_in;
    reg [4:0] buttons_ex;
    wire motor;
    wire direction;
    wire [4:0] floor_cur;
    wire [1:0] floor_state [0:4];

    // instance
    BalaBar balaBar (
        .clk(clk),
        .rst(rst),
        .state({motor, direction}),
        .floor_state(floor_state),
        .floor_cur(floor_cur)
    );

    BalaBArController controller (
        .clk(clk),
        .rst(rst),
        .floor_cur(floor_cur),
        .buttons_in(buttons_in),
        .buttons_ex(buttons_ex),
        .direction(direction),
        .motor(motor)
    );

    always #5 clk = ~clk; // clock

    initial begin
        buttons_in = 0;
        buttons_ex = 0;
        clk = 0;
        rst = 1;

        
        #10 rst = 0; 

        #10 buttons_in[4] = 1'b1;         
        #10 buttons_in[4] = 1'b0;    
        #100
       
   
        #10 buttons_ex[0] = 1'b1;     
        #10 buttons_ex[0] = 1'b0;   


        #10 buttons_ex[1] = 1'b1;     
        #10 buttons_ex[1] = 1'b0;     

        #60 buttons_in[3] = 1'b1;     
        #10 buttons_in[3] = 1'b0;     

        #310 buttons_in[2] = 1'b1;    
        #10 buttons_in[2] = 1'b0;     

        #130 buttons_in[3] = 1'b1;    
        #10 buttons_in[3] = 1'b0;     
        
        #20 buttons_ex[1] = 1'b1;     
        #10 buttons_ex[1] = 1'b0;     

        #20 buttons_ex[4] = 1'b1;     
        #10 buttons_ex[4] = 1'b0;   

        #700;
        $stop();
    end


    initial begin
    $dumpfile("BalaBar.vcd");
    $dumpvars;
    end

    reg [1:0] pre [4:0];
    
    always @(posedge clk) begin
        if (floor_state !== pre) begin
            $display("at %4d moment", $time, " Floor state have change:\n this moment is :  %p", floor_state);
        end
        pre <= floor_state;
    end

endmodule


