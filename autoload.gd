extends Node

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
		config.load("HFPE/config.cfg")
		config.get_value("Author Settings", "author_username", global.author_username)
		config.get_value("Author Settings", "author_description", global.author_description)
		config.get_value("Author Settings", "author_icon", global.author_icon)
	else:
		# Generate config
		var config: ConfigFile = ConfigFile.new()
		config.set_value("Author Settings", "author_username", global.author_username)
		config.set_value("Author Settings", "author_description", global.author_description)
		config.set_value("Author Settings", "author_icon", global.author_icon)
		config.save("HFPE/config.cfg")


func data_config():
	var file: File = File.new()
	if file.file_exists("user://HFPE/data/config.cfg"):
		var config: ConfigFile = ConfigFile.new()
		config.load("HFPE/data/config.cfg")
	else:
		# Generate config
		var config: ConfigFile = ConfigFile.new()
		config.save("HFPE/data/config.cfg")


func directory():
	var dir: Directory = Directory.new()
	dir.open("user://")
	dir.make_dir("HFPE")
	dir.make_dir("HFPE/library")
	dir.make_dir("HFPE/data")
	dir.make_dir("HFPE/data/assets")
	dir.make_dir("mods")
