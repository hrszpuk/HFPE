extends Node

# Palette data
var palette_data = []
var current_index = null

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


func _ready():
	directory()
	config()
	data_config()


# Autoloads the library, general settings, and the palette.cfg and config.cfg

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
	
