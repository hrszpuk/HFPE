extends Control

onready var NewButton = $NewButton
onready var ItemList = $ItemList
onready var NameInput = $NameInput
onready var Infographic = $CurrentPaletteInfo


func _ready():
	NameInput.text = global.palette_filename
	$Background.reset_character()
	
	
func offload_data():
	# Saves data to global
	pass


func update_infographic():
	Infographic.text = "Index: %d" % global.current_index


func _on_DeleteButton_pressed():
	if global.current_index != null:
		ItemList.remove_item(global.current_index)
		global.current_index = null


func _on_ItemList_item_selected(index):
	global.current_index = index
	update_infographic()


func _on_ItemList_nothing_selected():
	global.current_index = null


func _on_EditButton_pressed():
	if global.current_index != null:
		global.state = global.PALETTE_EDITOR_EDIT
		var err = get_tree().change_scene("res://Scenes/PaletteEditor.tscn")


func _on_NameInput_text_changed():
	global.palette_filename = NameInput.text
	
	
func _on_NewButton_pressed():
	global.state = global.PALETTE_EDITOR_NEW
	var err = get_tree().change_scene("res://Scenes/PaletteEditor.tscn")
	
	
