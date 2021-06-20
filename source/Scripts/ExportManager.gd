extends Control

func _ready():
	get_info_content()

func _on_BackButton_pressed():
	var _scene = get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")

func _on_Enabled_toggled(button_pressed):
	global.enabled = button_pressed
	
func get_info_content():
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
	var config = global.generate_palette_config()
	var err: int
	if global.save_to_path:
		err = config.save(global.imported_data["path"])
		OS.shell_open(str("file://", global.imported_data["path"]))
	else:
		err = config.save(global.default_path+"/palettes/"+global.palette_filename+".cfg")
		OS.shell_open(str("file://", global.default_path+"/palettes/"+global.palette_filename+".cfg"))
	if err != OK:
		print(err)
	global.state = global.EXPORT
	var _scene = get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")
