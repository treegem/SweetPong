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

func _on_enemy_scored(body):
	if body is Ball:
		enemyScore += 1
		proceed_after_goal()
		emit_signal("enemy_scored", enemyScore)

func _on_player_scored(body):
	if body is Ball:
		playerScore += 1
		proceed_after_goal()
		emit_signal("player_scored", playerScore)

func proceed_after_goal():
	if playerScore == MAX_SCORE:
		$UI.show_player_won()
	elif enemyScore == MAX_SCORE:
		$UI.show_player_lost()
	else:
		start_new_round()

func reset_scores():
	playerScore = 0
	enemyScore = 0

func start_new_round():
	$Ball.reset()
	$UI.count_down()
