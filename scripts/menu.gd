extends ColorRect

signal new_game_started

func _on_new_game_started():
	hide()
	
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_accept") and visible:
		emit_signal("new_game_started")
	
func display_player_won():
	$Label.text = "You win"
	show()
	
func display_player_lost():
	$Label.text = "You lose"
	show()


func _on_play_button_pressed():
	emit_signal("new_game_started")
