extends Node

class_name UpgradeService

@export var upgrade_position_x_min: int
@export var upgrade_position_x_max: int
@export var upgrade_position_y_min: int
@export var upgrade_position_y_max: int
@export var upgrade_radius = 32


var upgradeScene: PackedScene = preload("res://upgrade.tscn")

var upgradeTimer: Timer


func _ready():
	upgradeTimer = $UpgradeTimer


func reset():
	_reset_timer()
	_remove_all_upgrades()


func _reset_timer():
	upgradeTimer.wait_time = randf_range(2.0, 5.0)
	upgradeTimer.start()
	
	
func create_upgrade():
	var newUpgrade: Upgrade = upgradeScene.instantiate()
	newUpgrade.position.x = randi_range(upgrade_position_x_min + upgrade_radius, upgrade_position_x_max - upgrade_radius)
	newUpgrade.position.y = randi_range(upgrade_position_y_min + upgrade_radius, upgrade_position_y_max - upgrade_radius)
	newUpgrade.was_collected.connect(_reset_timer)
	add_visible_child(newUpgrade)
	

func add_visible_child(node: Node):
	node.z_index = 1
	add_child(node)
	
	
func _remove_all_upgrades():
	for child in get_children():
		if child is Upgrade:
			remove_child(child)
