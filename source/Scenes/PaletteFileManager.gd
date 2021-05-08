extends Control

onready var ItemList = $ItemList
onready var ItemTexture = preload("res://Assets/logo.png")

var current_index = null
var config


func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Main Menu.tscn")

func _on_NewButton_pressed():
	get_tree().change_scene("res://Scenes/PaletteEditor.tscn")

func _on_DeleteButton_pressed():
	if current_index != null:
		ItemList.remove_item(current_index)
		current_index = null


func _on_ItemList_item_selected(index):
	current_index = index

func _on_SaveMenuButton_pressed():
	config = ConfigFile.new()
	
