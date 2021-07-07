extends Control

onready var TabContain = $TabContainer

onready var config: ConfigFile
onready var tabs: Array

func _ready() -> void:
	config = global.hf_config()
	read_config()
	return
	

func read_config() -> void:
	for section in config.get_sections():
		add_tab(str(section))
	return
	
	
func add_tab(text: String) -> void:
	var tab = Control.new()
	tab.name = text
	TabContain.add_child(tab)
	return


func _on_CancelButton_pressed() -> void:
	var _err = get_tree().change_scene("res://Scenes/Menu.tscn")
	return


func _on_SaveButton_pressed() -> void:
	config.save("user://HFPE/cache/config.cfg")
	global.flush_cache(CONFIG_CACHE)
	var _err = get_tree().change_scene("res://Scenes/Menu.tscn")
	return
