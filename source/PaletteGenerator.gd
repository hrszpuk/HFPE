extends Node

class_name PaletteGenerator

var number_of_total_palettes: int
var reference: Array
var count: Dictionary = {"goto_num": 0, "yoyo_num":0, "kero_num":0, "time_num":0, "darkgoto_num":0, "slime_num":0, "sword_num":0, "scythe_num":0}
var character_palettes: Dictionary = {"goto": [], "yoyo":[], "kero":[], "time":[], "darkgoto":[], "slime":[], "sword":[], "scythe":[]}
var characters = ["goto", "yoyo", "kero", "time", "darkgoto", "slime", "sword", "scythe"]


func import_data(data: Array):
	for item in data:
		match item["character"]:
			0: 
				count["goto_num"] += 1
				character_palettes["goto"].append(item["palette"])
			1: 
				count["yoyo_num"] += 1
				character_palettes["yoyo"].append(item["palette"])
			2: 
				count["kero_num"] += 1
				character_palettes["kero"].append(item["palette"])
			3: 
				count["time_num"] += 1
				character_palettes["time"].append(item["palette"])
			4: 
				count["darkgoto_num"] += 1
				character_palettes["darkgoto"].append(item["palette"])
			5: 
				count["slime_num"] += 1
				character_palettes["slime"].append(item["palette"])
			6: 
				count["sword_num"] += 1
				character_palettes["sword"].append(item["palette"])
			7: 
				count["scythe_num"] += 1
				character_palettes["scythe"].append(item["palette"])
			_: 
				count["goto_num"] += 1
				character_palettes["goto"].append(item["palette"])
	reference = data
	
	
func generate_option_section(config: ConfigFile) -> ConfigFile:
	config.set_value("options", "enabled", true)
	for num in count.keys():
		config.set_value("options", num, count[num])
	return config
	

func get_highest_count() -> Dictionary:
	var highest: int = 0
	var characte_r: String 
	for num in count.keys():
		if count[num] > highest:
			highest = count[num]
			characte_r = num.split()[0]
	return {character = characte_r, count = highest}
		

func generate_palette_sections(config: ConfigFile) -> ConfigFile:
	var total_iterations: int = 0
	for character in character_palettes.keys():
		var iterations: int = 0
		for array in character_palettes[character]:
			iterations += 1
			config.set_value("custom%d" % iterations, character, array)
		total_iterations = iterations
	
	# get the section keys for each sections and add any characters which are not in the sections
	for section in config.get_sections():
		if section != "options":
			var character_set: Array = characters
			for key in config.get_section_keys(section):
				characters.erase(key)
			for character in characters:
				config.set_value(section, character, global.pal[global.char_int_to_str_proper(char_str_to_int(character))])
		
	return config
				
func char_str_to_int(string: String) -> int:
	var index = 0
	for character in ["goto", "yoyo", "kero", "time", "darkgoto", "slime", "sword", "scythe"]:
		if string == character:
			return index
		index += 1
	return -1		
