extends Control

var current_index = null

func _ready():
	for color in global.goto_palette:
		$ColorList.add_item(color, null, true)

func _on_ColorList_item_selected(index):
	$ColorPicker.color = Color($ColorList.get_item_text(index))
	current_index = index


func _on_ColorList_nothing_selected():
	current_index = null


func _on_ColorPicker_color_changed(color):
	if current_index != null:
		$ColorList.set_item_text(current_index, color.to_html())
		if current_index <= 13:
			$CharacterPanel/CharacterSprite.material.set("shader_param/NEWCOLOR%d" % current_index, color)
		elif current_index <= 15:
			$AttackPanel/AttackSprite.material.set("shader_param/NEWCOLOR%d" % current_index, color)
		elif current_index <= 17:
			$SuperPanel/SuperSprite.material.set("shader_param/NEWCOLOR%d" % current_index, color)
		elif current_index == 18:
			$AttackPanel/AttackSprite.material.set("shader_param/NEWCOLOR%d" % current_index, color)
			$SuperPanel/SuperSprite.material.set("shader_param/NEWCOLOR%d" % current_index, color)

func _on_CharacterFlipped_pressed():
	$CharacterPanel/CharacterSprite.scale.x *= -1
	$SuperPanel/SuperSprite.scale.x *= -1
	$AttackPanel/AttackSprite.scale.x *= -1
