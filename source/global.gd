extends Node

enum {
	NONE, 
	SAVE_PALETTE,
	EDITING_SESSION,
	EXPORT,
	IMPORT
}

var read_defualts: bool = false
var generate_defualts: bool = true
var start_character: int = 0
var default_path: String = "user://HFPE/"
var operating_system: String = OS.get_name()
var passing_index = null
var state = NONE
var palette_filename: String = "Untitled"
var imported_data = null

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

var palettes: Array = []

func save_to_config():
	var settings: ConfigFile = ConfigFile.new()
	settings.set_value("settings", "start_character", start_character)
	settings.set_value("settings", "defualt_palette_filename", palette_filename)
	settings.set_value("settings", "generate_defualts", generate_defualts)
	settings.set_value("settings", "read_defualts", read_defualts)
	settings.save(default_path+"/settings.cfg")

func _ready():
	var dir = Directory.new()
	dir.open("user://")
	dir.make_dir("HFPE")
	dir.make_dir("HFPE/palettes")
	var settings: ConfigFile = ConfigFile.new()
	if settings.load(default_path+"/settings.cfg") == OK:
		start_character = settings.get_value("settings", "start_character")
		palette_filename = settings.get_value("settings", "defualt_palette_filename")
		generate_defualts = settings.get_value("settings", "generate_defualts")
		read_defualts = settings.get_value("settings", "read_defualts")
	else:
		settings.set_value("settings", "start_character", start_character)
		settings.set_value("settings", "defualt_palette_filename", palette_filename)
		settings.set_value("settings", "generate_defualts", generate_defualts)
		settings.set_value("settings", "read_defualts", read_defualts)
		var err = settings.save(default_path+"/settings.cfg")
		print(err)
		
	

func save_palette():
	var config: ConfigFile = ConfigFile.new()
	config.set_value("Data", "palettes", palettes)
	var _err = config.save("user://%s.cfg" % palette_filename)
	
func load_palette():
	var config = ConfigFile.new()
	config.load("user://palette.cfg")
	palettes = config.get_value("Data", "palettes", null)

func generate_palette_config():
	var generator: PaletteGenerator = PaletteGenerator.new()
	generator.import_data(palettes)
	var config: ConfigFile = ConfigFile.new()
	config = generator.generate_option_section(config)
	config = generator.generate_palette_sections(config)
	return config
	
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
	
func char_int_to_str_proper(num: int) -> String:
	var string
	match (num):
		0: string = "Shoto_Goto"
		1: string = "Yo_Yona"
		2: string = "Dr_Kero"
		3: string = "Don_McRon"
		4: string = "Dark_Goto"
		5: string = "Slime_Bros"
		6: string = "Vince_Volt"
		7: string = "Reaper"
	return string
	
func find_char_in_palette(character):
	var values = []
	for palette in palettes:
		if char_int_to_str(palette["character"]) == character:
			values.append(palette)
	return values
	
	
func get_palette_nums() -> Dictionary:
	var output = {
		goto_num = 0, 
		yoyo_num = 0, 
		kero_num = 0, 
		time_num = 0, 
		sword_num = 0, 
		scythe_num = 0,
		darkgoto_num = 0,
		slime_num = 0
	}
	for palette in global.palettes:
		match palette["character"]:
			0: output["goto_num"] += 1
			1: output["yoyo_num"] += 1
			2: output["kero_num"] += 1
			3: output["time_num"] += 1
			4: output["darkgoto_num"] += 1
			5: output["slime_num"] += 1
			6: output["sword_num"] += 1
			7: output["scythe_num"] += 1
	return output
	
func load_config(data: String):
	var reader: PaletteReader = PaletteReader.new(data)
	palettes = reader.read_config()
	
	

#	for key in config_values.keys():
#		config_values[key] = config.get_value("options", key)
#	enabled = config.get_value("options", "enabled")

#	var new_palettes = []
#	for section in config.get_sections():
#		if section == "options":
#			continue
#		for data in get_data_from_section(config, section):
#			if not matches_default_character_set(data):
#				new_palettes.append(data)
#	palettes = new_palettes
	
func get_data_from_section(config: ConfigFile, section: String) -> Array:
	var output = []
	for key in config.get_section_keys(section):
		output.append(config.get_value(section, key))
	return output

func matches_default_character_set(data) -> bool:
	for value in pal:
		if value == data:
			return true
	return false
	
			
	
	
	
