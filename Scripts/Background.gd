extends Node2D

export (bool) var ScreenShow = false

func _ready() -> void:
	reset_character()
	clear_character_shader(global.start_character)
	set_stage(global.start_stage)
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
	

func set_stage(character: String ) -> void:
	$Stage.animation = character
	return 


func reset_character_shader_param(index: int, color: Color) -> void:
	$Character.material.set_shader_param("threshold", 0.001)
	$Character.material.set_shader_param("color_o%d" % index, color)
	return
	

func set_character_shader_param(index: int, color: Color) -> void:
	$Character.material.set_shader_param("color_n%d" % index, color)
	return
	

func clear_character_shader(character: String) -> void:
	$Character.animation = character
	$Character.material.set_shader_param("threshold", 0.001)
	var i: int = 0
	for item in global.default_palettes[character]:
		$Character.material.set_shader_param("color_o%d" % i, item)
		$Character.material.set_shader_param("color_n%d" % i, item)
		i += 1
	return
		
