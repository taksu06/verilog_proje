`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2024 07:54:51
// Design Name: 
// Module Name: debounce
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debounce (
    input wire clk,
    input wire button,
    output reg debounced_button
);
    reg [19:0] counter;  // Sayaç boyutu küçültüldü
    reg button_sync_0, button_sync_1;


    always @(posedge clk) begin
        button_sync_0 <= button;
        button_sync_1 <= button_sync_0;

        if (button_sync_1 == 1'b1 && counter < 20'd999999) begin  // 1 ms debounce süresi (20 bit)
            counter <= counter + 1'b1;
        end else if (button_sync_1 == 1'b0) begin
            counter <= 20'd0;
        end

        if (counter == 20'd999999) begin
            debounced_button <= 1'b1;
        end else begin
            debounced_button <= 1'b0;
        end
    end
endmodule
