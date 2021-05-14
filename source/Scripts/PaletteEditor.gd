extends Control

var current_index = null
var character_index = null
onready var ColorPicker = $ColorPicker
onready var AttackSprite = $MoveContainer/AttackPanel/AttackSprite
onready var SuperSprite = $MoveContainer/SuperPanel/SuperSprite
onready var CharacterSprite = $CharacterContainer/CharacterPanel/CharacterSprite
onready var ColorList = $MoveContainer/ColorList
onready var CharacterSelect = $CharacterContainer/CharacterSelect

func _ready():
	if global.passing_index == null:
		for color in global.pal["Shoto_Goto"]:
			ColorList.add_item(color, null, true)
		$CharacterContainer/PaletteNameInput.text = "Unnamed"
		CharacterSprite.set_animation("Shoto Goto Idle")
		AttackSprite.set_animation("Shoto Goto Attack")
		SuperSprite.set_animation("Shoto Goto Super")
		set_shader_settings(0)
		current_index = 0
		character_index = 0
		CharacterSprite.material.set("shader_param/threshold", 0.001)#
	else:
		$CharacterContainer/PaletteNameInput.text = global.palettes[global.passing_index]["name"]
		CharacterSelect.selected = global.palettes[global.passing_index]["character"]
		CharacterSelect.disabled = true
		for color in global.palettes[global.passing_index]["palette"]:
			ColorList.add_item(str(color), null, true)
		var string
		set_shader_settings(global.palettes[global.passing_index]["character"])
		CharacterSprite.material.set("shader_param/threshold", 0.001)
		match global.palettes[global.passing_index]["character"]:
			0: string = "Shoto Goto"
			1: string = "Yo Yona"
			2: string = "Dr Kero"
			3: string = "Don McRon"
			4: string = "Dark Goto"
			5: string = "Slime Bros"
			6: string = "Vince Volt"
			7: string = "Reaper"
		CharacterSprite.set_animation("%s Idle" % string)
		AttackSprite.set_animation("%s Attack" % string)
		SuperSprite.set_animation("%s Super" % string)
		character_index = global.palettes[global.passing_index]["character"]
		current_index = 0
		for color in global.palettes[global.passing_index]["palette"]:
			apply_shader(color)
			current_index += 1
		current_index = null

func _on_ColorList_item_selected(index):
	ColorPicker.color = Color(ColorList.get_item_text(index))
	current_index = index

func _on_ColorList_nothing_selected():
	current_index = null

func _on_ColorPicker_color_changed(color):
	if current_index != null:
		ColorList.set_item_text(current_index, color.to_html())
		apply_shader(color)

func _on_CharacterFlipped_pressed():
	CharacterSprite.scale.x *= -1
	SuperSprite.scale.x *= -1
	AttackSprite.scale.x *= -1

func _on_CancelButton_pressed():
	var _scene = get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")

func _on_SaveMenuButton_pressed():
	if global.state != global.EDITING_SESSION:
		var palette = {}
		palette["name"] = $CharacterContainer/PaletteNameInput.text
		palette["character"] = character_index
		palette["palette"] = []
		for i in range(ColorList.get_item_count()):
			palette["palette"].append(ColorList.get_item_text(i))
		global.palettes.append(palette)
		global.state = global.SAVE_PALETTE
	else:
		global.palettes[global.passing_index]["palette"].clear()
		global.palettes[global.passing_index]["name"] = $CharacterContainer/PaletteNameInput.text
		for i in range(ColorList.get_item_count()):
			global.palettes[global.passing_index]["palette"].append(ColorList.get_item_text(i))
		global.passing_index = null
	var _scene = get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")

func _on_CharacterSelect_item_selected(index):
	character_index = index
	CharacterSprite.set_animation("%s Idle" % CharacterSelect.get_item_text(index))
	AttackSprite.set_animation("%s Attack" % CharacterSelect.get_item_text(index))
	SuperSprite.set_animation("%s Super" % CharacterSelect.get_item_text(index))
	set_shader_settings(index)
	var string = ""
	for c in CharacterSelect.get_item_text(index):
		if c == " ":
			string += "_"
		else:
			string += c
	ColorList.clear()
	for color in global.pal[string]:
		ColorList.add_item(color, null, true)
		
func set_shader_settings(character: int):
	var i = 0
	var string
	match character:
		0: string = "Shoto_Goto"
		1: string = "Yo_Yona"
		2: string = "Dr_Kero"
		3: string = "Don_McRon"
		4: string = "Dark_Goto"
		5: string = "Slime_Bros"
		6: string = "Vince_Volt"
		7: string = "Reaper"
	for item in str_array_to_color_array(global.pal[string]):
		CharacterSprite.material.set("shader_param/color_o%d" % i, item)
		AttackSprite.material.set("shader_param/color_o%d" % i, item)
		SuperSprite.material.set("shader_param/color_o%d" % i, item)
		CharacterSprite.material.set("shader_param/color_n%d" % i, item)
		AttackSprite.material.set("shader_param/color_n%d" % i, item)
		SuperSprite.material.set("shader_param/color_n%d" % i, item)
		i += 1
		
func apply_shader(color):
	CharacterSprite.material.set("shader_param/color_n%d" % current_index, Color(color))
	AttackSprite.material.set("shader_param/color_n%d" % current_index, Color(color))
	SuperSprite.material.set("shader_param/color_n%d" % current_index, Color(color))
		
func str_array_to_color_array(array) -> Array:
	var color_array = []
	for item in array:
		color_array.append(Color(item))
	return color_array

