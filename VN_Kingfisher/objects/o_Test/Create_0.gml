/// @description Tests

EngineInit();

// Need to somehow get the project folder
//show_message(working_directory);
//show_message(program_directory);
//show_message(temp_directory);
//show_message(parameter_string(2));

/*var build_filename = working_directory + "../build.bff";
if (file_exists(build_filename))
{
	//json_parse()
	var buf = buffer_load(build_filename);
	var buf_size = buffer_get_size(buf);
	var str = "";
	for (var byteIndex = 0; byteIndex < buf_size; ++byteIndex)
	{
		str += chr(buffer_read(buf, buffer_u8));
	}
	buffer_delete(buf);
	
	var json = json_parse(str);
	
	show_message(json.projectDir);
}*/

SequenceLoad("seq/test_v2.txt");

m_ready = true;