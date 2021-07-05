extends Control

onready var section_index: int
onready var selected_index: int
onready var SectionList = $SectionList
onready var PaletteList = $PaletteList

onready var data: Array = []

func _ready() -> void:
	setup_section_list()
	data = global.palette_data
	return
	

func setup_section_list() -> void:
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
			PaletteList.add_item(item["name"], texture, true)
	section_index = index
	return


func _on_PaletteList_item_selected(index):
	selected_index = index


func _on_SelectButton_pressed():
	if section_index != null and selected_index != null:
		
		pass
