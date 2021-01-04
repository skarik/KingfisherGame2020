function SequenceLoad(localFile)
{
	// Initialize local state
	SequenceInitializeLocal();
	
	// Find the seqeuence
	var seq_str = fioReadToString(localFile);
	if (!is_string(seq_str))
	{
		return false;
	}
	
	// We have the sequence loaded into a string. We need to load in the linear listing of all the actions.
	
	// Check the first line. Does it contain "!/osf/seq/2"? If so, we can properly read it.
	{
		var first_line = string_copy(seq_str, 1, string_pos_ext("\n", seq_str, 1));
		if (string_pos("!/osf/seq/2", first_line) == 0)
		{
			return false;
		}
	}
	
	// Strip all comments now
	{
		var seq_str_no_comments = "";
		
		var current_pos, current_end_of_line;
		current_pos = 1;
		
		var bAtEOF = false;
		while (!bAtEOF)
		{
			// Loop through line-by-line
			
			// Find end of line
			current_end_of_line = string_pos_ext("\n", seq_str, current_pos);
			if (current_end_of_line == 0)
			{
				current_end_of_line = string_length(seq_str);
			}
			if (current_pos >= current_end_of_line)
			{
				// We need to parse current buffer, then break.
				bAtEOF = true;
				continue;
			}
			
			// Grab the current line.
			var current_line = string_copy(seq_str, current_pos, current_end_of_line - current_pos);
			// Remove all comments
			current_line = string_rtrim_comment(current_line);
			// Add to the current buffer
			seq_str_no_comments += current_line + "\n";
			
			// Continue on
			current_pos = current_end_of_line + 1;
		}
		
		// Save the new no-comments file.
		seq_str = seq_str_no_comments;
	}
	
	// Next, perform normal OSF loading: each line is a key-value pair.
	// After a key-value pair, there can be any amount of whitespace, then a {.
	// If there is a non-whitespace and non-{ character, we have a new keyvalue.
	{
		var current_pos, current_end_of_line;
		current_pos = 1;
		
		var bAtEOF = false;
		while (!bAtEOF)
		{
			current_end_of_line = string_pos_ext("\n", seq_str, current_pos);
			if (current_end_of_line == 0)
			{
				current_end_of_line = string_length(seq_str);
			}
			if (current_pos >= current_end_of_line)
			{
				// We need to parse current buffer, then break.
				bAtEOF = true;
				continue;
			}
			
			var bNextKvIsObject = false;
			var bNextKvIsMarker = false;
			
			// Grab the current line.
			var current_line = string_copy(seq_str, current_pos, current_end_of_line - current_pos);
			
			// Now scan ahead until we no longer have whitespace.
			var current_lookahead_pos = current_end_of_line + 1;
			while (current_lookahead_pos <= string_length(seq_str)
				&& is_space(string_char_at(seq_str, current_lookahead_pos)))
			{
				current_lookahead_pos += 1;
			}
			// Check the lookahead value
			if (current_lookahead_pos <= string_length(seq_str))
			{
				var lookahead_character = string_char_at(seq_str, current_lookahead_pos);
				if (lookahead_character == "{")
				{
					// It's an object. We need to parse the current key-value as an object.
					bNextKvIsObject = true;
				}
			}
			
			// Parse the current line, removing extra space
			current_line = string_fix_whitespace(string_ltrim(string_rtrim(current_line)));
			if (string_char_at(current_line, 1) == "#")
			{
				bNextKvIsMarker = true;
			}
			
			// If it's both a marker and an object, we have a malformed file
			if (bNextKvIsMarker && bNextKvIsObject)
			{
				show_error("Malformed sequence file.", true);
			}
			
			// Split the key-value into key and value
			var current_kv_split = string_pos(" ", current_line);
			var current_key, current_value, bKvHasValue;
			bKvHasValue = current_kv_split != 0;
			if (bKvHasValue)
			{
				current_key = string_rtrim(string_copy(current_line, 1, current_kv_split));
				current_value = string_ltrim(string_copy(current_line, current_kv_split, string_length(current_line) - current_kv_split));
			}
			else
			{
				current_key = current_line;
				current_value = "";
			}
			
			// Move the cursor now
			current_pos = current_end_of_line + 1;
			
			// If the next item is an object, it's probably a node. Let's search for it in the instantiation listing.
			if (bNextKvIsObject)
			{
				var possible_type_name = string_lower(current_key);
				var new_node = null;
				for (var seqTypeIndex = 0; seqTypeIndex < array_length(global.sequenceTypes); ++seqTypeIndex)
				{
					var seqTypeInfo = global.sequenceTypes[seqTypeIndex];
					if (seqTypeInfo[0] == possible_type_name)
					{
						var type = seqTypeInfo[1];
						new_node = new type();
						
						// Fill in the common info for the node node
						new_node.type = possible_type_name;
					}
				}
				sqm_data_nodes[array_length(sqm_data_nodes)] = new_node; // We have a new node.
				
				// We need to go to the object now and fill in the node.
				//current_pos = SequenceLoadInObject(new_node, current_pos, seq_str);
			}
		}
	}
	// string_hex_to_integer
	
	// If the value is a object-less goto, then we add a redirector on the previous task
	
	// Create the main task and sic it on the first "maintask" node found.
	
	// Mark that we're loaded properly
	sqm_loaded = true;
}

function ASequenceTaskState() constructor
{
	currentNodeIndex = 0;
}

function SequenceInitializeLocal()
{
	sqm_loaded = false;
	sqm_tasks = []; // Array of all tasks running
	
	// Array of all markers.
	// Markers are [name, index into sqm_data_nodes]
	sqm_data_markers = []; 
	// Array of all nodes.
	// Nodes are instances of INode derived structs.
	sqm_data_nodes = [];
}

function SequenceUpdate()
{
	if (!sqm_loaded)
	{
		return false;
	}
	
	// Steps all the current tasks
	for (var taskIndex = 0; taskIndex < array_length(sqm_tasks); ++taskIndex)
	{
		var task = sqm_tasks[taskIndex];
		//task.Update();
	}
}