extends Node

signal game_is_over(text: String)

const MAX_SCORE = 3

var playerScore = 0
var enemyScore = 0

func _process(delta):
	$PlayerScore.text = str(playerScore)
	$EnemyScore.text = str(enemyScore)

func _physics_process(delta):
	move_enemy_paddle(delta)
		

func _ready():
	$Ball.stop()

func _on_player_goal_body_entered(body):
	if body is Ball:
		enemyScore += 1
		proceed_after_goal()

func _on_enemy_goal_body_entered(body):
	if body is Ball:
		playerScore += 1
		proceed_after_goal()

func proceed_after_goal():
	if is_game_over():
		var text: String
		if playerScore == MAX_SCORE:
			text = "You win"
		elif enemyScore == MAX_SCORE:
			text = "You lose"
		emit_signal("game_is_over", text)
	else:
		start_new_round()

func is_game_over():
	return playerScore == MAX_SCORE or enemyScore == MAX_SCORE

func start_new_round():		
	$CountdownLabel/CoutndownTimer.start()
	$CountdownLabel.visible = true
	$Ball.stop()
	$Ball.reset()
	await $CountdownLabel/CoutndownTimer.timeout
	$Ball.start()

func _on_menu_play_button_pressed():
	playerScore = 0
	enemyScore = 0
	$Menu.hide()
	start_new_round()

func move_enemy_paddle(delta):
	var distance = $Ball.position.y - $EnemyPaddle.position.y
	var directionSign = sign(distance)
	if abs(distance) < 20: 
		directionSign = 0
	$EnemyPaddle.move(Vector2.DOWN * directionSign * delta)
