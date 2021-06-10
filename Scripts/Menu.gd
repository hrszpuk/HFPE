extends Control

onready var IconContent = $IconContent

func _ready():
	load_icon_content()
	

func generate_icon_content() -> ImageTexture:
	# generates a white ImageTexture and returns it
	var img: ImageTexture = ImageTexture.new()
	img.create(2, 2, 4)
	return img
	

func load_icon_content():
	# look for icon link in config:
	# if found load it from user://
	# else set it to generate_icon_content()
	IconContent.texture = generate_icon_content()
