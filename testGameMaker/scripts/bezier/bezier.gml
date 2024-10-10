function bezier(_value,to_value,an, to_an, variable, _point){
	var result
	var _an = variable - an
		, _to_an = to_an - an
    if _an <= 0
        result = _value;
    else if _an >= _to_an
        result = to_value;
    else {
        var u = _an/_to_an
			, bezier_point = _value + (to_value - _value)*_point
		
        result = _value*(1-u)*(1-u) + bezier_point*2*u*(1-u) +to_value*u*u;
	}
	
    return result
}