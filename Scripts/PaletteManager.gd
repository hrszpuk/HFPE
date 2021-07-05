extends Control

onready var NewButton = $NewButton
onready var CharacterList = $ItemList
onready var NameInput = $NameInput
onready var Infographic = $CurrentPaletteInfo


func _ready() -> void:
	NameInput.text = global.palette_filename
	$Background.set_stage("sword") # Stage: sword (Vince's stage)
	var i: int = 0
	for palette in global.palette_data:
		var img := Image.new()
		img.load("res://Assets/ui/select/char/preview/%s.png" % palette["character"])
		
		var icon := ImageTexture.new()
		icon.create_from_image(img)
		CharacterList.add_item(global.palette_data[i]["name"], icon, true)
		i += 1
	global.set_palette_sections()
	return


func update_infographic() -> void:
	var string: String = "Index: %d, Section: %d\n" % [global.current_index, global.palette_data[global.current_index]["section"]]
	string += "Character: %s,\n" % global.palette_data[global.current_index]["character"]
	string += "Color: %s" % str(global.palette_data[global.current_index]["palette"])
	Infographic.text = string
	return


func _on_DeleteButton_pressed() -> void:
	if global.current_index != null:
		CharacterList.remove_item(global.current_index)
		global.palette_data.remove(global.current_index)
		global.current_index = null
		$Background.reset_character()
		$Background.clear_character_shader(global.start_character)
	return
	

func _on_ItemList_item_selected(index) -> void:
	global.current_index = index
	var character = global.palette_data[global.current_index]["character"]
	$Background.set_character(character)
	var i: int = 0
	for item in global.palette_data[global.current_index]["palette"]:
		$Background.reset_character_shader_param(i, Color(str(global.default_palettes[character][i])))
		$Background.set_character_shader_param(i, Color(str(item)))
		i += 1
	update_infographic()
	return
	

func _on_ItemList_nothing_selected() -> void:
	global.current_index = null
	$Background.reset_character()
	$Background.clear_character_shader(global.start_character)
	return
	

func _on_EditButton_pressed() -> void:
	if global.current_index != null:
		global.state = global.PALETTE_EDITOR_EDIT
		var err = get_tree().change_scene("res://Scenes/PaletteEditor.tscn")
	return
	

func _on_NameInput_text_changed() -> void:
	global.palette_filename = NameInput.text
	return
	
	
func _on_NewButton_pressed() -> void:
	global.state = global.PALETTE_EDITOR_NEW
	var err = get_tree().change_scene("res://Scenes/PaletteEditor.tscn")
	return
	

func _on_CancelButton_pressed() -> void:
	var _err = get_tree().change_scene("res://Scenes/Menu.tscn")
	return


func _on_OrganiseButton_pressed() -> void:
	var _err = get_tree().change_scene("res://Scenes/PaletteOrganiser.tscn")
	return


func _on_SaveButton_pressed() -> void:
	var generator := PaletteGenerator.new()
	generator.import_data(global.palette_data)
	var config := ConfigFile.new()
	config = generator.generate_option_section(config)
	config = generator.generate_palette_sections(config)
	config.save("user://HFPE/library/%s.cfg" % global.palette_filename)
	get_tree().change_scene("res://Scenes/Menu.tscn")
	return
