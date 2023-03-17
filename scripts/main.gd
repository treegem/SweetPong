extends Node

signal player_wins
signal player_loses

const MAX_SCORE = 3

var playerScore = 0
var enemyScore = 0

func _process(_delta):
	$PlayerScore.text = str(playerScore)
	$EnemyScore.text = str(enemyScore)

func _physics_process(delta):
	move_enemy_paddle(delta)
		
func _ready():
	$Ball.reset()

func _on_player_goal_body_entered(body):
	if body is Ball:
		enemyScore += 1
		proceed_after_goal()

func _on_enemy_goal_body_entered(body):
	if body is Ball:
		playerScore += 1
		proceed_after_goal()

func proceed_after_goal():
	if playerScore == MAX_SCORE:
		emit_signal("player_wins")
	elif enemyScore == MAX_SCORE:
		emit_signal("player_loses")
	else:
		start_new_round()

func start_new_round():		
	$CountdownLabel.count_down()
	$Ball.reset()

func reset_scores():
	playerScore = 0
	enemyScore = 0

func _on_menu_play_button_pressed():
	reset_scores()
	$Menu.hide()
	start_new_round()

func move_enemy_paddle(delta):
	var distance = $Ball.position.y - $EnemyPaddle.position.y
	var directionSign = sign(distance)
	var speed = clampf(abs(distance) / 50, 0, 1)
	$EnemyPaddle.move(Vector2.DOWN * directionSign * speed, delta)
