extends Paddle

class_name EnemyPaddle

var target: Node2D


func _ready():
	light = $Light
	slowBulletTimer = $SlowBulletTimer
	collisionShape = $CollisionShape2D
	slow_bullet_x_direction = 1
	super._ready()


func set_target(newTarget: Node2D):
	target = newTarget


func _physics_process(delta):
	var distance = target.position.y -position.y
	var speed = clampf(distance / 100, -1, 1)
	move(Vector2.DOWN * speed, delta)
