extends PopupDialog

onready var Title = $Title
onready var SectionSelector = $Section
onready var InfoLabel = $Information

func _ready() -> void:
	
	return
	

func set_title(string: String) -> void:
	Title.text = string
	return


func set_info_label(string: String) -> void:
	InfoLabel.text = string
	return
	
	
func update_info_label(new_section: String, character: String = "") -> void:
	if character != "":
		set_info_label(
			"Swap section %s: %s (%s) to section %s: %s" % [
				global.section_cache, 
				global.character_cache, 
				global.name_cache, 
				new_section, 
				character
				]
		)
	else:
		set_info_label(
			"Move section %s: %s (%s) to section %s" % [
				global.section_cache, 
				global.character_cache, 
				global.name_cache, 
				new_section
				]
		)
	return
	

func setup_dialog_move(section: String, character: String, name: String) -> void:
	set_title("Move")
	set_info_label("Move section %s: %s (%s) to section 1" % [section, character, name])
	global.section_cache = section
	global.character_cache  = character
	global.name_cache = name
	#SectionSelector.select(0) # Section 1
	return


func setup_dialog_swap(section: String, character: String, name: String) -> void:
	set_title("Swap")
	set_info_label("Swap section %s: %s (%s) to section ?: ?" % [section, character, name])
	global.section_cache = section
	global.character_cache  = character
	global.name_cache = name
	#SectionSelector.select(0) # Section 1
	return


