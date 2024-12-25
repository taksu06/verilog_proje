`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2024 03:28:16
// Design Name: 
// Module Name: uartrx
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
module uartrx (
    input wire clk,             // Sistem saat sinyali
    input wire rst,             // Sistemi s�f�rlama sinyali
    input wire rx,              // UART giri�i (al�m verisi)
    output reg [7:0] data_out,  // Al�nan veri
    output reg data_ready       // Veri al�m� tamamland� sinyali
);

    parameter BAUD_RATE = 9600;
    parameter CLOCK_FREQ = 100_000_000; // 100 MHz saat frekans�
    localparam CLK_DIV = CLOCK_FREQ / BAUD_RATE;

    reg [15:0] clk_counter;      // Saat sayac�
    reg [3:0] bit_index;         // Bit endeksi
    reg [7:0] rx_shift_reg;      // Al�m kayd�rma kay�tlar�
    reg rx_d;                    // �nceki rx sinyali
    reg rx_d1;                   // �nceki rx sinyalinin bir d�ng� gecikmeli hali

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_counter <= 0;
            data_out <= 0;
            data_ready <= 0;
            bit_index <= 0;
            rx_d <= 1;
            rx_d1 <= 1;
        end else begin
            rx_d1 <= rx_d;
            rx_d <= rx;
            if (clk_counter == CLK_DIV - 1) begin
                clk_counter <= 0;
                if (bit_index < 10) begin
                    if (bit_index == 0 && ~rx_d1) begin
                        bit_index <= bit_index + 1; // Start bit
                    end else if (bit_index > 0 && bit_index < 9) begin
                        rx_shift_reg[bit_index - 1] <= rx_d1;
                        bit_index <= bit_index + 1;
                    end else if (bit_index == 9) begin
                        data_out <= rx_shift_reg;
                        data_ready <= 1;
                        bit_index <= 0;
                    end
                end
            end else begin
                clk_counter <= clk_counter + 1;
            end
        end
    end

endmodule
