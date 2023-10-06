extends Node2D

@onready var data = $WeaponData
@onready var cooldown_timer = $Cooldown

var cooldown = 1.0
var on_cooldown = false
var autofire = false


func load_data(path):
	cooldown_timer.stop()
	var data_obj = load(path)
	data.set_script(data_obj)
	cooldown = data.cooldown
	on_cooldown = false
	autofire = false


func shoot():
	if !on_cooldown:
		on_cooldown = true
		cooldown_timer.start(cooldown)
		data.shoot_weapon()


func _on_Cooldown_timeout():
	on_cooldown = false
	if autofire:
		shoot()

