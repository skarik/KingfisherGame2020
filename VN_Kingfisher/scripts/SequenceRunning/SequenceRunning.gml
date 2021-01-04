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
				current_value = string_ltrim(string_copy(current_line, current_kv_split + 1, string_length(current_line) - current_kv_split));
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
				if (new_node == null || !is_struct(new_node))
				{
					show_error("Unknown object type \"" + possible_type_name + "\"", true);
				}
				
				sqm_data_nodes[array_length(sqm_data_nodes)] = new_node; // We have a new node.
				
				// We need to go to the object now and fill in the node.
				current_pos = current_lookahead_pos + 1;
				current_pos = Sequence_InternalLoadInObject(new_node, current_pos, seq_str);
			}
			else if (bNextKvIsMarker)
			{
				// Save the marker into the list of markers
				sqm_data_markers[array_length(sqm_data_markers)] = [
					current_key,
					array_length(sqm_data_nodes)
					];
			}
			else
			{
				// Is a hanging K-V. Check types
				var key_lower = string_lower(current_key);
				if (string_length(key_lower) <= 0)
				{
					// Nothing to do with empty keys.
				}
				else if (key_lower == "goto")
				{
					// For now, in the previously read node, set next to the string label. We'll fix those up in another step
					sqm_data_nodes[array_length(sqm_data_nodes) - 1].next = current_value;
				}
				else
				{
					show_error("Unrecognized key \"" + current_key + "\" in line.\n", true);
				}
			}
		}
	}
	
	// Fix up the names of all the markers
	{
		for (var markerIndex = 0; markerIndex < array_length(sqm_data_markers); ++markerIndex)
		{
			var markerName = sqm_data_markers[markerIndex][0];
			if (string_char_at(markerName, 1) == "#")
			{
				markerName = string_copy(markerName, 2, string_length(markerName) - 1);
			}
			sqm_data_markers[markerIndex][0] = markerName;
		}
	}
	// Go through all the nodes for post-load actions
	{
		for (var nodeIndex = 0; nodeIndex < array_length(sqm_data_nodes); ++nodeIndex)
		{
			var node = sqm_data_nodes[nodeIndex];
			// Have an invalid "next" index? Fix up the non-integer "next" values.
			if (is_string(node.next))
			{
				// Find the matching marker.
				for (var markerIndex = 0; markerIndex < array_length(sqm_data_markers); ++markerIndex)
				{
					if (sqm_data_markers[markerIndex][0] == node.next)
					{
						var nextNodeIndex = sqm_data_markers[markerIndex][1];
						if (nextNodeIndex < array_length(sqm_data_nodes))
						{
							node.next = sqm_data_nodes[nextNodeIndex].guid;
						}
						else
						{
							node.next = 0xFFFFFFFF;
						}
						break;
					}
				}
			}
			// Call OnLoad now.
			node.OnLoad();
		}
	}
	
	// Create the main task and sic it on the first task node found.
	{
		var task = new ASequenceTaskState(this);
		for (var nodeIndex = 0; nodeIndex < array_length(sqm_data_nodes); ++nodeIndex)
		{
			if (sqm_data_nodes[nodeIndex].IsTaskStart())
			{
				task.currentNodeIndex = nodeIndex;
				break;
			}
		}
		
		sqm_tasks[array_length(sqm_tasks)] = task;
	}
	
	// Mark that we're loaded properly
	sqm_loaded = true;
}
function Sequence_InternalLoadInObject(nodeStruct, current_pos, seq_str)
{
	var current_end_of_line;
	var bEndOfObject = false;
	
	while (!bEndOfObject)
	{
		current_end_of_line = string_pos_ext("\n", seq_str, current_pos);
		if (current_end_of_line == 0)
		{
			current_end_of_line = string_length(seq_str);
		}
		if (current_pos >= current_end_of_line)
		{
			show_error("Hit EoF before end of object.\n", true);
			current_pos = current_end_of_line;
			break;
		}
		
		var bNextKvIsLastKv = false;
		var bNextKvIsObject = false;
		
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
			else if (lookahead_character == "}")
			{
				bNextKvIsLastKv = true;
			}
		}
		
		// Parse the current line, removing extra space
		current_line = string_fix_whitespace(string_ltrim(string_rtrim(current_line)));
		
		// Split the key-value into key and value
		var current_kv_split = string_pos(" ", current_line);
		var current_key, current_value, bKvHasValue;
		bKvHasValue = current_kv_split != 0;
		if (bKvHasValue)
		{
			current_key = string_rtrim(string_copy(current_line, 1, current_kv_split));
			current_value = string_ltrim(string_copy(current_line, current_kv_split + 1, string_length(current_line) - current_kv_split));
		}
		else
		{
			current_key = current_line;
			current_value = "";
		}
			
		// Move the cursor now
		current_pos = current_end_of_line + 1;
		
		// Apply new data
		if (bNextKvIsObject)
		{
			var new_object = {};
			current_pos = current_lookahead_pos + 1;
			current_pos = Sequence_InternalLoadInObject(new_object, current_pos, seq_str);
			variable_struct_set(nodeStruct, current_key, new_object);
		}
		else
		{
			// Do specific variable conversions:
			if (current_key == "guid")
			{
				nodeStruct.guid = string_hex_to_integer(current_value);
			}
			// Fallback to normal set
			else if (string_length(current_key) > 0)
			{
				variable_struct_set(nodeStruct, current_key, current_value);
			}
		}
		
		// If we're the last KV, plan to break
		if (bNextKvIsLastKv)
		{
			// Go past the lookahead character.
			current_pos = current_lookahead_pos + 1;
			// Quit out of object
			bEndOfObject = true;
		}
	}
	
	return current_pos;
}

function ASequenceTaskState(inSequencer) constructor
{
	sequencer = inSequencer;
	currentNodeIndex = 0;
	bRunning = true;
	
	static Update = function()
	{
		var node_count = array_length(sequencer.sqm_data_nodes);
		if (currentNodeIndex < node_count)
		{
			var node = sequencer.sqm_data_nodes[currentNodeIndex];
			node.OnFrame();
			
			// If the node is done, we need to go forward
			if (node.IsDone())
			{
				if (node.next == 0x00000000)
				{	// Go to next node if nothing specified
					currentNodeIndex++;
				}
				else if (node.next = 0xFFFFFFFF)
				{	// Seek to the end now.
					currentNodeIndex = node_count; 
				}
				else
				{
					// By default, go to the ending node
					currentNodeIndex = node_count;
					// Find the node with matching guid and seek to it.
					for (var nodeIndex = 0; nodeIndex < array_length(sequencer.sqm_data_nodes); ++nodeIndex)
					{
						if (sequencer.sqm_data_nodes[nodeIndex].guid == node.next)
						{
							currentNodeIndex = nodeIndex;
							break;
						}
					}
				}
			}
			
			// End node logic
		}
		// At the end, we're done.
		else
		{
			bRunning = false;
		}
	}
	
	static IsDone = function()
	{
		return !bRunning;
	}
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

/// @function SequenceUpdate()
/// @desc Runs the sequence system.
/// @returns Boolean. True when working, false when completely stopped.
function SequenceUpdate()
{
	if (!sqm_loaded)
	{	// Not working.
		return false;
	}
	
	// Steps all the current tasks
	for (var taskIndex = 0; taskIndex < array_length(sqm_tasks); ++taskIndex)
	{
		var task = sqm_tasks[taskIndex];
		task.Update();
	}
	
	// Check if all are done.
	for (var taskIndex = 0; taskIndex < array_length(sqm_tasks); ++taskIndex)
	{
		var task = sqm_tasks[taskIndex];
		if (!task.IsDone())
		{	// Still working, return true.
			return true;
		}
	}
	return false;
}