extends Control

onready var section_index = null
onready var selected_index = null
onready var SectionList = $SectionList
onready var PaletteList = $PaletteList
onready var Infographic = $PaletteInfographic
onready var Dialog = $PaletteDialog
onready var DialogSection = $PaletteDialog/Section

onready var data: Array = []

func _ready() -> void:
	Dialog.hide()
	setup_section_list()
	data = global.palette_data
	return
	

func setup_section_list() -> void:
	SectionList.clear()
	for i in range(global.section_count):
		SectionList.add_item("Section %d" % (i+1), null, true)	
	return


func _on_CancelButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/PaletteManager.tscn")
	return


func _on_SectionList_item_selected(index) -> void:
	PaletteList.clear()
	for item in global.palette_data:
		if item["section"] == index+1:
			var img := Image.new()
			img.load("res://Assets/ui/select/char/preview/%s.png" % item["character"])
			var texture := ImageTexture.new()
			texture.create_from_image(img)
			PaletteList.add_item("%s - %s" % [item["name"], item["character"]], texture, true)
	section_index = index
	return


func _on_PaletteList_item_selected(index) -> void:
	selected_index = index
	var text: String = PaletteList.get_item_text(index)
	var name: String = text.split(" - ")[0] # Gets item name
	var character: String = text.split(" - ")[1] # Gets item character
	Infographic.set_index(index)
	Infographic.set_name(name)
	Infographic.set_icon(character)
	for item in data:
		if item["section"] == section_index+1 and item["character"] == character:
			Infographic.set_color(str(item["palette"]))
			Infographic.set_section(item["section"])
			break
	return


func _on_MoveButton_pressed() -> void:
	if selected_index == null or section_index == null:
		return
	var text: String = PaletteList.get_item_text(selected_index)
	var name: String = text.split(" - ")[0] # Gets item name
	var character: String = text.split(" - ")[1] # Gets item character
	Dialog.setup_dialog_move(str(section_index+1), character, name)
	for i in SectionList.get_item_count():
		DialogSection.add_item(SectionList.get_item_text(i))
	Dialog.show()
	return
	

func _on_SwapButton_pressed() -> void:
	if selected_index == null or section_index == null:
		return
	var text: String = PaletteList.get_item_text(selected_index)
	var name: String = text.split(" - ")[0] # Gets item name
	var character: String = text.split(" - ")[1] # Gets item character
	Dialog.setup_dialog_swap(str(section_index+1), character, name)
	Dialog.show()
	return


func _on_PaletteDialog_CancelButton_pressed() -> void:
	Dialog.hide()
	DialogSection.clear()
	return


func _on_PaletteList_nothing_selected() -> void:
	selected_index = null
	return


func _on_SectionList_nothing_selected() -> void:
	section_index = null
	return


func _on_PaletteDialog_Section_item_selected(index) -> void:
	Dialog.update_info_label(str(index+1))
	return


func _on_PaletteDialog_OkayButton_pressed() -> void:
	for item in data:
		if item["section"] == int(global.section_cache) and item["character"] == global.character_cache:
			item["section"] = DialogSection.selected+1
			break
	Dialog.hide()
	setup_section_list()
	PaletteList.clear()
	for item in data:
		if item["section"] == section_index+1:
			var img := Image.new()
			img.load("res://Assets/ui/select/char/preview/%s.png" % item["character"])
			var texture := ImageTexture.new()
			texture.create_from_image(img)
			PaletteList.add_item("%s - %s" % [item["name"], item["character"]], texture, true)
	return


func _on_SaveButton_pressed() -> void:
	global.palette_data = data
	get_tree().change_scene("res://Scenes/PaletteManager.tscn")
	return
