extends Paddle

class_name EnemyPaddle

signal upgrade_collected

var target: Node2D
const MAX_SPEED_MODIFIER: float = 2
var speed_modifier: float = MAX_SPEED_MODIFIER


func receive_upgrade():
	emit_signal("upgrade_collected")

func set_target(newTarget: Node2D):
	target = newTarget

func _physics_process(delta):
	var distance = target.position.y -position.y
	var speed = clampf(distance / 100, -1, 1)
	move(Vector2.DOWN * speed * speed_modifier, delta)


func get_hit(bullet: Node):
	var tween = get_tree().create_tween()
	speed_modifier = MAX_SPEED_MODIFIER / 20
	tween.tween_property(self, "speed_modifier", MAX_SPEED_MODIFIER, 4).set_trans(Tween.TRANS_EXPO)
