// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
    reg  [2:0] t_sel;
    wire [7:0] t_dout;
  // TODO: instantiate DUT here
    lut #(.WIDTH(8), .DEPTH(8)) DUT (
      .sel  (t_sel),
      .dout (t_dout)
    );
  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
    t_sel = 3'b000;
    #5;
    t_sel = 3'b001;
    #5;
    t_sel = 3'b010;
    #5;
    t_sel = 3'b011;
    #5;
    t_sel = 3'b100;
    #5;
    t_sel = 3'b101;
    #5;
    t_sel = 3'b110;
    #5;
    t_sel = 3'b111;
    #5;

    $finish;
  end

  initial
    $monitor($time, " SEL=%b | DOUT=%d", t_sel, t_dout); // change as required

endmodule
