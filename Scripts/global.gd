extends Node

# Palette data
var palette_data = []
var current_index = null
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

# config.cfg variables
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


func _ready():
	directory()
	config()
	data_config()


func hf_config():
	# Load hyperfight config
	pass
	

func hf_palette():
	# Load hyperfight palette
	pass

	
func mods():
	# Scan mod directory
	# Scan sub directories
	# Load palette and config files
	pass 

	
func library():
	# Scan directory
	# Load all *.cfg files
	pass


func config():
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


func data_config():
	var file: File = File.new()
	if file.file_exists("user://HFPE/data/config.cfg"):
		var config: ConfigFile = ConfigFile.new()
		config.load("user://HFPE/data/config.cfg")
	else:
		# Generate config
		var config: ConfigFile = ConfigFile.new()
		config.save("user://HFPE/data/config.cfg")


func directory():
	var dir: Directory = Directory.new()
	dir.open("user://")
	dir.make_dir("HFPE")
	dir.make_dir("HFPE/library")
	dir.make_dir("HFPE/data")
	dir.make_dir("HFPE/data/assets")
	dir.make_dir("mods")
	
