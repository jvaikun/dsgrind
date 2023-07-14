class_name Bullet
extends Area2D

var group = "player" setget set_group
var direction = Vector2.ZERO setget set_dir
var speed = 400
var dmg = 1
var piercing = 0
var is_player = false
var life_time = 5.0


func set_group(new_group):
	group = new_group
	match group:
		"player":
			add_to_group("bullet_player")
			collision_layer = 1
			collision_mask = 1
			set_collision_layer_bit(3, true)
			set_collision_mask_bit(0, true)
			set_collision_mask_bit(2, true)
		"enemy":
			add_to_group("bullet_enemy")
			collision_layer = 1
			collision_mask = 1
			set_collision_layer_bit(4, true)
			set_collision_mask_bit(0, true)
			set_collision_mask_bit(1, true)


func _ready():
	$Lifetime.start(life_time)


func set_dir(value : Vector2):
	direction = value
	rotation_degrees = rad2deg(direction.angle())


func _process(delta):
	translate(direction.normalized() * speed * delta)
	if global_position.x < 0 or global_position.y < 0:
		if !is_queued_for_deletion():
			queue_free()


func _on_Lifetime_timeout():
	if !is_queued_for_deletion():
		queue_free()

