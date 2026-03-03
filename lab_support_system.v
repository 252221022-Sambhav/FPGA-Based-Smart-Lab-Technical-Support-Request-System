`timescale 1ns / 1ps

module lab_support_system (
    input clk,
    input rst,
    input service_done,

    input vlsi_req,
    input embedded_req,
    input comm_req,
    input power_req,

    output reg vlsi_led,
    output reg embedded_led,
    output reg comm_led,
    output reg power_led,
    output reg system_busy
);

    // State registers
  
    reg [3:0] pending;
    reg [3:0] next_pending;

    reg [1:0] current_lab;
    reg [1:0] next_lab;

    // Combine requests
  
    wire [3:0] lab_req;
    assign lab_req = {power_req, comm_req, embedded_req, vlsi_req};

    
    // Sequential Block
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pending <= 4'b0000;
            current_lab <= 2'b00;
        end else begin
            pending <= next_pending;
            current_lab <= next_lab;
        end
    end

    
    // Next-State Logic
    
    always @(*) begin
        next_pending = pending | lab_req;

        // Clear current lab when service_done
      
        if (service_done) begin
            case (current_lab)
                2'b00: next_pending[0] = 0;
                2'b01: next_pending[1] = 0;
                2'b10: next_pending[2] = 0;
                2'b11: next_pending[3] = 0;
            endcase
        end

        // Priority logic
      
        casex(next_pending)
            4'b1xxx: next_lab = 2'b11;  // Power
            4'b01xx: next_lab = 2'b10;  // Comm
            4'b001x: next_lab = 2'b01;  // Embedded
            4'b0001: next_lab = 2'b00;  // VLSI
            default: next_lab = current_lab;
        endcase
    end

    // Output Logic
    
    always @(*) begin
        vlsi_led     = 0;
        embedded_led = 0;
        comm_led     = 0;
        power_led    = 0;
        system_busy  = 0;

        if (pending != 4'b0000) begin
            system_busy = 1;

            case (current_lab)
                2'b00: vlsi_led     = 1;
                2'b01: embedded_led = 1;
                2'b10: comm_led     = 1;
                2'b11: power_led    = 1;
            endcase
        end
    end

endmodule
