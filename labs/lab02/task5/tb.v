module tb;

// DUT inputs
  reg [3:0] t_a;
  reg [3:0] t_b;
  reg       t_op;

// DUT outputs
wire [3:0] t_result;

// Expected outputs
reg [3:0] exp_result;
// Error counter
integer errors;
integer total;
integer passed;

// Instantiate DUT
  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

// Waveform dump
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

// Test all 16 combinations
  initial begin
    errors = 0;
    total = 0;

    // ------------------------------------------------
    // Test 1: SAME operands, switch operation
    // This is specifically meant to catch the sensitivity-list bug.
    // ------------------------------------------------

    t_a = 4'd7;
    t_b = 4'd3;

    // ADD: 7 + 3 = 10
    t_op = 1'b0;
    #1;

    exp_result = t_a + t_b;
    total = total + 1;

    if (t_result !== exp_result) begin
      $display("FAIL: A=%d B=%d OP=%b | got=%d expected=%d", t_a, t_b, t_op, t_result, exp_result);
      errors = errors + 1;
    end

    // SUB: 7 - 3 = 4
    // Same A and B, only OP changes
    t_op = 1'b1;
    #1;

    exp_result = t_a - t_b;
    total = total + 1;

    if (t_result !== exp_result) begin
      $display("FAIL: A=%d B=%d OP=%b | got=%d expected=%d", t_a, t_b, t_op, t_result, exp_result);
      errors = errors + 1;
    end

    // ------------------------------------------------
    // Test 2: Different operands, ADD
    // ------------------------------------------------

    t_a = 4'd5;
    t_b = 4'd6;
    t_op = 1'b0;
    #1;

    exp_result = t_a + t_b;
    total = total + 1;

    if (t_result !== exp_result) begin
      $display("FAIL: A=%d B=%d OP=%b | got=%d expected=%d", t_a, t_b, t_op, t_result, exp_result);
      errors = errors + 1;
    end

    // ------------------------------------------------
    // Test 3: Different operands, SUB
    // ------------------------------------------------

    t_a = 4'd9;
    t_b = 4'd4;
    t_op = 1'b1;
    #1;

    exp_result = t_a - t_b;
    total = total + 1;

    if (t_result !== exp_result) begin
      $display("FAIL: A=%d B=%d OP=%b | got=%d expected=%d", t_a, t_b, t_op, t_result, exp_result);
      errors = errors + 1;
    end

    // ------------------------------------------------
    // More subtraction tests
    // ------------------------------------------------

    t_a = 4'd12;
    t_b = 4'd5;
    t_op = 1'b1;
    #1;

    exp_result = t_a - t_b;
    total = total + 1;

    if (t_result !== exp_result) begin
      $display("FAIL: A=%d B=%d OP=%b | got=%d expected=%d", t_a, t_b, t_op, t_result, exp_result);
      errors = errors + 1;
    end

    t_a = 4'd3;
    t_b = 4'd8;
    t_op = 1'b1;
    #1;

    exp_result = t_a - t_b;
    total = total + 1;

    if (t_result !== exp_result) begin
      $display("FAIL: A=%d B=%d OP=%b | got=%d expected=%d", t_a, t_b, t_op, t_result, exp_result);
      errors = errors + 1;
    end

    // ------------------------------------------------
    // Summary
    // ------------------------------------------------

    passed = total - errors;

    $display("SUMMARY: %0d/%0d tests passed, %0d errors.",passed, total, errors);

    $finish;

  end

  // Monitor signals during simulation
  initial begin
    $monitor($time, "A = %b B = %b OP = %b | RESULT = %b", t_a, t_b, t_op, t_result);
  end

endmodule