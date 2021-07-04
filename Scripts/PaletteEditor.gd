extends Control

onready var ColorPickerBackground = $ColorPickerBackground
onready var ColorPicker = $ColorPicker
onready var CharacterSelect = $CharacterSelect
onready var ColorList = $ColorList

var current_color_index = null

func _ready() -> void:
	$Background.set_stage(0)
	var i: int = 0
	if global.state == global.PALETTE_EDITOR_NEW:
		$Background.set_character("goto")
		for item in global.default_palettes.goto:
			ColorList.add_item(item, null, true)
			$Background.reset_character_shader_param(i, Color(item))
			$Background.set_character_shader_param(i, Color(item))
			i += 1
	elif global.state == global.PALETTE_EDITOR_EDIT:
		$Background.set_character(global.palette_data[global.current_index]["character"])
		for item in global.palette_data[global.current_index]["palette"]:
			ColorList.add_item(str(item), null, true)
			$Background.reset_character_shader_param(i, Color(global.default_palettes[global.palette_data[global.current_index]["character"]][i]))
			$Background.set_character_shader_param(i, Color(str(item)))
			i += 1
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
	

func _on_CancelButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/PaletteManager.tscn")
	return
	

func _on_ColorPicker_color_changed(color) -> void:
	if current_color_index != null:
		ColorList.set_item_text(current_color_index, Color(color).to_html(false))
		$Background.set_character_shader_param(current_color_index, Color(color))
	return
	

func _on_StageSelect_item_selected(index) -> void:
	$Background.set_stage(index)
	return


func _on_ColorList_item_selected(index) -> void:
	current_color_index = index
	ColorPicker.color = Color(ColorList.get_item_text(index))
	return 
	

func _on_RandomButton_pressed() -> void:
	if current_color_index != null:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var color = Color(rng.randf_range(0.0, 1.0), rng.randf_range(0.0, 1.0), rng.randf_range(0.0, 1.0))
		ColorList.set_item_text(current_color_index, color.to_html(false))
		ColorPicker.color = color
		$Background.set_character_shader_param(current_color_index, Color(color))
	return
	

func _on_InvertButton_pressed() -> void:
	if current_color_index != null:
		var color = Color(ColorList.get_item_text(current_color_index)).inverted()
		ColorPicker.color = color
		$Background.set_character_shader_param(current_color_index, Color(color))
		ColorList.set_item_text(current_color_index, color.to_html(false))
	return
	

func _on_SaveButton_pressed() -> void:
	var palette: Array = []
	for i in range(ColorList.get_item_count()):
		palette.append(ColorList.get_item_text(i))
	if global.state == global.PALETTE_EDITOR_NEW:
		var new_palette = {
			"character": global.int_to_character_code_name(CharacterSelect.selected),
			"character_int": CharacterSelect.selected,
			"palette": palette,
			"name": "Default"
		}
		global.palette_data.append(new_palette)
	elif global.state == global.PALETTE_EDITOR_EDIT:
		global.palette_data[global.current_index]["palette"] = palette
	global.state = global.NONE
	get_tree().change_scene("res://Scenes/PaletteManager.tscn")
	return
	

func _on_CharacterSelect_item_selected(index):
	$Background.set_character(global.int_to_character_code_name(index))
	ColorList.clear()
	var i: int = 0
	for item in global.default_palettes[global.int_to_character_code_name(index)]:
		ColorList.add_item(item, null, true)
		$Background.reset_character_shader_param(i, Color(item))
		$Background.set_character_shader_param(i, Color(item))
		i += 1
