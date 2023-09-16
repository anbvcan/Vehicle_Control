module vehicleControl(
  input logic clock,
  input logic _switch,
  input logic [1:0] _turnShift,
  input logic [1:0] _gearShift,
  output logic [1:0] _turnState,
  output logic [1:0] _gearState
);

  localparam _OFF = 0, _ON = 1;
  
  localparam _NO_ACTION   = 2'b00,
             _DOWN_ACTION = 2'b01,
             _UP_ACTION   = 2'b10;
  
  localparam _PARKING_SHIFT = 2'b00,
  			     _REVERSE_SHIFT = 2'b01,
             _FORWARD_SHIFT = 2'b11;
  
  localparam _NO_TURN_STATE    = 2'b00,
  			     _LEFT_TURN_STATE  = 2'b01,
             _RIGHT_TURN_STATE = 2'b11;
  
  localparam _LOCK_STATE    = 2'b00,
  			     _PARKING_STATE = 2'b01,
  		       _REVERSE_STATE = 2'b10,
  			     _FORWARD_STATE = 2'b11;
  
  // Gear Control
  always @(posedge clock)
    begin
      if(!_switch)
        begin
        	_gearState = _LOCK_STATE;
        end 
      else 
        begin
          case(_gearState)
            _LOCK_STATE:
              begin
                _gearState <= _PARKING_STATE;
              end
            _PARKING_STATE:
              if(_gearShift == _REVERSE_SHIFT) begin
                  _gearState <= _REVERSE_STATE;
              end else if(_gearShift == _FORWARD_SHIFT) begin 
                  _gearState <= _FORWARD_STATE;
              end else begin
                  _gearState <= _PARKING_STATE;
              end
            _REVERSE_STATE:
              if(_gearShift == _PARKING_SHIFT) begin
                  _gearState <= _PARKING_STATE;
              end else if(_gearShift == _FORWARD_SHIFT) begin 
                  _gearState <= _FORWARD_STATE;
              end else begin
                  _gearState <= _REVERSE_STATE;
              end
            _FORWARD_STATE:
              if(_gearShift == _PARKING_SHIFT) begin
                  _gearState <= _PARKING_STATE;
              end else if(_gearShift == _REVERSE_SHIFT) begin 
                  _gearState <= _REVERSE_STATE;
              end else begin
                  _gearState <= _FORWARD_STATE;
              end
            default:
              begin 
                _gearState <= _PARKING_STATE;
              end
          endcase
        end
    end
  
  // Light Control
  always @(posedge clock)
    begin
      if(!_switch) begin
        _turnState <= _NO_TURN_STATE;
      end else begin
        case(_turnState) 
          _NO_TURN_STATE:
            if(_turnShift == _DOWN_ACTION) begin
              _turnState <= _RIGHT_TURN_STATE;
            end else if(_turnShift == _UP_ACTION) begin
              _turnState <= _RIGHT_TURN_STATE;
            end else begin
              _turnState <= _NO_TURN_STATE;
            end
          _LEFT_TURN_STATE:
            if(_turnShift == _DOWN_ACTION) begin
              _turnState <= _LEFT_TURN_STATE;
            end else if(_turnShift == _UP_ACTION) begin
              _turnState <= _NO_ACTION;
            end else begin
              _turnState <= _LEFT_TURN_STATE;
            end
          _RIGHT_TURN_STATE:
            if(_turnShift == _DOWN_ACTION) begin
              _turnState <= _NO_ACTION;
            end else if(_turnShift == _UP_ACTION) begin
              _turnState <= _RIGHT_TURN_STATE;
            end else begin
              _turnState <= _RIGHT_TURN_STATE;
            end
          default:
            begin
            	_turnState <= _NO_TURN_STATE;
            end
        endcase
      end
    end
endmodule
      
      
          
        
