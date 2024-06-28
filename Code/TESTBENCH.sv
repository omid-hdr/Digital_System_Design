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
        clk = 0;
        rst = 1;
        buttons_in = 0;
        buttons_ex = 0;
        
        #10 rst = 0;                      // t = 10
        buttons_ex[0] = 1'b1;
        #11 buttons_ex[0] = 1'b0;     // t = 20
        #10 buttons_in[2] = 1'b1;     // t = 30     
        #10 buttons_in[2] = 1'b0;     // t = 40
        #100
        buttons_ex[1] = 1'b1;         // t = 140
        #10 buttons_ex[1] = 1'b0;     // t = 150
        #10 buttons_ex[3] = 1'b1;     // t = 160
        #10 buttons_ex[3] = 1'b0;     // t = 170
        #10 buttons_ex[0] = 1'b1;     // t = 180
        #10 buttons_ex[0] = 1'b0;     // t = 190

        #60 buttons_in[2] = 1'b1;     // t = 250
        #10 buttons_in[2] = 1'b0;     // t = 260

        #210 buttons_in[0] = 1'b1;    // t = 470
        #10 buttons_in[0] = 1'b0;     // t = 480

        #130 buttons_in[4] = 1'b1;    // t = 610
        #10 buttons_in[4] = 1'b0;     // t = 620
        
        #20 buttons_ex[1] = 1'b1;     // t = 640
        #10 buttons_ex[1] = 1'b0;     // t = 650
        #1000;
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


