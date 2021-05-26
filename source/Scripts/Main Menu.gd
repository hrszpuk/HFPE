extends Control

onready var dialog = $FileDialog

var path = "%APPDATA%/HYPERFIGHT/"
var path2 = "%USERPROFILE%/AppData/Roaming/Godot/app_userdata/Hyperfight Palette Editor"

func _on_CreateFileButton_pressed():
	var _scene = get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")


func _ready():
	dialog.dialog_hide_on_ok = true


func _on_EditCurrentFileButton_pressed():
	dialog.window_title = "Edit current palette file"
	if global.imported_data.path == null:
		dialog.set_current_dir(path)
		dialog.popup()


func _on_ImportFileButton_pressed():
	dialog.window_title = "Import a palette file"
	dialog.set_current_dir(path2)
	dialog.popup()


func _on_FileDialog_confirmed():
	var data = {
		filename = dialog.get_current_file(),
		path = dialog.get_current_path()
	}
	print(dialog.get_current_dir())
	print(dialog.get_current_path())
	global.imported_data = data
	global.load_config(data.path)
	get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")
