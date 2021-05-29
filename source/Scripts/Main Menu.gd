extends Control

onready var dialog = $FileDialog

var file_path: String = ""

func _on_CreateFileButton_pressed():
	var _scene = get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")

func _ready():
	dialog.dialog_hide_on_ok = true

func _on_ImportFileButton_pressed():
	dialog.window_title = "Import a palette file"
	dialog.popup()


func _on_FileDialog_confirmed():
	var data = {
		filename = file_path,
		path = dialog.get_current_path()
	}
	global.imported_data = data
	global.palette_filename = data.filename
	global.load_config(data.path)
	var _scene = get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")

func _on_FileDialog_file_selected(path):
	file_path = path

func _on_SettingsButton_pressed():
	var _scene = get_tree().change_scene("res://Scenes/SettingsMenu.tscn")
