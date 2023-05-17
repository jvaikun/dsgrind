class_name Bullet
extends Area2D

var direction = Vector2.ZERO setget set_dir
var speed = 400
var dmg = 1
var piercing = 0
var is_player = false


func set_dir(value : Vector2):
	direction = value
	rotation_degrees = rad2deg(direction.angle())


func _process(delta):
	translate(direction.normalized() * speed * delta)


func _on_VisCheck_screen_exited():
	if !is_queued_for_deletion():
		queue_free()
