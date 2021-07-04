extends Control

onready var NewButton = $NewButton
onready var CharacterList = $ItemList
onready var NameInput = $NameInput
onready var Infographic = $CurrentPaletteInfo


func _ready() -> void:
	NameInput.text = global.palette_filename
	$Background.reset_character()
	$Background.set_stage(3) # Stage: sword (Vince's stage)
	var i: int = 0
	for palette in global.palette_data:
		var img := Image.new()
		img.load("res://Assets/ui/select/char/portrait/%s.png" % palette["character"])
		var icon := ImageTexture.new()
		icon.create_from_image(img)
		CharacterList.add_item(global.palette_data[i]["name"], icon, true)
		i += 1
	return


func update_infographic() -> void:
	Infographic.text = "Index: %d" % global.current_index
	return


func _on_DeleteButton_pressed() -> void:
	if global.current_index != null:
		CharacterList.remove_item(global.current_index)
		global.palette_data.remove(global.current_index)
		global.current_index = null
	return
	

func _on_ItemList_item_selected(index) -> void:
	global.current_index = index
	update_infographic()
	return
	

func _on_ItemList_nothing_selected() -> void:
	global.current_index = null
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
