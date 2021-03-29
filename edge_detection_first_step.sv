module edge_detection_first_step(
    input logic clk,
    input logic rst,

    input logic neighbors_state[8:0], 
    // |0  1  2| 
    // |7  8  3|
    // |6  5  4|

    output logic state
);

//First Step
//Find the 3 contiguous neighbors

logic line1,line2; // line1 = 0 1 2, line2 = 4 5 6
logic col1,col2; //col1 = 0 7 6, col2 = 2 3 4 
logic corner1,corner2,corner3,corner4; // corner1 = 7 0 1,corner2 = 1 2 3, corner3 = 3 4 5,corner4 = 5 6 7 

assign line1 = (neighbors_state[0] & neighbors_state[1] & neighbors_state[2]);
assign line2 = (neighbors_state[4] & neighbors_state[5] & neighbors_state[6]);

assign col1 = (neighbors_state[0] & neighbors_state[7] & neighbors_state[6]);
assign col2 = (neighbors_state[2] & neighbors_state[3] & neighbors_state[4]);

assign corner1 = (neighbors_state[7] & neighbors_state[0] & neighbors_state[1]);
assign corner2 = (neighbors_state[1] & neighbors_state[2] & neighbors_state[3]);
assign corner3 = (neighbors_state[3] & neighbors_state[4] & neighbors_state[5]);
assign corner4 = (neighbors_state[5] & neighbors_state[6] & neighbors_state[7]);

logic nor_line1,nor_line2;
logic nor_col1,nor_col2;  
logic nor_corner1,nor_corner2,nor_corner3,nor_corner4;

assign nor_line1 = ~(neighbors_state[0] | neighbors_state[1] | neighbors_state[2]);
assign nor_line2 = ~(neighbors_state[4] | neighbors_state[5] | neighbors_state[6]);

assign nor_col1 = ~(neighbors_state[0] | neighbors_state[7] | neighbors_state[6]);
assign nor_col2 = ~(neighbors_state[2] | neighbors_state[3] | neighbors_state[4]);

assign nor_corner1 = ~(neighbors_state[7] | neighbors_state[0] | neighbors_state[1]);
assign nor_corner2 = ~(neighbors_state[1] | neighbors_state[2] | neighbors_state[3]);
assign nor_corner3 = ~(neighbors_state[3] | neighbors_state[4] | neighbors_state[5]);
assign nor_corner4 = ~(neighbors_state[5] | neighbors_state[6] | neighbors_state[7]);

//If the symetrical contiguous neighbors are 0 then the state stays the same else it is zero. 
assign state = neighbors_state[8] & ((line1 & nor_line2) | (line2 & nor_line1) | (col1 & nor_col2) | (col2 & nor_col1) | (corner1 & nor_corner3) | (corner3 & nor_corner1) | (corner2 & nor_corner4) | (corner4 & nor_corner2));
 
endmodule;