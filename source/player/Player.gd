extends KinematicBody2D

#const scn_explosion = preload("res://scenes/explosion.tscn")
#const scn_flash     = preload("res://scenes/flash.tscn")

# Accessor vars
onready var shield_timer = $ShieldTimer
onready var slot1 = $Slot1
onready var slot2 = $Slot2
onready var slot3 = $Slot3
onready var slot4 = $Slot4
onready var slot5 = $Slot5
onready var slot6 = $Slot6

# Ship stats
var speed = 300
var armor_max = 0
var shield_max = 0
var armor = armor_max setget set_armor
var shield = shield_max setget set_shield
var charge_rate = 5.0
var can_charge = true
var loot = []
var loadout = {}

# General vars
var move_target = Vector2.ZERO
var input_vector = Vector2.ZERO

signal status_changed
signal player_died
signal entered_portal


func set_shield(value):
	if (value > shield_max):
		shield = shield_max
	elif (value < 0):
		shield = 0
		self.armor -= (-value)
	else:
		shield = value
	emit_signal("status_changed", self)


func set_armor(value):
	armor = clamp(value, 0, armor_max)
	if (armor <= 0):
		#create_explosion()
		emit_signal("player_died")
		#queue_free()
	else:
		emit_signal("status_changed", self)


func _ready():
	loadout = Game.get_ship_data()
	var ship_data = GameData.get_data("db_ship", loadout.ship.index)
	armor_max = ship_data.armor
	shield_max = ship_data.shield
	self.armor = armor_max
	self.shield = shield_max
	load_equipment()
	shield_timer.wait_time = 1.0 / charge_rate
	shield_timer.start()
	move_target = global_position


func _process(delta):
		input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		if input_vector.length() > 0:
			rotation = input_vector.angle()
			move_target = global_position
			if !Input.is_action_pressed("move_hold"):
				move_and_slide(input_vector.normalized() * speed)
		if Input.is_action_pressed("move"):
			move_target = get_global_mouse_position()
		var move_vector = (move_target - global_position)
		if move_vector.length() > 16:
			rotation = move_vector.angle()
			if Input.is_action_pressed("move_hold"):
				move_target = global_position
			else:
				move_and_slide(move_vector.normalized() * speed)
		if Input.is_action_pressed("shoot_primary"):
			slot1.shoot()
		if Input.is_action_pressed("shoot_secondary"):
			slot2.shoot()


func load_equipment():
	var data_path = ""
	var weapon_list = [slot1, slot2, slot3, slot4, slot5, slot6]
	for i in weapon_list.size():
		data_path = GameData.get_data("db_equip", loadout.equip[i].index).script
		weapon_list[i].load_data(data_path)


#func create_explosion():
#	var explosion = scn_explosion.instance()
#	explosion.position = self.position
#	utils.main_node.add_child(explosion)
#	pass


func _on_ShieldTimer_timeout():
	if can_charge:
		self.shield += 1
		shield_timer.start()
	else:
		can_charge = true
		shield_timer.wait_time = 1.0 / charge_rate
		shield_timer.start()


func _on_Pickup_area_entered(area):
	if area.is_in_group("items"):
		area.move_to_player(self)


func _on_HitBox_area_entered(area):
	if area.is_in_group("enemy") or area.is_in_group("bullet_enemy"):
		area.queue_free()
		self.shield -= 1
		can_charge = false
		shield_timer.stop()
		shield_timer.start(1.0)
	if area.is_in_group("items"):
		area.queue_free()
	if area.is_in_group("exit_portal"):
		emit_signal("entered_portal")

