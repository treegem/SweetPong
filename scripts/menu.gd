extends ColorRect

signal play_button_pressed

func _on_play_button_pressed():
	emit_signal("play_button_pressed")
	
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_accept") and visible:
		emit_signal("play_button_pressed")
	
func display_player_wins():
	$Label.text = "You win"
	show()
	
func display_player_loses():
	$Label.text = "You lose"
	show()

func _on_main_new_round_started():
	hide()
