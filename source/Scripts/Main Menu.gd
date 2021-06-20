extends Control

onready var dialog = $FileDialog

var file_path: String = ""

func logger(string: String) -> void:
	global.logger.set_prefix("MainMenu")
	global.logger.write(string)

func _on_CreateFileButton_pressed():
	logger("CreateFileButton pressed")
	global.logger.flush()
	var _scene = get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")

func _ready():
	logger("Ready!")
	dialog.dialog_hide_on_ok = true

func _on_ImportFileButton_pressed():
	logger("ImportFileButton pressed")
	dialog.window_title = "Import a palette file"
	dialog.popup()


func _on_FileDialog_confirmed():
	logger("FileDialog confirmed")
	var data = {
		filename = file_path,
		path = dialog.get_current_path()
	}
	global.imported_data = data
	global.palette_filename = data.filename
	logger("Setting global data")
	global.load_config(data.path)
	global.logger.flush()
	var _scene = get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")

func _on_FileDialog_file_selected(path):
	file_path = path

func _on_SettingsButton_pressed():
	logger("SettingsButton pressed")
	global.logger.flush()
	var _scene = get_tree().change_scene("res://Scenes/SettingsMenu.tscn")
