extends Area2D

class_name SlowBullet

var acceleration = 100
var speed = 300
var X_DIRECTION: int
var viewport: Rect2
var sprite: Sprite2D

# todo: queue_free when leaving visible area

func _ready():
	sprite = $Sprite2D
	viewport = get_viewport_rect()

func _physics_process(delta):
	speed += delta * acceleration
	acceleration *= 1.1
	position.x += speed * delta * X_DIRECTION
	if not viewport.has_point(position):
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("hittable"):
		body.get_hit(self)
		queue_free()
