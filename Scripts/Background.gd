extends Node2D

export (bool) var ScreenShow = false

func _ready():
	if ScreenShow:
		$Screen.show()
	else:
		$Screen.hide()
