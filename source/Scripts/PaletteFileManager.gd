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

func _process(_delta):
	if global.state == global.SAVE_PALETTE or global.state == global.EDITING_SESSION:
		for item in global.palettes:
			print(global.palettes)
			match item["character"]:
				0: ItemList.add_item("Shoto Goto", load("res://Assets/portrait/goto.png"))
				1: ItemList.add_item("Yo Yona", load("res://Assets/portrait/yoyo.png"))
				2: ItemList.add_item("Dr Kero", load("res://Assets/portrait/kero.png"))
				3: ItemList.add_item("Don McRon", load("res://Assets/portrait/time.png"))
				4: ItemList.add_item("Dark Goto", load("res://Assets/portrait/darkgoto.png"))
				5: ItemList.add_item("Slime Bro", load("res://Assets/portrait/slime.png"))
				6: ItemList.add_item("Vince Volt", load("res://Assets/portrait/sword.png"))
				7: ItemList.add_item("Reaper Angel", load("res://Assets/portrait/scythe.png"))
		global.state = global.NONE
		update_overall_infographic()
		print(global.palettes)

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Main Menu.tscn")

func _on_NewButton_pressed():
	get_tree().change_scene("res://Scenes/PaletteEditor.tscn")

func _on_SaveMenuButton_pressed():
	pass

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
