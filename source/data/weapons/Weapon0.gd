extends Node

const bullet_obj = preload("res://bullets/bullet_player.tscn")
const bullet_pattern = [
	[Vector2(0, -6), 0],
	[Vector2(0, 6), 0],
]
const cooldown = 0.05

var mods = [false, false, false, false, false, false, false, false]

func shoot_weapon():
	pass

