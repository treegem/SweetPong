extends Paddle

class_name EnemyPaddle

var target: Node2D

func set_target(newTarget: Node2D):
	target = newTarget

func _physics_process(delta):
	var distance = target.position.y -position.y
	var speed = clampf(distance / 50, -1, 1)
	move(Vector2.DOWN * speed, delta)
