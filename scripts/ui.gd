extends Node

class_name UI

signal countdown_timer_timeout
signal new_game_started

func _on_countdown_timer_timeout():
	emit_signal("countdown_timer_timeout")


func _on_menu_new_game_started():
	emit_signal("new_game_started")


func update_enemy_score(newScore: int):
	$EnemyScore.update_visible_score(newScore)


func update_player_score(newScore: int):
	$PlayerScore.update_visible_score(newScore)


func show_player_lost():
	$Menu.display_player_lost()


func show_player_won():
	$Menu.display_player_won()


func count_down():
	$CountdownLabel.count_down()
