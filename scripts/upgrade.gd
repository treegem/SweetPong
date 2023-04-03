extends Area2D

class_name Upgrade

signal was_collected()


func _on_body_entered(body):
	if body is Ball:
		if body.lastContact.is_in_group("upgrade_collector"):
			body.lastContact.receive_upgrade()
		emit_signal("was_collected")
		queue_free()
