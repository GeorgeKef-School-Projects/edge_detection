module edge_detection_tb; 

    // |0  1  2| 
    // |7  8  3|
    // |6  5  4|

    logic clk; 
    logic rst; 
    logic pixels[8:0];
    logic pixels_after_step_1;
    logic pixels_after_step_2;

    always begin
        clk = 1; 
        #1ns;
        clk = ~clk; 
        #1ns;
    end

    edge_detection_first_step first_step(
        .clk                (clk), 
        .rst                (rst),
        .neighbors_state    (pixels),
        .state              (pixels_after_step_1)
    );
    edge_detection_second_step second_step(
        .clk                (clk), 
        .rst                (rst),
        .neighbors_state    (pixels),
        .state              (pixels_after_step_2)
    );

    initial begin
        $display("Starting Test Bench");
    //First_test
        pixels[0]<=1;
        pixels[1]<=1;
        pixels[2]<=1;
        pixels[3]<=0;
        pixels[4]<=0;
        pixels[5]<=0;
        pixels[6]<=0;
        pixels[7]<=0;
        pixels[8]<=1;
        @(posedge clk); 
        $display("Pixel : %b\n",pixels_after_step_1);
        @(posedge clk);
    //Second_test
        pixels[0]<=1;
        pixels[1]<=1;
        pixels[2]<=1;
        pixels[3]<=0;
        pixels[4]<=1;
        pixels[5]<=0;
        pixels[6]<=0;
        pixels[7]<=0;
        pixels[8]<=1; 
        @(posedge clk);
        $display("Pixel : %b\n",pixels_after_step_1); 
        @(posedge clk);
    //Third_test
        pixels[0]<=0;
        pixels[1]<=1;
        pixels[2]<=0;
        pixels[3]<=1;
        pixels[4]<=0;
        pixels[5]<=0;
        pixels[6]<=0;
        pixels[7]<=0;
        pixels[8]<=1;
        @(posedge clk);
        $display("Pixel : %b\n",pixels_after_step_2);
        @(posedge clk); 
    //Fourth_test
        pixels[0]<=1;
        pixels[1]<=1;
        pixels[2]<=0;
        pixels[3]<=1;
        pixels[4]<=0;
        pixels[5]<=0;
        pixels[6]<=0;
        pixels[7]<=0;
        pixels[8]<=1; 
        @(posedge clk);
        $display("Pixel : %b\n",pixels_after_step_2);
        @(posedge clk); 
    //Fifth_test
        pixels[0]<=1;
        pixels[1]<=1;
        pixels[2]<=1;
        pixels[3]<=0;
        pixels[4]<=0;
        pixels[5]<=0;
        pixels[6]<=0;
        pixels[7]<=0;
        pixels[8]<=0; 
        @(posedge clk);
        $display("Pixel : %b\n",pixels_after_step_1);
        @(posedge clk);
    //Sixth_test
        pixels[0]<=0;
        pixels[1]<=1;
        pixels[2]<=0;
        pixels[3]<=1;
        pixels[4]<=0;
        pixels[5]<=0;
        pixels[6]<=0;
        pixels[7]<=0;
        pixels[8]<=0; 
        @(posedge clk);
        $display("Pixel : %b\n",pixels_after_step_2);
        @(posedge clk);

        $display("Finishing test");

    end




endmodule