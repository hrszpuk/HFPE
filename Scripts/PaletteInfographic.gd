extends ColorRect

onready var Character = $Character
onready var CharacterLabel = $CharacterLabel
onready var IndexLabel = $IndexLabel
onready var PaletteLabel = $PaletteLabel
onready var SectionLabel = $SectionLabel

func _ready() -> void:
	return
	
	
func set_icon(character: String) -> void:
	var image := Image.new()
	image.load("res://Assets/ui/select/char/preview/%s.png" % character)
	var texture := ImageTexture.new()
	texture.create_from_image(image)
	Character.texture = texture
	return
	

func set_name(name: String) -> void:
	CharacterLabel.text = "Name: %s" % name
	return
	

func set_index(index: int) -> void:
	IndexLabel.text = "Index: %d" % index
	return
	

func set_color(color: String) -> void:
	PaletteLabel.text = "Color: %s" % color
	return
	

func set_section(section: int) -> void:
	SectionLabel.text = "Section: %d" % section
	return
	

