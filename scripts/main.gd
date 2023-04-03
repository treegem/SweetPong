extends Node

const MAX_SCORE = 1

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
	if playerScore == MAX_SCORE:
		ui.show_player_won()
		soundService.play_win_sound()
	elif enemyScore == MAX_SCORE:
		ui.show_player_lost()
		soundService.play_lose_sound()
	else:
		start_new_round()


func reset_scores():
	playerScore = 0
	enemyScore = 0


func start_new_game():
	playerPaddle.remove_upgrade()
	upgradeService.remove_all_upgrades()
	reset_scores()
	start_new_round()


func start_new_round():
	upgradeService.reset_timer()
	ball.reset()
	playerPaddle.remove_upgrade()
	ui.count_down()
