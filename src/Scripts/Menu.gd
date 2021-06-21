extends Control

onready var palette_menu_button = $PaletteMenuButton
onready var config_menu_button = $ConfigMenuButton
onready var settings_menu_button = $SettingsMenuButton
onready var network_menu_button = $NetworkMenuButton
onready var library_menu_button = $LibraryMenuButton


func _ready() -> void:
	setup_buttons()

func setup_buttons() -> void:
	palette_menu_button.set_text("Create Palettes")
	config_menu_button.set_text("Edit config")
	settings_menu_button.set_text("Settings")
	network_menu_button.set_text("Palette Network")
	library_menu_button.set_text("Library")
