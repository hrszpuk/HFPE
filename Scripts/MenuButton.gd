extends Control

onready var label = $Label
const COLOR: Color = Color.black

func _ready() -> void:
	pass
	

func set_text(text: String) -> void:
	label.text = text


func set_color(color: Color) -> void:
	material.set("shader_param/color_o0", COLOR)
	material.set("shader_param/color_n0", Color.red)


func _on_Button_pressed() -> void:
	print("click")
