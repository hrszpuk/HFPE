extends Control

onready var ColorPickerBackground = $ColorPickerBackground
onready var ColorPicker = $ColorPicker
onready var CharacterSelect = $CharacterSelect

func _ready() -> void:
	$Background.set_character("goto")
	setup_color_picker()
	return
	
	
func setup_color_picker() -> void:
	for i in range(5):
		$ColorPicker.get_child(i+3).hide() # Hides everything under the color selector
	var size = Vector2(ColorPickerBackground.rect_size.x-20, ColorPickerBackground.rect_size.y-20)
	ColorPicker.set_size(size)
	var position = Vector2(ColorPickerBackground.rect_position.x+10, ColorPickerBackground.rect_position.y+10)
	ColorPicker.rect_position = position
	return
	
	
