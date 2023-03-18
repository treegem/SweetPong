extends Node

signal player_scored(body)
signal enemy_scored(body)

func _on_enemy_goal_body_entered(body):
	emit_signal("player_scored", body)


func _on_player_goal_body_entered(body):
	emit_signal("enemy_scored", body)
