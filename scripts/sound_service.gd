extends AudioStreamPlayer2D

func play_player_sound():
	play_sound("res://sounds/ping.mp3")
	
func play_enemy_sound():
	play_sound("res://sounds/pong.mp3")

func play_lose_sound():
	play_sound("res://sounds/lose.mp3")
	
func play_win_sound():
	play_sound("res://sounds/win.mp3")

func play_sound(sound: String):
	stream = load(sound)
	play()
