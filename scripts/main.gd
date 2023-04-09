extends Node

const MAX_SCORE = 2

var playerScore = 0
var enemyScore = 0

var enemyPaddle: EnemyPaddle
var playerPaddle: PlayerPaddle
var ball: Ball
var ui: UI
var upgradeService: UpgradeService
var soundService: SoundService


func _ready():
	enemyPaddle = $EnemyPaddle
	playerPaddle = $PlayerPaddle
	ball = $Ball
	ui = $UI
	upgradeService = $UpgradeService
	soundService = $SoundService
	
	enemyPaddle.set_target(ball)


func _on_enemy_scored(body):
	if body is Ball:
		enemyScore += 1
		proceed_after_goal()
		ui.update_enemy_score(enemyScore)


func _on_player_scored(body):
	if body is Ball:
		playerScore += 1
		proceed_after_goal()
		ui.update_player_score(playerScore)


func proceed_after_goal():
	if playerScore < MAX_SCORE and enemyScore < MAX_SCORE:
		start_new_round()
	else:
		end_game()
	
	
	
func end_game():
	reset_children()
	if playerScore == MAX_SCORE:
		ui.show_player_won()
		soundService.play_win_sound()
	elif enemyScore == MAX_SCORE:
		ui.show_player_lost()
		soundService.play_lose_sound()


func clear_score():
	playerScore = 0
	enemyScore = 0


func start_new_game():
	clear_score()
	start_new_round()


func start_new_round():
	reset_children()
	ui.count_down()
	
	
func reset_children():
	get_tree().call_group("resettable", "reset")

	
func _on_visible_child_created(node: Node):
	add_child(node)
