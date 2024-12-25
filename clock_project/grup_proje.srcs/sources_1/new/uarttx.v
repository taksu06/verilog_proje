`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2024 03:28:49
// Design Name: 
// Module Name: uarttx
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
module uarttx (
    input wire clk,             // Sistem saat sinyali
    input wire rst,             // Sistemi sýfýrlama sinyali
    input wire [7:0] data_in,   // Gönderilecek veri
    input wire start,           // Veri gönderme baþlatma sinyali
    output reg tx,              // UART çýkýþý (gönderim verisi)
    output reg tx_ready         // Veri gönderilmeye hazýr sinyali
);

    parameter BAUD_RATE = 9600;
    parameter CLOCK_FREQ = 100_000_000; // 100 MHz saat frekansý
    localparam CLK_DIV = CLOCK_FREQ / BAUD_RATE;

    reg [15:0] clk_counter;      // Saat sayacý
    reg [3:0] bit_index;         // Bit endeksi
    reg [7:0] tx_shift_reg;      // Gönderim kaydýrma kayýtlarý
    reg tx_busy;                 // Gönderim iþlemi bitmiþ mi?

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_counter <= 0;
            tx <= 1;             // Idle durumunda TX yüksek olmalý
            tx_ready <= 1;
            tx_shift_reg <= 0;
            bit_index <= 0;
            tx_busy <= 0;
        end else begin
            if (start && tx_ready) begin
                tx_shift_reg <= data_in;
                tx_ready <= 0;
                tx_busy <= 1;
                bit_index <= 0;
                clk_counter <= CLK_DIV / 2; // Bit baþýna yarým saat döngüsü
            end else if (tx_busy) begin
                if (clk_counter == CLK_DIV - 1) begin
                    clk_counter <= 0;
                    if (bit_index < 10) begin
                        tx <= (bit_index == 0) ? 0 : // Start bit
                              (bit_index == 9) ? 1 : // Stop bit
                              tx_shift_reg[bit_index - 1]; // Veri bitleri
                        bit_index <= bit_index + 1;
                    end else begin
                        tx_busy <= 0;
                        tx_ready <= 1;
                    end
                end else begin
                    clk_counter <= clk_counter + 1;
                end
            end else begin
                clk_counter <= 0;
            end
        end
    end

endmodule
