extends Area2D

class_name SlowBullet

var ACCELERATION = 100
var SPEED = 300


func _physics_process(delta):
	SPEED += delta * ACCELERATION
	ACCELERATION *= 1.1
	position.x -= SPEED * delta


func _on_body_entered(body):
	if body.is_in_group("hittable"):
		body.get_hit(self)
		queue_free()
