extends Node2D

export (bool) var ScreenShow = false

func _ready() -> void:
	if ScreenShow:
		$Screen.show()
	else:
		$Screen.hide()
	return
	

func reset_character() -> void:
	$Character.animation = global.start_character
	return
	

func set_character(character: String) -> void:
	$Character.animation = character
	return
