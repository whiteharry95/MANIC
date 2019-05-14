/// @param x1
/// @param  y1
/// @param  x2
/// @param  y2
/// @param  object
/// @param width
var x1 = argument[0];
var y1 = argument[1];
var x2 = argument[2];
var y2 = argument[3];
var obj = argument[4];
var width = 1;

if (argument_count > 5){
	width = argument[5];
}

var dist = point_distance(x1, y1, x2, y2);
var xorigin = x1;
var yorigin = y1;
var dir = point_direction(x1, y1, x2, y2);
var len = 0;
var jump = 2;

while(inroom(x1, y1)){
	if (!collision_line_width(xorigin, yorigin, x1, y1, width, obj)){
	    x1 += lengthdir_x(jump, dir);
	    y1 += lengthdir_y(jump, dir);
		len += jump;
		
	}else{
		break;
	}
	
	if (len >= dist){
		break;
	}
}

return len;