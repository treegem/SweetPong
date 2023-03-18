extends Node

signal player_wins
signal player_loses
signal player_scored(score: int)
signal enemy_scored(score: int)
signal new_round_started

const MAX_SCORE = 3

var playerScore = 0
var enemyScore = 0

func _ready():
	$EnemyPaddle.set_target($Ball)

func _on_player_goal_body_entered(body):
	if body is Ball:
		enemyScore += 1
		proceed_after_goal()
		emit_signal("enemy_scored", enemyScore)

func _on_enemy_goal_body_entered(body):
	if body is Ball:
		playerScore += 1
		proceed_after_goal()
		emit_signal("player_scored", playerScore)

func proceed_after_goal():
	if playerScore == MAX_SCORE:
		emit_signal("player_wins")
	elif enemyScore == MAX_SCORE:
		emit_signal("player_loses")
	else:
		emit_signal("new_round_started")

func reset_scores():
	playerScore = 0
	enemyScore = 0

func _on_menu_play_button_pressed():
	reset_scores()
	emit_signal("new_round_started")
