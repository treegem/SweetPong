extends Paddle

class_name EnemyPaddle

var target: Node2D
const MAX_SPEED_MODIFIER: float = 2
var speed_modifier: float = MAX_SPEED_MODIFIER
var speed_modifier_tween: Tween


func _ready():
	light = $Light
	slowBulletTimer = $SlowBulletTimer
	collisionShape = $CollisionShape2D
	SLOW_BULLET_X_DIRECTION = 1
	super._ready()


func set_target(newTarget: Node2D):
	target = newTarget


func _physics_process(delta):
	var distance = target.position.y -position.y
	var speed = clampf(distance / 100, -1, 1)
	move(Vector2.DOWN * speed * speed_modifier, delta)


func get_hit(bullet: Node):
	if speed_modifier_tween != null:
		speed_modifier_tween.kill()
	speed_modifier_tween = get_tree().create_tween()
	speed_modifier = MAX_SPEED_MODIFIER / 20
	speed_modifier_tween.tween_property(self, "speed_modifier", MAX_SPEED_MODIFIER, 4).set_trans(Tween.TRANS_EXPO)
