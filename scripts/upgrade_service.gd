extends Node

class_name UpgradeService

@export var upgrade_position_x_min: int
@export var upgrade_position_x_max: int
@export var upgrade_position_y_min: int
@export var upgrade_position_y_max: int
@export var upgrade_radius = 32

signal slow_bullet_created(bullet: SlowBullet)

var slowBulletScene: PackedScene = preload("res://slow_bullet.tscn")
var upgrade: PackedScene = preload("res://upgrade.tscn")

var upgradeTimer: Timer


func _ready():
	upgradeTimer = $UpgradeTimer


func _process(delta):
	if !upgradeTimer.is_stopped():
		print(upgradeTimer.time_left)


func _on_player_paddle_upgrade_triggered(paddle: Paddle):
	var slowBullet = slowBulletScene.instantiate()
	slowBullet.position = paddle.position + Vector2(-paddle.width() / 2,0)
	add_visible_child(slowBullet)
	reset_timer()


func reset_timer():
	upgradeTimer.wait_time = randf_range(2.0, 5.0)
	upgradeTimer.start()
	
	
func create_upgrade():
	var newUpgrade: Upgrade = upgrade.instantiate()
	newUpgrade.position.x = randi_range(upgrade_position_x_min + upgrade_radius, upgrade_position_x_max - upgrade_radius)
	var max_y: int = get_viewport().get_visible_rect().size.y
	newUpgrade.position.y = randi_range(upgrade_position_y_min + upgrade_radius, upgrade_position_y_max - upgrade_radius)
	add_visible_child(newUpgrade)
	

func add_visible_child(node: Node):
	node.z_index = 1
	add_child(node)
	
	
func remove_all_upgrades():
	for child in get_children():
		if child is Upgrade:
			remove_child(child)
