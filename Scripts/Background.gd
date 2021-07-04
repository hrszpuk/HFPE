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
	

func set_stage(index: int) -> void:
	$Stage.animation = global.int_to_character_code_name(index)
	return 


func reset_character_shader_param(index: int, color: Color) -> void:
	$Character.material.set_shader_param("threshold", 0.001)
	$Character.material.set_shader_param("color_o%d" % index, color)
	return
	

func set_character_shader_param(index: int, color: Color) -> void:
	$Character.material.set_shader_param("color_n%d" % index, color)
	return
	

func clear_character_shader() -> void:
	$Character.material.set_shader_param("threshold", 1)
	for i in range(0, 19):
		$Character.material.set_shader_param("color_o%d" % i, Color.black)
	return
		
