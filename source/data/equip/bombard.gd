extends Node

const bullet_obj = preload("res://bullets/blast.tscn")
const bullet_count = 16
const cooldown = 0.5

var mods = [false, false, false, false, false, false, false, false]

func shoot_weapon():
	var parent = get_parent()
	var bullet_inst
	var angle = parent.global_transform.get_rotation()
	var bullet_angle
	for i in bullet_count:
		bullet_inst = bullet_obj.instantiate()
		get_tree().root.add_child(bullet_inst)
		bullet_inst.group = "player"
		bullet_inst.global_position = parent.global_position
		var rot_angle = randf() * (PI/2.0) - (PI/4.0)
		bullet_inst.global_position += Vector2.RIGHT.rotated(angle + rot_angle) * (randi() % 4 + 2) * 64

