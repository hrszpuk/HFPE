extends Node

enum {
	NONE, 
	SAVE_PALETTE,
	EDITING_SESSION,
	EXPORT
}

var passing_index = null
var state = NONE
var palette_filename = "Untitled"

# Palette config generation:
var config_values = {
	goto_num = 0,
	yoyo_num = 0,
	kero_num = 0,
	sword_num = 0,
	darkgoto_num = 0,
	slime_num = 0,
	time_num = 0,
	scythe_num = 0,
}
var enabled = true

# Palette
var pal = {
	Shoto_Goto = [ "000000", "65b7d5", "2d4f7b", "912323", "551515", "191533", "05040d", "2f2116", "150e07", "b7b7b7", "848484", "bb9d87", "775338", "000001", "66b7d5", "2e4f7b", "d5ac65", "bb714f", "ffffff" ],
	Yo_Yona = [ "cc6c40", "ae4b31", "94ead3", "58c2c8", "7baad5", "697abb", "ea94d3", "e079e6", "e0fff7", "eaca94", "d5a17b", "330f0f", "d5784e", "a65a46", "7caad5", "6a7abb" ],
	Dr_Kero = [ "56bb27", "33621d", "d02a16", "cbd51e", "ffffff", "b3b3b3", "484848", "dce17b", "85d561", "ff82c4", "923870", "913870", "5c276f", "621f5e", "c8ea6b", "76a22d", "3c6f17" ],
	Vince_Volt = [ "eaeaea", "c8c8c8", "0d0d0d", "000000", "043318", "021904", "f2ba7b", "ee9e64", "f23737", "bf1729", "9d9d9d", "c01729", "dddddd", "4d280d", "ccff94", "97c051" ],
	Dark_Goto = [ "130b26", "020508", "718471", "42513e", "2f2116", "150e07", "912323", "551515", "feffff", "b7b7b7", "848484", "111010", "000000", "ff0000", "d18ed4", "5e1c4d", "dd5151", "9d2973", "ffffff" ],
	Slime_Bros = [ "fb84a8", "ee2462", "93b8ff", "5257dd", "ffa9cc", "0fe10f", "059505", "004417", "00e6f2", "007299", "c956ff", "a419b7", "8c8c8c" ],
	Don_McRon = [ "c33929", "b32616", "594442", "402d2b", "ffd700", "fbe8b4", "eebd86", "262121", "ffc400", "b38506", "b70606", "f2f2f2" ],
	Reaper = [ "ff95a0", "e16d90", "c46565", "8c3849", "214a55", "11232a", "3b3535", "1e1e1e", "fbeaea", "e1a5b1", "a2ddb4", "ffccdb", "f2dac2", "d4a483", "ee234c", "591d23", "191516" ],
}

var palettes = []

func save_palette():
	var config = ConfigFile.new()
	config.set_value("Data", "palettes", palettes)
	var _err = config.save("user://%s.cfg" % palette_filename)
	

func load_palette():
	var config = ConfigFile.new()
	config.load("user://palette.cfg")
	palettes = config.get_value("Data", "palettes", null)

func generate_palette_config():
	var config = ConfigFile.new()
	
	var highest_character_count = {character = "null", count = 0}
	for key in config_values.keys():
		config.add_value("options", str(key), config_values[str(key)])
		if config_values[str(key)] > highest_character_count["count"]:
			highest_character_count["count"] = config_values[str(key)]
			highest_character_count["character"] = str(key)
	config.add_value("options", "enabled", enabled)
	
	for i in range(highest_character_count["count"]):
		config.add_value("custom%d" % i, highest_character_count["character"].replace("_num", ""))
	
	for palette in palettes:
		for i in range(highest_character_count["count"]):
			if not config.has_section_key("custom%d" % i, char_int_to_str(palette["character"])):
				config.add_value("custom%d" % i, char_int_to_str(palette["character"]), palette["palette"])
	
	# for section in section: if character not in section, add default character to section
	# return config
			
func char_int_to_str(num: int):
	var string
	match (num):
		0: string = "goto"
		1: string = "yoyo"
		2: string = "kero"
		3: string = "time"
		4: string = "darkgoto"
		5: string = "slime"
		6: string = "sword"
		7: string = "scythe"
	return string
	
	
	
	
	
