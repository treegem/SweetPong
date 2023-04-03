extends AudioStreamPlayer2D

class_name SoundService

var ping_sound: Resource = preload("res://sounds/ping.mp3")
var pong_sound: Resource = preload("res://sounds/pong.mp3")
var win_sound: Resource = preload("res://sounds/win.mp3")
var lose_sound: Resource = preload("res://sounds/lose.mp3")


func play_player_sound():
	play_sound(ping_sound)
	
func play_enemy_sound():
	play_sound(pong_sound)

func play_lose_sound():
	play_sound(lose_sound)
	
func play_win_sound():
	play_sound(win_sound)

func play_sound(sound: Resource):
	stream = sound
	play()
