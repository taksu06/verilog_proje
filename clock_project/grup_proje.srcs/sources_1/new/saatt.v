`timescale 1ns / 1ps

module saatt(
    input clk,         // Saat sinyali
    input rst,        // Reset
    input clk_fast,      // Saat saymayı etkinleştir
    input stop1,      // Zaman ayarlamayı etkinleştir
    input hourUp1,        // Birinci buton
    input hourDown1,        // İkinci buton
    input minUp1,        // Üçüncü buton
    input minDown1,        // Dördüncü buton
    input [6:0] sw, // Saniyeleri ayarlamak için switch
   
   input   wire        rx, // UART Recieve pin.
   output  wire        tx, // UART transmit pin.
   input sw13,
   
   output reg [3:0] en_out,
   output reg [6:0] ss_out,
   output reg [15:0]led
);



    wire stop;
    debounce db1(
        .clk(clk),
        .button(stop1),
        .debounced_button(stop)
    );
    wire hourUp;
    debounce db2(
        .clk(clk),
        .button(hourUp1),
        .debounced_button(hourUp)
    );
    wire hourDown;
    debounce db3(
        .clk(clk),
        .button(hourDown1),
        .debounced_button(hourDown)
    );
    wire minUp;
    debounce db4(
        .clk(clk),
        .button(minUp1),
        .debounced_button(minUp)
    );
    wire minDown;
    debounce db5(
        .clk(clk),
        .button(minDown1),
        .debounced_button(minDown)
    );
    

    reg [3:0] sec0;  // Saniyenin birler hanesi
    reg [3:0] sec1;  // Saniyenin onlar hanesi
    reg [3:0] min0;  // Dakikanın birler hanesi
    reg [3:0] min1;  // Dakikanın onlar hanesi
    reg [3:0] hour0; // Saatin birler hanesi
    reg [3:0] hour1; // Saatin onlar hanesi
    reg [3:0] day0; // Günün birler hanesi
    reg [3:0] day1;  // Günün onlar hanesi
    reg [3:0] month0;// Ayın birler hanesi
    reg [3:0] month1;// Ayın onlar hanesi
    reg [3:0] year0; // Yılın binler hanesi
    reg [3:0] year1; // Yılın yüzler hanesi
    reg [3:0] year2; // Yılın onlar hanesi
    reg [3:0] year3; // Yılın birler hanesi

    reg [22:0]clk2;
    reg [22:0]clk3;
    integer count;
        initial count =0;
    integer count2;
        initial count2 =0;
    initial clk2=0;
    integer count3;
        initial count3 =0;
    initial clk3=0;

//saati hızlandırma veya normal saniyeye döndürme
always @(posedge clk)begin
    if(clk_fast)begin
        count2=count2+10;
            if(count2 >= 5000)begin
                clk2=~clk2;
                count2 = 1;
            end
    end else begin
        count2=count2+1;
            if(count2 >= 50000000)begin
                clk2=~clk2;
                count2 = 1;
            end
         end    
    end   
 
 always @(posedge clk)begin
    count3=count3+1;
        if(count3 == 50000)begin
            clk3=~clk3;
            count3 = 1;
        end
 end 


    
    always @(posedge clk3)begin
     if(count==0)begin
            case(hour1)
                4'h0: ss_out = 7'b1000000; // 0
                4'h1: ss_out = 7'b1111001; // 1
                4'h2: ss_out = 7'b0100100; // 2
                4'h3: ss_out = 7'b0110000; // 3
                4'h4: ss_out = 7'b0011001; // 4
                4'h5: ss_out = 7'b0010010; // 5
                4'h6: ss_out = 7'b0000010; // 6
                4'h7: ss_out = 7'b1111000; // 7
                4'h8: ss_out = 7'b0000000; // 8
                4'h9: ss_out= 7'b0010000; // 9
            endcase
            en_out = 4'b0111;
            count = 1;
        end
        else if (count ==1) begin
            case(hour0)
                4'h0: ss_out = 7'b1000000; // 0
                4'h1: ss_out = 7'b1111001; // 1
                4'h2: ss_out = 7'b0100100; // 2
                4'h3: ss_out = 7'b0110000; // 3
                4'h4: ss_out = 7'b0011001; // 4
                4'h5: ss_out = 7'b0010010; // 5
                4'h6: ss_out = 7'b0000010; // 6
                4'h7: ss_out = 7'b1111000; // 7
                4'h8: ss_out = 7'b0000000; // 8
                4'h9: ss_out= 7'b0010000; // 9
            endcase
            en_out = 4'b1011;
            count = 2;
            end
             else if (count ==2) begin
            case(min1)
                4'h0: ss_out = 7'b1000000; // 0
                4'h1: ss_out = 7'b1111001; // 1
                4'h2: ss_out = 7'b0100100; // 2
                4'h3: ss_out = 7'b0110000; // 3
                4'h4: ss_out = 7'b0011001; // 4
                4'h5: ss_out = 7'b0010010; // 5
                4'h6: ss_out = 7'b0000010; // 6
                4'h7: ss_out = 7'b1111000; // 7
                4'h8: ss_out = 7'b0000000; // 8
                4'h9: ss_out= 7'b0010000; // 9
            endcase
            en_out = 4'b1101;
            count = 3;
            end
             else if (count ==3) begin
            case(min0)
                4'h0: ss_out = 7'b1000000; // 0
                4'h1: ss_out = 7'b1111001; // 1
                4'h2: ss_out = 7'b0100100; // 2
                4'h3: ss_out = 7'b0110000; // 3
                4'h4: ss_out = 7'b0011001; // 4
                4'h5: ss_out = 7'b0010010; // 5
                4'h6: ss_out = 7'b0000010; // 6
                4'h7: ss_out = 7'b1111000; // 7
                4'h8: ss_out = 7'b0000000; // 8
                4'h9: ss_out= 7'b0010000; // 9
            endcase
            en_out = 4'b1110;
            count = 0;
            end
    end
    
    
    
    //saat sayımını durdurma
reg counter=1;
reg stopped=0;
always @(posedge clk3 or posedge stop) begin
    if(stop)begin
        if(!stopped)begin
            counter=0;
            stopped=1;
        end else begin
            counter=1;
            stopped=0;
        end 
    end
end



    // Başlangıç tarihi ve saati
    initial begin
        sec0 <= 0;
        sec1 <= 0;
        min0 <= 9;
        min1 <= 5;
        hour0 <= 3;
        hour1 <= 2;
        day0 <= 0;
        day1 <= 3;
        month0 <= 2;
        month1 <= 1;
        year0 <= 4;
        year1 <= 2;
        year2 <= 0;
        year3 <= 2;
    end



 reg [55:0] time_date_str;
  // Otomatik saat ve tarih sayımı
always @(posedge clk2) begin
    if (counter) begin
    time_date_str = {year3, year2, year1, year0, month1 , month0, day1, day0, hour1, hour0, min1, min0, sec1, sec0};
        sec0 <= sec0 + 1;
        if (sec0 == 9) begin
            sec0 <= 0;
            sec1 <= sec1 + 1;
            if (sec1 == 5) begin
                sec1 <= 0;
                min0 <= min0 + 1;
                if (min0 == 9) begin
                    min0 <= 0;
                    min1 <= min1 + 1;
                    if (min1 == 5) begin
                        min1 <= 0;
                        hour0 <= hour0 + 1;
                        if (hour0 == 9) begin
                            hour0 <= 0;
                            hour1 <= hour1 + 1;
                            end
                            if (hour1 == 2 && hour0 == 3) begin
                                hour1 <= 0;
                                hour0 <= 0;
                                day0 <= day0 + 1;
                                if (day0 == 9) begin
                                    day0 <= 0;
                                    day1 <= day1 + 1;
                                    end
                                    if (day1 == 3) begin // 30 gün olan ay
                                        day1 <= 0;
                                        day0 <= 1;
                                        month0 <= month0 + 1;
                                        if (month0 == 9) begin
                                            month0 <= 0;
                                            month1 <= month1 + 1;
                                            end
                                            if (month1 == 1 && month0==2) begin // 360 gün olan yıl
                                                month1 <= 0;
                                                month0 <= 1;
                                                year0 <= year0 + 1;
                                                if (year0 == 9) begin
                                                    year0 <= 0;
                                                    year1 <= year1 + 1;
                                                    if (year1 == 9) begin
                                                        year1 <= 0;
                                                        year2 <= year2 + 1;
                                                        if (year2 == 9) begin
                                                            year2 <= 0;
                                                            year3 <= year3 + 1;
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end else begin
                        //resetleme
                    if(rst)begin
                        sec0 = 0;
                        sec1 = 0;
                        min0 = 0;
                        min1 = 3;
                        hour0 = 8;
                        hour1 = 1;
                        day0 = 0;
                        day1 = 3;
                        month0 = 7;
                        month1 = 0;
                        year0 = 4;
                        year1 = 2;
                        year2 = 0;
                        year3 = 2;
                    end else begin
                        // Dakika arttırma
                         if (minUp) begin
                             if (min0 == 9 && min1 == 5) begin
                                 min0 <= 0;
                                 min1 <= 0;
                             end else if (min0 == 9) begin
                                 min0 <= 0;
                                 min1 <= min1 + 1;
                             end else begin
                                 min0 <= min0 + 1;
                             end
                         end
                         
                         // Dakika azaltma
                         if (minDown) begin
                             if (min0 == 0 && min1 == 0) begin
                                 min0 <= 9;
                                 min1 <= 5;
                             end else if (min0 == 0) begin
                                 min0 <= 9;
                                 min1 <= min1 - 1;
                             end else begin
                                 min0 <= min0 - 1;
                             end
                         end
                         
                         // Saat arttırma
                         if (hourUp) begin
                             if (hour0 == 3 && hour1 == 2) begin
                                 hour0 <= 0;
                                 hour1 <= 0;
                             end else if (hour0 == 9) begin
                                 hour0 <= 0;
                                 hour1 <= hour1 + 1;
                             end else begin
                                 hour0 <= hour0 + 1;
                             end
                         end
                         
                         // Saat azaltma
                         if (hourDown) begin
                             if (hour0 == 0 && hour1 == 0) begin
                                 hour0 <= 3;
                                 hour1 <= 2;
                             end else if (hour0 == 0) begin
                                 hour0 <= 9;
                                 hour1 <= hour1 - 1;
                             end else begin
                                 hour0 <= hour0 - 1;
                             end
                         end
                         
                         if(sw[0])begin
                            sec0[0] <=1;
                         end
                         if(sw[1])begin
                            sec0[1] <=1;  
                         end 
                         if(sw[2])begin
                            sec0[2] <=1;  
                         end 
                         if(sw[3])begin                    
                            sec0[3] <=1;  
                         end     
                         if(sw[4])begin      
                            sec1[0] <=1;  
                         end  
                         if(sw[5])begin
                            sec1[1] <=1;  
                         end 
                         if(sw[6])begin
                            sec1[2] <=1;  
                         end          
                    end     
                end
            end



    // LED'lere saniye göstermek
    always @(posedge clk) begin
         led[5:0] <= {sec1[2:0], sec0};
         //$display("tarih: %d%d %d%d %d%d%d%d saat %d%d: %d%d :%d%d", day1, day0, month1, month0, year3, year2, year1, year0, hour1, hour0, min1, min0, sec1, sec0);
   
    end
    
    
        
      wire [7:0]dout;
      wire drdy;
    
     reg txstart;
     reg [5:0] sayac; // İki durumlu sayaç
    reg [7:0] temp_value; // Geçici değer

    always @(posedge clk) begin
    if(dout==8'h61)begin
        if (sayac == 0) begin
            // Saniyenin birler hanesi
            case (day1)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
         
            sayac <= 1;
        end else if (sayac == 1) begin
            // Saniyenin onlar hanesi
            case (day0)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <= 2;
        end else if (sayac == 2) begin
            // Dakikanın birler hanesi
            case (month1)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <= 3;
            end else if (sayac == 3) begin
            // Dakikanın onlar hanesi
            case (month0)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <= 4;      
        end else if (sayac == 4) begin
            // Saatin birler hanesi
            case (year3)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac<=5;
        end else if (sayac == 5) begin
            // Saatin onlar hanesi
            case (year2)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <= 6;
        end else if (sayac == 6) begin
            // Günün birler hanesi
            case (year1)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <= 7;
        end else if (sayac == 7) begin
            // Günün onlar hanesi
            case (year0)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <= 8;
        end else if (sayac == 8) begin
            case (hour1)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <= 9;
        end else if (sayac == 9) begin
            // Ayın onlar hanesi
            case (hour0)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <= 10;
        end else if (sayac == 10) begin
            // Yılın binler hanesi
            case (min1)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <= 11;
        end else if (sayac == 11) begin
            // Yılın yüzler hanesi
            case (min0)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <= 12;
        end else if (sayac == 12) begin
            // Yılın onlar hanesi
            case (sec1)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <= 13;
        end else if (sayac == 13) begin
            // Yılın birler hanesi
            case (sec0)
                4'd0: temp_value <= 8'h30; // '0'
                4'd1: temp_value <= 8'h31; // '1'
                4'd2: temp_value <= 8'h32; // '2'
                4'd3: temp_value <= 8'h33; // '3'
                4'd4: temp_value <= 8'h34; // '4'
                4'd5: temp_value <= 8'h35; // '5'
                4'd6: temp_value <= 8'h36; // '6'
                4'd7: temp_value <= 8'h37; // '7'
                4'd8: temp_value <= 8'h38; // '8'
                4'd9: temp_value <= 8'h39; // '9'
                default: temp_value <= 8'h30; // Varsayılan olarak '0'
            endcase
            sayac <=0; // Döngüyü başlat
        
        end
      end
    end

    


    uartrx URX(
      .clk(clk),
     .rst(rst), 
     .rx(rx), 
     .data_ready(drdy), 
     .data_out(dout)
     );
     
     
     
  wire donetx;
  
    uarttx UTX(
    .clk(clk),
    .rst(rst), 
    .start(hourUp),
    .data_in(temp_value),
    .tx(tx), 
    .tx_ready(donetx)
    );
    
  
  
endmodule    