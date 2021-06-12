/// @description Insert description here
// You can write your code in this editor
{
	//var blackbox = ((iexists(o_CtsBlackBoxes) || display_blackbox_override) && !display_whitebox_override);
	var dx, dy;
	//dx = uiPosX; 
	//dy = uiPosY + (iexists(input_actor) ? 10 : 0);
	var blackbox = false;
	dx = Screen.width / 2 + Screen.width * 0.1;
	dy = Screen.height / 2;
	
	display_width = Screen.width / 3;
	display_height = Screen.height * 0.15;
	draw_set_color(c_ltgray);
	draw_rectangle(dx, dy, dx + display_width, dy + display_height, false);
	
	var seed = mt19937_get_state();
	mt19937_seed(floor(current_time / 1000.0 * 30.0));

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	//draw_set_alpha(smoothstep((image_alpha-0.5)*2.0));
	
	// Set up fonts
	/*var l_display_font = input.minimal ? display_font_minimal : display_font;
	var l_display_font_bold = input.minimal ? display_font_minimal_bold : display_font_bold;
	var l_display_font_height = input.minimal ? display_font_minimal_height : display_font_height;
	var l_display_mumble_font = display_font_mumble;
	var l_display_mumble_font_bold = display_font_mumble_bold;*/
	var l_display_font = f_textBox;

	draw_set_font(l_display_font);
	//l_display_font_height = 12;
	//var text_dx = l_display_font_height;
	var text_refw = string_width("m");
	var text_refh = string_height("M");
	var text_refscale = Screen.height / 1024.0;

	var text_w = display_width;
	var penx = 0;
	var peny = 0;
	var penc = blackbox ? c_white : c_black;
	var penw = 2;
	var penh = 5;
	var penwiggle = false;
	var penshake = false;
	var penwigglex = false;
	var pensmol = false;
	var penbold = false;
	var penscale = 1.0;
	for (var i = 0; i < floor(display.count); ++i)
	{
	    if ( is_array(display.flags[i]) )
	    {
			var flags = display.flags[i];
			var flags_len = array_length_1d(flags);
			for (var iFlag = 0; iFlag < flags_len; ++iFlag)
			{
				var flag = flags[iFlag];
		        if ( flag == ord("0") )
		            penc = blackbox ? c_white : make_color_rgb(31, 36, 10);
		        if ( flag == ord("1") )
		            penc = c_red;
		        if ( flag == ord("2") )
		            penc = c_gray;
				if ( flag == ord("3") )
					penc = merge_color(c_electricity, c_navy, 0.5);
				if ( flag == ord("4") )
					penc = c_gold;
				if ( flag == ord("5") )
					penc = c_riftgreen;
		        if ( flag == ord("b") )
		        {
					penbold = true;
		        }
		        if ( flag == ord("$") )
		        {
					penbold = false;
					penwiggle = false;
					penshake = false;
					penwigglex = false;
					pensmol = false;
		        }
				if ( flag == ord("w") )
					penwiggle = true;
				if ( flag == ord("s") )
					penshake = true;
				if ( flag == ord("h") )
					penwigglex = true;
				if ( flag == ord("q") )
					pensmol = true;
				if ( flag == ord("M") )
				{ // motses shorthand
					penc = c_motsestext;
					//penbold = true;
				}
		        // Newline!
		        if ( flag == ord("#") )
		        {
		            penx = 0;
		            peny += text_refh + penh;
		        }
			}
		
			// Update complex overlapping font flags at this font
			/*if (!pensmol)
			{
				if (!penbold)
				{
					draw_set_font(l_display_font);
				    text_refw = string_width("m");
				    penw = 2;
				}
				else
				{
					draw_set_font(l_display_font_bold);
				    text_refw = string_width("m");
				    penw = 3;
				}
			}
			else
			{
				if (!penbold)
				{
					draw_set_font(l_display_mumble_font);
				    text_refw = string_width("m");
				    penw = 1;
				}
				else
				{
					draw_set_font(l_display_mumble_font_bold);
				    text_refw = string_width("m");
				    penw = 2;
				}
			}*/
	    }

	    var char = string_char_at(display.text, i + 1);
    
		var charscale = text_refscale * penscale;
	
		var xoffset = 0;
		var yoffset = 0;
		if (penwiggle)
			yoffset += round(sin(current_time / 200.0 + i * 0.76) * 3.4);
		if (penwigglex)
			xoffset += round(sin(current_time / 230.0 - i * 0.96) * (penw + 0.4));
		if (penshake) {
			xoffset += round(mt19937_random_range(-1.4, 1.4));
			yoffset += round(mt19937_random_range(-1.4, 1.4));
		}
		if (pensmol)
		{
			xoffset *= 0.5;
			yoffset *= 0.5;
			xoffset += 0.4;
			yoffset += text_refh * 0.5;
		
			xoffset = round(xoffset);
			yoffset = round(yoffset) - 1;
		}
		
		var draw_text_shorthand = function(aggregate, in_offset_x, in_offset_y)
		{
			draw_text_transformed(
				aggregate.dx + (aggregate.penx + aggregate.xoffset) * aggregate.charscale + in_offset_x,
				aggregate.dy + (aggregate.peny + aggregate.yoffset) * aggregate.charscale + in_offset_y,
				aggregate.char, aggregate.charscale, aggregate.charscale,
				0);
		}
		var agg = {
			dx : dx,
			dy : dy,
			penx : penx,
			peny : peny,
			xoffset : xoffset,
			yoffset : yoffset,
			charscale : charscale,
			char : char
		};
	
	    // draw the text
		if (!input.minimal)
		{
			/*if (penc == c_gold || penc == c_motsestext)
			{	// gold (and other colors) get a special outline
				draw_set_color( c_black );
				draw_text(dx + penx + xoffset, dy + peny + 1 + yoffset, char);
				draw_text(dx + penx + xoffset, dy + peny - 1 + yoffset, char);
				draw_text(dx + penx + 1 + xoffset, dy + peny + yoffset, char);
				draw_text(dx + penx - 1 + xoffset, dy + peny + yoffset, char);
				draw_text(dx + penx - 1 + xoffset, dy + peny + 1 + yoffset, char);
				draw_text(dx + penx + 1 + xoffset, dy + peny - 1 + yoffset, char);
				draw_text(dx + penx + 1 + xoffset, dy + peny + 1 + yoffset, char);
				draw_text(dx + penx - 1 + xoffset, dy + peny - 1 + yoffset, char);
			}
			else*/
			{	// otherwise, do simple dropshadow outline
				draw_set_color( blackbox ? c_dkgray : make_color_rgb(180, 180, 180) );
				draw_text_shorthand(agg, 0, 1);
			}
		}
		// no box, need white outline
		else
		{
			//draw_set_color(make_color_rgb(239, 216, 161));
			//draw_set_color(c_white);
			draw_set_color(merge_color(c_white, make_color_rgb(239, 216, 161), 0.5));
			draw_text_shorthand(agg,  0,  1);
			draw_text_shorthand(agg,  0, -1);
			draw_text_shorthand(agg,  1,  0);
			draw_text_shorthand(agg, -1,  0);
		
			draw_text_shorthand(agg,  1, -1);
			draw_text_shorthand(agg, -1, -1);
			draw_text_shorthand(agg,  1,  1);
			draw_text_shorthand(agg, -1,  1);
		}
		draw_set_color( penc );
		draw_text_shorthand(agg, 0, 0);
    
	    // do a lookahead for dropping a line if currently on a space
	    var override_drop = false;
	    if ( char == " " )
	    {
	        var vpenx = penx;
	        var n = i + 1, next_char;
	        do
	        {
	            next_char = string_char_at(display.text, n+1);
	            if (next_char != " ")
	            {
	                //vpenx += ceil(text_dx * string_width(next_char)/text_refw) + penw;
					vpenx += string_width(next_char) * penscale + penw;
	                if (vpenx >= text_w) override_drop = true;
	            }
	            n++;
	        }
			until (next_char == " " || n >= string_length(display.text) || override_drop);
	        //until (next_char == " " || n >= floor(display.count) || override_drop);
	    }
    
	    // move the pen
	    //penx += ceil(text_dx * string_width(char)/text_refw) + penw;
		penx += string_width(char) * penscale + penw;//ceil(text_dx * string_width(char)/text_refw) + penw;
	    if ( override_drop || (char == " " && penx >= text_w) )
	    {
	        penx = 0;
	        peny += text_refh + penh;
	    }
	}
	
	mt19937_set_state(seed);

	draw_set_alpha(1.0);
	
}