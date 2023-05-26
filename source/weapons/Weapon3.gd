extends Node

const bullet_obj = preload("res://bullets/Wave.tscn")
const bullet_pattern = [
	[Vector2(0, -8), 0],
	[Vector2(0, 8), 0],
	[Vector2(0, -16), -5],
	[Vector2(0, 16), 5],
]
const cooldown = 0.2


func shoot_weapon():
	var parent = get_parent()
	var bullet_inst
	var angle = parent.global_transform.get_rotation()
	var bullet_angle
	for i in bullet_pattern:
		bullet_inst = bullet_obj.instance()
		get_tree().root.add_child(bullet_inst)
		bullet_inst.add_to_group("bullet")
		bullet_inst.add_to_group("bullet_player")
		bullet_inst.global_position = parent.global_position
		bullet_inst.global_position += i[0].rotated(angle)
		bullet_angle = angle + deg2rad(i[1])
		bullet_inst.direction = Vector2(cos(bullet_angle), sin(bullet_angle)).normalized()
		bullet_inst.speed = 600

