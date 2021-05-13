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
		
		CharacterSprite.set_animation("Shoto Goto Idle")
		AttackSprite.set_animation("Shoto Goto Attack")
		SuperSprite.set_animation("Shoto Goto Super")
		current_index = 0
		character_index = 0
	else:
		for color in global.palettes[global.passing_index]["palette"]:
			ColorList.add_item(str(color), null, true)
		var string
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
	get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")

func _on_SaveMenuButton_pressed():
	if global.state != global.EDITING_SESSION:
		var palette = {}
		palette["character"] = character_index
		palette["palette"] = []
		for i in range(ColorList.get_item_count()):
			palette["palette"].append(ColorList.get_item_text(i))
		global.palettes.append(palette)
		global.state = global.SAVE_PALETTE
	else:
		print("Editing: %s" % global.palettes[global.passing_index])
		global.palettes[global.passing_index]["palette"].clear()
		for i in range(ColorList.get_item_count()):
			global.palettes[global.passing_index]["palette"].append(ColorList.get_item_text(i))
	get_tree().change_scene("res://Scenes/PaletteFileManager.tscn")

func _on_CharacterSelect_item_selected(index):
	character_index = index
	CharacterSprite.set_animation("%s Idle" % CharacterSelect.get_item_text(index))
	AttackSprite.set_animation("%s Attack" % CharacterSelect.get_item_text(index))
	SuperSprite.set_animation("%s Super" % CharacterSelect.get_item_text(index))
	var string = ""
	for c in CharacterSelect.get_item_text(index):
		if c == " ":
			string += "_"
		else:
			string += c
	ColorList.clear()
	for color in global.pal[string]:
		ColorList.add_item(color, null, true)
		
func apply_shader(color):
	if current_index <= 13:
		CharacterSprite.material.set("shader_param/NEWCOLOR%d" % current_index, Color(color))
	elif current_index <= 15:
		AttackSprite.material.set("shader_param/NEWCOLOR%d" % current_index, Color(color))
	elif current_index <= 17:
		SuperSprite.material.set("shader_param/NEWCOLOR%d" % current_index, Color(color))
	elif current_index == 18:
		AttackSprite.material.set("shader_param/NEWCOLOR%d" % current_index, Color(color))
		SuperSprite.material.set("shader_param/NEWCOLOR%d" % current_index, Color(color))

