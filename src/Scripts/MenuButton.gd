extends Control
onready var button = $Button
onready var label = $Label


func set_text(text: String) -> void:
	label.text = text


func _on_Button_pressed() -> void:
	print("click")
