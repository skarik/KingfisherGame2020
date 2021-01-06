/// @description Draw the screen info

// draw checkerboard
var kCheckboardSize = 128;

var patternBit;

for (var xPosition = 0; xPosition < width; xPosition += kCheckboardSize)
{
	patternBit = ((xPosition / kCheckboardSize) % 2) == 1;
	for (var yPosition = 0; yPosition < height; yPosition += kCheckboardSize)
	{
		draw_set_color(patternBit ? c_gray : c_blue);
		draw_rectangle(xPosition, yPosition, xPosition + kCheckboardSize, yPosition + kCheckboardSize, false);
		
		patternBit = !patternBit;
	}
}

// draw dots for pixel scale info
draw_set_color(c_red);
for (var xPosition = 2; xPosition < 100; xPosition += 2)
{
	draw_point(xPosition, 10);
}

// draw info
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

draw_text(32, 32, string(width) + " x " + string(height));