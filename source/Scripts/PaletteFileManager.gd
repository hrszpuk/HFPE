extends Control

onready var ItemList = $PaletteList/ItemList
onready var OInfo = $Info/OverallInfographic
onready var CInfo = $Info/CurrentInfographic

var current_index = null
var config

func update_current_infographic(index: int):
	CInfo.text = "Current Palette\n"
	if current_index == null: 
		CInfo.text += "Index: null"
	else: 
		CInfo.text += "Index: %d\n" % current_index
	var string
	match global.palettes[index]["character"]:
		0: string = "Shoto Goto"
		1: string = "Yo Yona"
		2: string = "Dr Kero"
		3: string = "Don McRon"
		4: string = "Dark Goto"
		5: string = "Slime Bros"
		6: string = "Vince Volt"
		7: string = "Reaper Angel"
	CInfo.text += "Character: %s\n" % string
	CInfo.text += "Color: %s" % str(global.palettes[index]["palette"])


func update_overall_infographic():
	OInfo.text = "Total number of Palettes: %d\n" % len(global.palettes)
	var count = global.get_palette_nums()
	for i in range(7):
		var string
		match (i):
			0: string = "Shoto Goto"
			1: string = "Yo Yona"
			2: string = "Dr Kero"
			3: string = "Don McRon"
			4: string = "Dark Goto"
			5: string = "Slime Bros"
			6: string = "Vince Volt"
			7: string = "Reaper Angel"
		OInfo.text += "Number of %s Palettes: %d\n" % [string, count[global.char_int_to_str(i) + "_num"]]

func _ready():
	var accepted_states = [global.SAVE_PALETTE, global.EDITING_SESSION, global.EXPORT, global.IMPORT]
	if global.state == global.IMPORT:
		global.save_to_path = true
	if global.state in accepted_states:
		for item in global.palettes:
			match item["character"]:
				0: ItemList.add_item("Shoto Goto - %s" % item["name"], load("res://Assets/portrait/goto.png"))
				1: ItemList.add_item("Yo Yona - %s" % item["name"], load("res://Assets/portrait/yoyo.png"))
				2: ItemList.add_item("Dr Kero - %s" % item["name"], load("res://Assets/portrait/kero.png"))
				3: ItemList.add_item("Don McRon - %s" % item["name"], load("res://Assets/portrait/time.png"))
				4: ItemList.add_item("Dark Goto - %s" % item["name"], load("res://Assets/portrait/darkgoto.png"))
				5: ItemList.add_item("Slime Bro - %s" % item["name"], load("res://Assets/portrait/slime.png"))
				6: ItemList.add_item("Vince Volt - %s" % item["name"], load("res://Assets/portrait/sword.png"))
				7: ItemList.add_item("Reaper Angel - %s" % item["name"], load("res://Assets/portrait/scythe.png"))
		global.state = global.NONE
		update_overall_infographic()
	if global.palette_filename == null:
		$Info/NameInput.text = "Untitled"
	else:
		$Info/NameInput.text = global.palette_filename

func _on_BackButton_pressed():
	global.palettes.clear()
	var _scene = get_tree().change_scene("res://Scenes/Main Menu.tscn")

func _on_NewButton_pressed():
	var _scene = get_tree().change_scene("res://Scenes/PaletteEditor.tscn")

func _on_SaveMenuButton_pressed():
	global.state = global.EXPORT
	var _scene = get_tree().change_scene("res://Scenes/ExportManager.tscn")

func _on_DeleteButton_pressed():
	if current_index != null:
		ItemList.remove_item(current_index)
		global.palettes.remove(current_index)
		current_index = null
		update_overall_infographic()

func _on_ItemList_item_selected(index):
	current_index = index
	update_current_infographic(index)

func _on_EditButton_pressed():
	if current_index != null:
		global.passing_index = current_index
		global.state = global.EDITING_SESSION
		var _scene = get_tree().change_scene("res://Scenes/PaletteEditor.tscn")

func _on_ItemList_nothing_selected():
	current_index = null

func _on_ItemList_item_activated(index):
	global.passing_index = index
	var _scene = get_tree().change_scene("res://Scenes/PaletteEditor.tscn")

func _on_DeleteMenuButton_pressed():
	var dir: Directory = Directory.new()
	var _err = dir.remove(global.default_path+"/palettes/%s.cfg" % $Info/NameInput.text)

func _on_NameInput_text_changed(new_text):
	global.palette_filename = new_text
