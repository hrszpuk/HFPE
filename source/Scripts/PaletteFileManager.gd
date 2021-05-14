extends Control

onready var ItemList = $PaletteList/ItemList
onready var OInfo = $Info/OverallInfographic
onready var CInfo = $Info/CurrentInfographic
var palette_count = {
	goto = 0, yona = 0, kero = 0, don = 0, dark = 0, slime = 0, vince = 0, reaper = 0
}

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

func update_palette_count():
	for palette in global.palettes:
		match palette["character"]:
			0: palette_count["goto"] += 1
			1: palette_count["yona"] += 1
			2: palette_count["kero"] += 1
			3: palette_count["don"] += 1
			4: palette_count["dark"] += 1
			5: palette_count["slime"] += 1
			6: palette_count["vince"] += 1
			7: palette_count["reaper"] += 1

func update_overall_infographic():
	update_palette_count()
	OInfo.text = "Total number of Palettes: %d\n" % len(global.palettes)
	OInfo.text += "Number of Shoto Goto Palettes: %d\n" % palette_count["goto"]
	OInfo.text += "Number of Yo Yona Palettes: %d\n" % palette_count["yona"]
	OInfo.text += "Number of Dr Kero Palettes: %d\n" % palette_count["kero"]
	OInfo.text += "Number of Don McRon Palettes: %d\n" % palette_count["don"]
	OInfo.text += "Number of Dark Goto Palettes: %d\n" % palette_count["dark"]
	OInfo.text += "Number of Slime Bros Palettes: %d\n" % palette_count["slime"]
	OInfo.text += "Number of Reaper Angel Palettes: %d\n" % palette_count["reaper"]
	OInfo.text += "Number of Vince Volt Palettes: %d\n" % palette_count["vince"]

func _ready():
	var accepted_states = [global.SAVE_PALETTE, global.EDITING_SESSION, global.EXPORT]
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
	get_tree().change_scene("res://Scenes/Main Menu.tscn")

func _on_NewButton_pressed():
	get_tree().change_scene("res://Scenes/PaletteEditor.tscn")

func _on_SaveMenuButton_pressed():
	global.palette_filename = $Info/NameInput.text
	global.save_palette()

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
		get_tree().change_scene("res://Scenes/PaletteEditor.tscn")

func _on_ItemList_nothing_selected():
	current_index = null

func _on_ItemList_item_activated(index):
	global.passing_index = index
	get_tree().change_scene("res://Scenes/PaletteEditor.tscn")

func _on_DeleteMenuButton_pressed():
	var dir = Directory.new()
	dir.remove("user://%s.cfg" % $Info/NameInput.text)


func _on_ExportMenuButton_pressed():
	global.state = global.EXPORT
	get_tree().change_scene("res://Scenes/ExportManager.tscn")
