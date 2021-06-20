extends Control

onready var ItemList = $PaletteList/ItemList
onready var OInfo = $Info/OverallInfographic
onready var CInfo = $Info/CurrentInfographic

var current_index = null
var config

func update_current_infographic(index: int):
	logger("Calling update_current_infographic()")
	CInfo.text = "Current Palette\n"
	if current_index == null: 
		CInfo.text += "Index: null"
	else: 
		CInfo.text += "Index: %d\n" % current_index
	logger("^^^ Set index text")
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
	logger("^^^ Matching character")
	CInfo.text += "Character: %s\n" % string
	logger("^^^ Set character '%s'" % string)
	CInfo.text += "Color: %s" % str(global.palettes[index]["palette"])
	logger("^^^ Set color '%s'" % str(global.palettes[index]["palette"]))


func update_overall_infographic():
	logger("Calling update_overall_infographic()")
	OInfo.text = "Total number of Palettes: %d\n" % len(global.palettes)
	logger("^^^ Set total palette number")
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
		logger("^^^ Set '%s' palette number" % string)
	

func _ready():
	logger("Ready!")
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
			logger("Added item to ItemList")
		global.state = global.NONE
		update_overall_infographic()
	if global.palette_filename == null:
		$Info/NameInput.text = "Untitled"
	else:
		$Info/NameInput.text = global.palette_filename
	logger("Set Filename text")

func _on_BackButton_pressed():
	logger("BackButton pressed")
	global.palettes.clear()
	global.logger.flush()
	var _scene = get_tree().change_scene("res://Scenes/Main Menu.tscn")

func _on_NewButton_pressed():
	logger("NewButton pressed")
	global.logger.flush()
	var _scene = get_tree().change_scene("res://Scenes/PaletteEditor.tscn")

func _on_SaveMenuButton_pressed():
	logger("SaveMenuButton pressed")
	global.state = global.EXPORT
	global.logger.flush()
	var _scene = get_tree().change_scene("res://Scenes/ExportManager.tscn")

func _on_DeleteButton_pressed():
	logger("DeleteButton pressed")
	if current_index != null:
		ItemList.remove_item(current_index)
		global.palettes.remove(current_index)
		logger("Removed selected palette")
		current_index = null
		update_overall_infographic()

func _on_ItemList_item_selected(index):
	logger("ItemList item selected")
	current_index = index
	update_current_infographic(index)

func _on_EditButton_pressed():
	logger("EditButton pressed")
	if current_index != null:
		global.passing_index = current_index
		global.state = global.EDITING_SESSION
		var _scene = get_tree().change_scene("res://Scenes/PaletteEditor.tscn")

func _on_ItemList_nothing_selected():
	logger("ItemList nothing selected")
	current_index = null

func _on_ItemList_item_activated(index):
	logger("ItemList item double-clicked")
	global.passing_index = index
	global.logger.flush()
	var _scene = get_tree().change_scene("res://Scenes/PaletteEditor.tscn")

func _on_DeleteMenuButton_pressed():
	logger("DeleteMenuButton pressed")
	var dir: Directory = Directory.new()
	var _err = dir.remove(global.default_path+"/palettes/%s.cfg" % $Info/NameInput.text)

func _on_NameInput_text_changed(new_text):
	logger("Filename text changed")
	global.palette_filename = new_text
	
func logger(string: String) -> void:
	global.logger.set_prefix("PaletteFileManager")
	global.logger.write(string)
