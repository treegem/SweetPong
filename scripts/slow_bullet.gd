extends Area2D

class_name SlowBullet

var acceleration = 50
var speed = 600
var X_DIRECTION: int
var viewport: Rect2
var sprite: Sprite2D
var creator: Paddle


func _ready():
	sprite = $Sprite2D
	viewport = get_viewport_rect()

func _physics_process(delta):
	speed += delta * acceleration
	acceleration *= 1.07
	position.x += speed * delta * X_DIRECTION
	if not viewport.has_point(position):
		queue_free()


func _on_body_entered(body):
	if body is Paddle and body != creator:
		body.get_hit()
		queue_free()
