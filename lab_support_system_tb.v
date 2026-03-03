`timescale 1ns / 1ps

module lab_support_system_tb;

    reg clk;
    reg rst;
    reg service_done;

    reg vlsi_req;
    reg embedded_req;
    reg comm_req;
    reg power_req;

    wire vlsi_led;
    wire embedded_led;
    wire comm_led;
    wire power_led;
    wire system_busy;

    lab_support_system uut (
        .clk(clk),
        .rst(rst),
        .service_done(service_done),
        .vlsi_req(vlsi_req),
        .embedded_req(embedded_req),
        .comm_req(comm_req),
        .power_req(power_req),
        .vlsi_led(vlsi_led),
        .embedded_led(embedded_led),
        .comm_led(comm_led),
        .power_led(power_led),
        .system_busy(system_busy)
    );

    // 100 MHz Clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        service_done = 0;
        vlsi_req = 0;
        embedded_req = 0;
        comm_req = 0;
        power_req = 0;

        #20 rst = 0;

        // ------------------------------------
        // 1️⃣ Single VLSI request
        #20 vlsi_req = 1;
        #20 vlsi_req = 0;

        #40 service_done = 1; #10 service_done = 0;

        // ------------------------------------
        // 2️⃣ Single Embedded request
        #20 embedded_req = 1;
        #20 embedded_req = 0;

        #40 service_done = 1; #10 service_done = 0;

        // ------------------------------------
        // 3️⃣ Two simultaneous (VLSI + Power)
        #20 vlsi_req = 1; power_req = 1;
        #20 vlsi_req = 0; power_req = 0;

        // Power should serve first
        #40 service_done = 1; #10 service_done = 0;

        // Then VLSI
        #40 service_done = 1; #10 service_done = 0;

        // ------------------------------------
        // 4️⃣ Three simultaneous (Embedded + Comm + Power)
        #20 embedded_req = 1;
            comm_req = 1;
            power_req = 1;
        #20 embedded_req = 0;
            comm_req = 0;
            power_req = 0;

        // Expected order: Power → Comm → Embedded
        #40 service_done = 1; #10 service_done = 0;
        #40 service_done = 1; #10 service_done = 0;
        #40 service_done = 1; #10 service_done = 0;

        // ------------------------------------
        // 5️⃣ Disturbing case:
        // Embedded active, then Power interrupts
        #20 embedded_req = 1;
        #20 power_req = 1;
        #20 embedded_req = 0; power_req = 0;

        #40 service_done = 1; #10 service_done = 0;
        #40 service_done = 1; #10 service_done = 0;

        #100 $stop;
    end

endmodule

