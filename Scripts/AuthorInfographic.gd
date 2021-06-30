extends Sprite

onready var author_icon = $AuthorIcon
onready var author_icon_border = $AuthorIconBorder
onready var author_username = $AuthorUsername
onready var author_description = $AuthorDescription


func set_username(text: String):
	author_username.text = text
	

func set_description(text: String):
	author_description.text = text
	

func set_icon(path: String) -> int:
	var img: Image = Image.new()
	var err = img.load("user://"+path)
	if err != 0:
		return err
	var tex = ImageTexture.new()
	img.resize(64, 64)
	tex.create_from_image(img)
	texture = tex
	return 0
	

func setup_infographic():
	author_username.text = global.author_username
	author_description.text = global.author_description
	set_icon("HFPE/%s" % global.author_icon)
