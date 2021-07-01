extends Control

onready var PaletteMenuButton = $PaletteMenuButton
onready var ConfigMenuButton = $ConfigMenuButton
onready var SettingsMenuButton = $SettingsMenuButton
onready var NetworkMenuButton = $NetworkMenuButton
onready var LibraryMenuButton = $LibraryMenuButton
onready var Infographic = $AuthorInfographic
onready var Background = $Background

func _ready() -> void:
	setup_buttons()
	Background.reset_character()
	Infographic.setup_infographic() # Settings infographic to data in global.gd


func setup_buttons() -> void:
	PaletteMenuButton.set_text("Create Palettes")
	ConfigMenuButton.set_text("Edit config")
	SettingsMenuButton.set_text("Settings")
	NetworkMenuButton.set_text("Palette Network")
	LibraryMenuButton.set_text("Library")


func _on_PaletteMenuButton_pressed():
	get_tree().change_scene("res://Scenes/PaletteManager.tscn")
