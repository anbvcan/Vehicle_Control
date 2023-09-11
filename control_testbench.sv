module vehicleControlTB;
  reg clock, _switch;
  reg [1:0] _turnShift;
  reg [1:0] _gearShift;
  reg [1:0] _turnState;
  reg [1:0] _gearState;
  
  
  vehicleControl uut(
    .clock(clock),
    ._switch(_switch),
    ._turnShift(_turnShift),
    ._gearShift(_gearShift),
    ._turnState(_turnState),
    ._gearState(_gearState)
  );
    
  initial begin
    clock = 0;
    forever #1 clock = ~clock;
  end
  
  initial begin
	  // Car is OFF
    _switch = 0; _turnShift = 2'b00; _gearShift = 2'b00; _turnState = 2'b00; _gearState = 2'b00;
    #5;
    if (_gearState != 2'b00)
      begin
        $display("Expected 2'b00 _LOCK but actual state is %d", _gearState);
      end
    if (_turnState != 2'b00)
      begin
        $display("Expected 2'b00 _NO_TURN but actual state is %d", _turnState);
      end
    
    // Car is from OFF to ON
    _switch = 1; _turnShift = 2'b00; _gearShift = 2'b00; _turnState = 2'b00; _gearState = 2'b00;
    #5;
    if (_gearState != 2'b01)
      begin
        $display("Expected 2'b01 _PARKING but actual state is %d", _gearState);
      end
    if (_turnState != 2'b00)
      begin
        $display("Expected 2'b00 _NO_TURN but actual state is %d", _turnState);
      end
    
	  // Car is from PARKING to REVERSE
    _switch = 1; _turnShift = 2'b00; _gearShift = 2'b01; _turnState = 2'b00; _gearState = 2'b01;
    #5;
    if (_gearState != 2'b10)
      begin
        $display("Expected 2'b10 _REVERSE but actual state is %d", _gearState);
      end
    if (_turnState != 2'b00)
      begin
        $display("Expected 2'b00 _NO_TURN but actual state is %d", _turnState);
      end
    
	  // Car is from REVERSE to FORWARD
    _switch = 1; _turnShift = 2'b00; _gearShift = 2'b11; _turnState = 2'b00; _gearState = 2'b10;
    #5;
    if (_gearState != 2'b11)
      begin
        $display("Expected 2'b11 _FORWARD but actual state is %d", _gearState);
      end
    if (_turnState != 2'b00)
      begin
        $display("Expected 2'b00 _NO_TURN but actual state is %d", _turnState);
      end
    
	  // Car turns on right turn light
    _switch = 1; _turnShift = 2'b10; _gearShift = 2'b11; _turnState = 2'b00; _gearState = 2'b11;
    #5;
    if (_gearState != 2'b11)
      begin
        $display("Expected 2'b11 _FORWARD but actual state is %d", _gearState);
      end
    if (_turnState != 2'b11)
      begin
        $display("Expected 2'b11 _RIGHT_TURN but actual state is %d", _turnState);
      end
    
	  // Car turns off right turn light
    _switch = 1; _turnShift = 2'b01; _gearShift = 2'b11; _turnState = 2'b11; _gearState = 2'b11;
    #5;
    if (_gearState != 2'b11)
      begin
        $display("Expected 2'b11 _FORWARD but actual state is %d", _gearState);
      end
    if (_turnState != 2'b00)
      begin
        $display("Expected 2'b00 _NO_TURN but actual state is %d", _turnState);
      end
    
	  // Car turns on left turn light
    _switch = 1; _turnShift = 2'b01; _gearShift = 2'b11; _turnState = 2'b00; _gearState = 2'b11;
    #5;
    if (_gearState != 2'b11)
      begin
        $display("Expected 2'b11 _FORWARD but actual state is %d", _gearState);
      end
    if (_turnState != 2'b01)
      begin
        $display("Expected 2'b01 _LEFT_TURN but actual state is %d", _turnState);
      end
    
	  // Car turns off left turn light
    _switch = 1; _turnShift = 2'b10; _gearShift = 2'b11; _turnState = 2'b01; _gearState = 2'b11;
    #5;
    if (_gearState != 2'b11)
      begin
        $display("Expected 2'b11 _FORWARD but actual state is %d", _gearState);
      end
    if (_turnState != 2'b00)
      begin
        $display("Expected 2'b00 _NO_TURN but actual state is %d", _turnState);
      end
    
	  // Car is from FORWARD to PARKING
    _switch = 1; _turnShift = 2'b10; _gearShift = 2'b00; _turnState = 2'b00; _gearState = 2'b11;
    #5;
    if (_gearState != 2'b01)
      begin
        $display("Expected 2'b01 _PARKING but actual state is %d", _gearState);
      end
    if (_turnState != 2'b00)
      begin
        $display("Expected 2'b00 _NO_TURN but actual state is %d", _turnState);
      end
	 
	// Car is from ON to OFF
	_switch = 0; _turnShift = 2'b10; _gearShift = 2'b11; _turnState = 2'b00; _gearState = 2'b01;
    #5;
    if (_gearState != 2'b00)
      begin
        $display("Expected 2'b00 _LOCK but actual state is %d", _gearState);
      end
    if (_turnState != 2'b00)
      begin
        $display("Expected 2'b00 _NO_TURN but actual state is %d", _turnState);
      end
    
    $stop;
  end
endmodule
    
