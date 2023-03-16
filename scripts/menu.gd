extends ColorRect

signal play_button_pressed

func _on_play_button_pressed():
	emit_signal("play_button_pressed")
	
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_accept") and visible:
		emit_signal("play_button_pressed")


func _on_main_game_is_over(text):
	$Label.text = text
	show()
