extends Control

onready var ColorPickerBackground = $ColorPickerBackground
onready var ColorPicker = $ColorPicker
onready var CharacterSelect = $CharacterSelect
onready var ColorList = $ColorList

var current_color_index = null

func _ready() -> void:
	# check if new if so:
	# set character to goto
	# set item options to default goto
	# if not:
	# set character to character at current index
	# set item options to palette at current index
	# render shaders
	# All:
	# setup color picker
	var i: int = 0
	if global.state == global.PALETTE_EDITOR_NEW:
		$Background.set_character("goto")
		for item in global.default_palettes.goto:
			ColorList.add_item(item, null, true)
			$Background.reset_character_shader_param(i, Color(item))
			$Background.set_character_shader_param(i, Color(item))
			i += 1
	elif global.state == global.PALETTE_EDITOR_EDIT:
		$background.set_character(global.palette_data[global.current_index]["name"])
		for item in global.palette_data[global.current_index]["palette"]:
			ColorList.add_item(item, null, true)
			$Background.reset_character_shader_param(i, Color(global.default_palettes.goto[i]))
			$Background.set_character_shader_param(i, Color(item))
			i += 1
		# Render shaders
		
		
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
	

func _on_CancelButton_pressed():
	get_tree().change_scene("res://Scenes/PaletteManager.tscn")
	

func _on_ColorPicker_color_changed(color):
	if current_color_index != null:
		ColorList.set_item_text(current_color_index, Color(color).to_html(false))
		$Background.set_character_shader_param(current_color_index, Color(color))
	

func _on_StageSelect_item_selected(index):
	pass


func _on_ColorList_item_selected(index):
	current_color_index = index
	ColorPicker.color = Color(ColorList.get_item_text(index))


func _on_RandomButton_pressed():
	if current_color_index != null:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var color = Color(rng.randf_range(0.0, 1.0), rng.randf_range(0.0, 1.0), rng.randf_range(0.0, 1.0))
		ColorList.set_item_text(current_color_index, color.to_html(false))
		ColorPicker.color = color
		$Background.set_character_shader_param(current_color_index, Color(color))
	

func _on_InvertButton_pressed():
	if current_color_index != null:
		var color = Color(ColorList.get_item_text(current_color_index)).inverted()
		ColorPicker.color = color
		$Background.set_character_shader_param(current_color_index, Color(color))
		ColorList.set_item_text(current_color_index, color.to_html(false))
	
	
	
