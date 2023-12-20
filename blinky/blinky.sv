`timescale 1ns/100ps
module blinky(
   input    clk,
   input    resetn,
   output   reg blink
   );

   `define CYCLE_DELAY 2
   `define TOTAL_BEAT_CYCLES ((`CYCLE_DELAY * 3) - 1)
   `define TOTAL_OFF_CYCLES ((`CYCLE_DELAY * 6) - 1)

   `define BEAT_1_ON_CYCLES (`CYCLE_DELAY * 0)
   `define BEAT_OFF_CYCLES (`CYCLE_DELAY * 1)
   `define BEAT_2_ON_CYCLES (`CYCLE_DELAY * 2)

   typedef enum logic [1:0] {
      INIT_STATE,
      BEAT_STATE,
      OFF_STATE
   } state;

   reg [1:0] current_state, next_state;
   reg [34:0] counter;

   parameter init = 2'b00;
   parameter beat = 2'b01;
   parameter off = 2'b10;

   always@(posedge clk or negedge resetn)
   begin
      if(~resetn) begin
         current_state <= INIT_STATE;
         counter <= 0;
      end else begin
         current_state <= next_state;
         case (current_state)
            INIT_STATE: counter <= 0;

            default: counter <= counter + 1;
         endcase
      end
   end

   // State transition management
   always @(posedge clk) begin
      case(current_state)
         INIT_STATE: next_state <= BEAT_STATE;

         BEAT_STATE: begin
            if(counter == `TOTAL_BEAT_CYCLES) begin
               next_state <= OFF_STATE;
            end
         end

         OFF_STATE: begin
            if(counter == `TOTAL_OFF_CYCLES) begin
               next_state <= INIT_STATE;
            end
         end

         default: next_state <= INIT_STATE; // Default state
      endcase
   end

   // Output condition
   always @(posedge clk) begin
      case (current_state)
         INIT_STATE: blink <= 1'b0;

         BEAT_STATE: begin
            if(counter == `BEAT_1_ON_CYCLES) begin
               blink <= 1'b1;
            end else if(counter == `BEAT_OFF_CYCLES) begin
               blink <= 1'b0;
            end else if(counter == `BEAT_2_ON_CYCLES) begin
               blink <= 1'b1;
            end

         end

         OFF_STATE: blink <= 1'b0;

         default: blink <= 1'b0; // Default state output
      endcase
   end

endmodule