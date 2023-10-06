extends Area2D

var group = "player": set = set_group
var dmg = 1
var piercing = 0
var radius = 32: set = set_radius


func set_group(new_group):
	group = new_group
	match group:
		"player":
			add_to_group("bullet_player")
			collision_layer = 1
			collision_mask = 1
			set_collision_layer_value(4, true)
			set_collision_mask_value(1, true)
			set_collision_mask_value(3, true)
		"enemy":
			add_to_group("bullet_enemy")
			collision_layer = 1
			collision_mask = 1
			set_collision_layer_value(5, true)
			set_collision_mask_value(1, true)
			set_collision_mask_value(2, true)


func set_radius(val):
	radius = val
	$Collision.shape.radius = val


func _on_Sprite_animation_finished():
	queue_free()

