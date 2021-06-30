extends Control

onready var palette_menu_button = $PaletteMenuButton
onready var config_menu_button = $ConfigMenuButton
onready var settings_menu_button = $SettingsMenuButton
onready var network_menu_button = $NetworkMenuButton
onready var library_menu_button = $LibraryMenuButton
onready var infographic = $AuthorInfographic

func _ready() -> void:
	setup_buttons()
	infographic.setup_infographic() # Settings infographic to data in global.gd


func setup_buttons() -> void:
	palette_menu_button.set_text("Create Palettes")
	config_menu_button.set_text("Edit config")
	settings_menu_button.set_text("Settings")
	network_menu_button.set_text("Palette Network")
	library_menu_button.set_text("Library")


func _on_PaletteMenuButton_pressed():
	get_tree().change_scene("res://Scenes/PaletteManager.tscn")
