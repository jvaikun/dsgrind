extends Area2D

var dmg = 1
var piercing = 0

func _on_Sprite_animation_finished():
	queue_free()
