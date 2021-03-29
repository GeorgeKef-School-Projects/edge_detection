module edge_detection_second_step(
    input logic clk,
    input logic rst,

    input logic neighbors_state[8:0], 
    // |0  1  2| 
    // |7  8  3|
    // |6  5  4|

    output logic state
);

//Second Step

//count exactly 2 ones in Von Neuman neighborhood.
logic xor_neuman; 
assign xor_neuman = neighbors_state[1] ^ neighbors_state[3] ^ neighbors_state[5] ^ neighbors_state[7];
logic and_neuman; 
assign and_neuman = neighbors_state[1] & neighbors_state[3] & neighbors_state[5] & neighbors_state[7];
logic or_neuman; 
assign or_neuman = neighbors_state[1] | neighbors_state[3] | neighbors_state[5] | neighbors_state[7];

//check if all other Moore Neighborhood's pixels are zero.
logic moore_eq_zero;
assign moore_eq_zero = ~(neighbors_state[0] | neighbors_state[2] | neighbors_state[4] | neighbors_state[6]);

//if both of the previous conditions are true then the cell is edge.
assign state = (neighbors_state[8] && (~xor_neuman && ~and_neuman && or_neuman && moore_eq_zero)) ? 1 : 0; 

/*
logic [1:0] count_ones;
logic [3:0] count_zeros;

always_ff @(posedge clk) begin 
    if(rst) begin 
        count_ones <= 0;
        count_zeros<= 0;
    end
    //count exactly 2 ones in Von Neuman neighborhood.
    if(neighbors_state[8]) begin 
        for(int i = 1; i < 9;i+=2) begin
            if(neighbors_state[i]) begin 
                count_ones <= count_ones + 1;
            end
        end
        
        //check if all other Moore Neighborhood's pixels are zero.
        if(count_ones == 2) begin
            for(int i = 0; i < 8;i++) begin
                if(neighbors_state[i] == 0) begin 
                    count_zeros <= count_zeros + 1;
                end
            end
        end

        //if both of the previous conditions are true then the cell is edge.
        if(count_zeros == 6) begin 
            state <= 1;
        end else begin 
            state <= 0;
        end 

    end else begin 
        state <= 0;
    end 
end 
*/


endmodule;