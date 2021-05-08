extends Control
#
func _on_CancelButton_pressed():
	queue_free()


func _on_OkayButton_pressed():
	global.item_popup_name = $NameInput.text
	global.item_popup_character_id = $CharacterSelect.get_selected_id()
	global.item_popup_state = global.FINISHED
	queue_free()
