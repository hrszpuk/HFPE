extends Control

onready var ItemList = $ItemList
onready var ItemTexture = preload("res://Assets/logo.png")

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Main Menu.tscn")


func _on_NewButton_pressed():
	ItemList.add_item("Test", ItemTexture, true)
	ItemList.ensure_current_is_visible()
	print(ItemList.get_item_count())
