extends Node

class_name PaletteReader
var config: ConfigFile

func _init(path: String):
	config = ConfigFile.new()
	print("C:" + path)
	var err = config.load("C:" + path)
	if err != OK:
		print("SHIT")

func read_config() -> Array:
	# for each section: read character and palette, check if palette is default, add name, add to array
	var data: Array = []
	if config.has_section("options"):
		for key in config.get_section_keys("options"):
			global.config_values[key] = config.get_value("options", key)
		config.erase_section("options")
	
	for section in config.get_sections():
		for key in config.get_section_keys(section):
			var character_palette = {
				name = "Unnamed",
				character = char_str_to_int(key),
				palette = config.get_value(section, key)
			}
			data.append(character_palette)
	global.state = global.IMPORT
	return data
	
func char_str_to_int(string: String) -> int:
	var index = 0
	for character in ["goto", "yoyo", "kero", "time", "darkgoto", "slime", "sword", "scythe"]:
		if string == character:
			return index
		index += 1
	return -1
		
