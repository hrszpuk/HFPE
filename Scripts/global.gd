extends Node

# Palette data
var palette_data = []
var current_index = null
var section_count: int = 0
var default_palettes = {
	goto = [ "000000", "65b7d5", "2d4f7b", "912323", "551515", "191533", "05040d", "2f2116", "150e07", "b7b7b7", "848484", "bb9d87", "775338", "000001", "66b7d5", "2e4f7b", "d5ac65", "bb714f", "ffffff" ],
	yoyo = [ "cc6c40", "ae4b31", "94ead3", "58c2c8", "7baad5", "697abb", "ea94d3", "e079e6", "e0fff7", "eaca94", "d5a17b", "330f0f", "d5784e", "a65a46", "7caad5", "6a7abb" ],
	kero = [ "56bb27", "33621d", "d02a16", "cbd51e", "ffffff", "b3b3b3", "484848", "dce17b", "85d561", "ff82c4", "923870", "913870", "5c276f", "621f5e", "c8ea6b", "76a22d", "3c6f17" ],
	sword = [ "eaeaea", "c8c8c8", "0d0d0d", "000000", "043318", "021904", "f2ba7b", "ee9e64", "f23737", "bf1729", "9d9d9d", "c01729", "dddddd", "4d280d", "ccff94", "97c051" ],
	darkgoto = [ "130b26", "020508", "718471", "42513e", "2f2116", "150e07", "912323", "551515", "feffff", "b7b7b7", "848484", "111010", "000000", "ff0000", "d18ed4", "5e1c4d", "dd5151", "9d2973", "ffffff" ],
	slime = [ "fb84a8", "ee2462", "93b8ff", "5257dd", "ffa9cc", "0fe10f", "059505", "004417", "00e6f2", "007299", "c956ff", "a419b7", "8c8c8c" ],
	time = [ "c33929", "b32616", "594442", "402d2b", "ffd700", "fbe8b4", "eebd86", "262121", "ffc400", "b38506", "b70606", "f2f2f2" ],
	scythe = [ "ff95a0", "e16d90", "c46565", "8c3849", "214a55", "11232a", "3b3535", "1e1e1e", "fbeaea", "e1a5b1", "a2ddb4", "ffccdb", "f2dac2", "d4a483", "ee234c", "591d23", "191516" ],
}

# HFPE/config.cfg variables
onready var author_username = "Author Username"
onready var author_icon = "author_icon.png"
onready var author_description = "Author Description"

# File data
var palette_filename = "Untitled"

# Palette Editor states
enum {
	PALETTE_EDITOR_EDIT,
	PALETTE_EDITOR_NEW,
	NONE,
}
onready var state = NONE

# Background 
onready var start_character = "sword"
onready var start_stage = "sword"

# Hyperfight config.cfg & palette.cfg data
onready var config_config: ConfigFile
onready var palette_config: ConfigFile

# Library config data
onready var library_data: Dictionary

# Mod config data
onready var mod_data: Dictionary

# Palette Generator
var generate_defaults = true

func _ready() -> void:
	directory() # Create directories
	config() # Create/load HFPE/config.cfg
	data_config() # Create/load HFPE/data/config.cfg
	config_config = hf_config() # Create/cache and load config.cfg
	palette_config = hf_palette() # Create/cache and load palette.cfg
	return


func hf_config() -> ConfigFile:
	# Cache hyperfight config
	# Load hyperfight config
	var file: File = File.new()
	if file.file_exists("user://config.cfg"):
		file.open("user://config.cfg", File.READ)
		var content: String = file.get_as_text()
		file.close()
		file.open("user://HFPE/cache/config.cfg", File.WRITE)
		file.store_string(content)
		file.close()
	else:
		file.open("res://Resources/config.cfg", File.READ)
		var content: String = file.get_as_text()
		file.close()
		file.open("user://config.cfg", File.WRITE)
		file.store_string(content)
		file.close()
		file.open("user://HFPE/cache/config.cfg", File.WRITE)
		file.store_string(content)
		file.close()
	var config_file := ConfigFile.new()
	var _err = config_file.load("user://HFPE/cache/config.cfg")
	if _err != OK:
		var __err = config_file.load("user://config.cfg")
		if __err != OK:
			config_file.load("res://Resource/config.cfg")
	return config_file
	

func hf_palette() -> ConfigFile:
	# Cache hyperfight palette
	# Load hyperfight palette
	var file: File = File.new()
	if file.file_exists("user://palette.cfg"):
		var _err = file.open("user://palette.cfg", File.READ)
		var content: String = file.get_as_text()
		file.close()
		var __err = file.open("user://HFPE/cache/palette.cfg", File.WRITE)
		file.store_string(content)
		file.close()
	else:
		var _err = file.open("res://Resources/palette.cfg", File.READ)
		var content: String = file.get_as_text()
		file.close()
		var __err = file.open("user://palette.cfg", File.WRITE)
		file.store_string(content)
		file.close()
		var ___err = file.open("user://HFPE/cache/palette.cfg", File.WRITE)
		file.store_string(content)
		file.close()
	var palette_file := ConfigFile.new()
	var _err = palette_file.load("user://HFPE/cache/palette.cfg")
	if _err != OK:
		var __err = palette_file.load("user://palette.cfg")
		if __err != OK:
			palette_file.load("res://Resource/palette.cfg")
	return palette_file

	
func mods() -> void:
	# Scan mod directory
	# Load mod data into dictionary
	
	# Mod directory layout:
	# Hyperfight-mod-name
	#   | - Assets
	#      | - character.png
	#      | - another_character.png
	#   | - HFPE.cfg
	#	| - palette.cfg
	#	| - config.cfg
	
	for dir in get_directory_contents("user://mods/", true, false):
		mod_data[dir] = {}
		mod_data[dir]["HFPE"] = generate_dictionary_from_configfile_path("user://mods/%s/HFPE.cfg" % dir)
		mod_data[dir]["assets"] = []
	return
	
	
func library() -> void:
	# Scan directory
	# Load all *.cfg files
	library_data["files"] = get_directory_contents("user://HFPE/library/", false, true)
	return


func config() -> void:
	# Load or generate HFPE/config.cfg
	var file: File = File.new()
	if file.file_exists("user://HFPE/config.cfg"):
		# Loading config
		var config: ConfigFile = ConfigFile.new()
		config.load("user://HFPE/config.cfg")
		author_username = config.get_value("Author Settings", "author_username", author_username)
		author_description = config.get_value("Author Settings", "author_description", author_description)
		author_icon = config.get_value("Author Settings", "author_icon", author_icon)
		palette_filename = config.get_value("Librar Settings", "default_filename", palette_filename)
	else:
		# Generate config
		var config: ConfigFile = ConfigFile.new()
		config.set_value("Author Settings", "author_username", author_username)
		config.set_value("Author Settings", "author_description", author_description)
		config.set_value("Author Settings", "author_icon", author_icon)
		config.set_value("Library Settings", "default_filename", palette_filename)
		var err = config.save("user://HFPE/config.cfg")
	return


func data_config() -> void:
	# Load or generate HFPE/data/config.cfg
	var file: File = File.new()
	if file.file_exists("user://HFPE/data/config.cfg"):
		var config: ConfigFile = ConfigFile.new()
		config.load("user://HFPE/data/config.cfg")
	else:
		# Generate config
		var config: ConfigFile = ConfigFile.new()
		config.save("user://HFPE/data/config.cfg")
	return


func directory() -> void:
	# Creates custom directories (folders) for HFPE
	var dir: Directory = Directory.new()
	dir.open("user://")
	dir.make_dir("HFPE")
	dir.make_dir("HFPE/library")
	dir.make_dir("HFPE/data")
	dir.make_dir("HFPE/data/assets")
	dir.make_dir("mods")
	dir.make_dir("HFPE/cache")
	return
	

func int_to_character_code_name(integer: int) -> String:
	match(integer):
		0: return "goto"
		1: return "yoyo"
		2: return "kero"
		3: return "sword"
		4: return "darkgoto"
		5: return "time"
		6: return "slime"
		7: return "scythe"
		_: return "goto"
		
	
func get_directory_contents(path: String, include_directories: bool = false, include_files: bool = true) -> Array:
	var files: Array = []
	var root: Directory = Directory.new()
	root.open(path)
	var _err = root.list_dir_begin(true, false)
	if _err != OK:
		return [null]
	var file = root.get_next()
	while(file != ""):
		if not root.current_is_dir() and include_files:
			files.append(file)
		elif include_directories:
			files.append(file)
		file = root.get_next()
	return files
	
	
func generate_dictionary_from_configfile_path(path: String) -> Dictionary:
	var config: ConfigFile = ConfigFile.new()
	var _err = config.load(path)
	if _err != OK:
		return {"_err": _err}
	return generate_dictionary_from_configfile(config)
	

func generate_dictionary_from_configfile(config: ConfigFile) -> Dictionary:
	var dict: Dictionary = {}
	# Read config
	# Read sections 
	# Read keys
	# return
	return dict
	

func set_palette_sections() -> void:
	var count = {
		"goto": 0,
		"yoyo": 0,
		"kero": 0,
		"sword": 0,
		"darkgoto": 0,
		"time": 0,
		"slime": 0,
		"scythe": 0
	}
	
	for item in global.palette_data:
		for character in count.keys():
			if item["character"] == character:
				count[character] += 1
				item["section"] = count[character]
				
	var temp: int = 0
	for character in count.keys():
		if count[character] > temp:
			temp = count[character]
	section_count = temp
	return
	
