extends Control

onready var filename_buffer: String = global.palette_filename
onready var generate_defualts_buffer: bool = global.generate_defualts
onready var read_defualts_buffer: bool = global.read_defualts

func _ready():
	$MainContainer/CharacterSelect.select(global.start_character)
	$MainContainer/GenerateDefualtPalettes.pressed = generate_defualts_buffer
	$MainContainer/ReadDefualtPalettes.pressed = read_defualts_buffer
	$MainContainer/FilenameInput.text = filename_buffer

func _on_BackButton_pressed():
	var _scene = get_tree().change_scene("res://Scenes/Main Menu.tscn")

func _on_SaveButton_pressed():
	global.palette_filename = filename_buffer
	global.start_character = $MainContainer/CharacterSelect.selected
	global.generate_defualts = generate_defualts_buffer
	global.read_defualts = read_defualts_buffer
	global.save_to_config()
	var _scene = get_tree().change_scene("res://Scenes/Main Menu.tscn")

func _on_FilenameInput_text_changed(new_text):
	filename_buffer = new_text

func _on_GenerateDefualtPalettes_toggled(button_pressed):
	generate_defualts_buffer = button_pressed

func _on_ReadDefualtPalettes_toggled(button_pressed):
	read_defualts_buffer = button_pressed
