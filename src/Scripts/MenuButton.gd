extends Control

onready var label = $Label


func set_text(text: String) -> void:
	label.text = text


func _on_Button_pressed() -> void:
	print("click")
