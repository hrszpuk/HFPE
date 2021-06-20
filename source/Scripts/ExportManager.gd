extends Control

func _ready():
	logger("Ready!")
	get_info_content()

func _on_BackButton_pressed():
	logger("BackButton pressed")
	var _scene = get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")

func _on_Enabled_toggled(button_pressed):
	logger("Enabled toggled")
	global.enabled = button_pressed
	
func get_info_content():
	logger("Calling get_info_content()")
	$TInfo.text = "Total number of Palettes: %d\n" % len(global.palettes)
	for i in range(7):
		var string
		match (i):
			0: string = "Shoto Goto"
			1: string = "Yo Yona"
			2: string = "Dr Kero"
			3: string = "Don McRon"
			4: string = "Dark Goto"
			5: string = "Slime Bros"
			6: string = "Vince Volt"
			7: string = "Reaper Angel"
		$TInfo.text += "Number of %s Palettes: %d\n" % [string, global.config_values[global.char_int_to_str(i) + "_num"]]


func _on_ExportButton_pressed():
	logger("ExportButton pressed")
	var config = global.generate_palette_config()
	var err: int
	if global.save_to_path:
		err = config.save(global.imported_data["path"])
		OS.shell_open(str("file://", global.imported_data["path"]))
		logger("Saved config (imported_data)")
	else:
		err = config.save(global.default_path+"/palettes/"+global.palette_filename+".cfg")
		OS.shell_open(str("file://", global.default_path+"/palettes/"+global.palette_filename+".cfg"))
		logger("Saved config (default_path)")
	if err != OK:
		print(err)
	global.state = global.EXPORT
	global.logger.flush()
	var _scene = get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")
	
func logger(string: String) -> void:
	global.logger.set_prefix("ExportManager")
	global.logger.write(string)
