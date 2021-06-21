extends Control

onready var author_icon = $AuthorIcon
onready var author_icon_border = $AuthorIconBorder
onready var author_username = $AuthorUsername
onready var author_description = $AuthorDescription


func set_username(text: String):
	author_username.text = text
	

func set_description(text: String):
	author_description.text = text
	

func set_icon(path: String):
	$Sprite.texture = load("user://"+path)
