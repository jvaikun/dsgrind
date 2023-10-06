extends CharacterBody2D

#const scn_explosion = preload("res://scenes/explosion.tscn")
#const scn_flash     = preload("res://scenes/flash.tscn")

# Accessor vars
@onready var shield_timer = $ShieldTimer
@onready var slot_list = [
	{"slot":$Slot1, "input":"shoot_primary"},
	{"slot":$Slot2, "input":"shoot_secondary"},
	{"slot":$Slot3, "input":"use_slot1"},
	{"slot":$Slot4, "input":"use_slot2"},
	{"slot":$Slot5, "input":"use_slot3"},
	{"slot":$Slot6, "input":"use_slot4"},
]

# Ship stats
var speed = 300
var armor_max = 0
var shield_max = 0
var armor = armor_max: set = set_armor
var shield = shield_max: set = set_shield
var charge_rate = 5.0
var can_charge = true
var loot = []
var loadout = {}

# General vars
var move_target = Vector2.ZERO
var move_vector = Vector2.ZERO
var aim_vector = Vector2.ZERO
var skill_proccing = false

signal status_changed
signal equip_used(slot_num)
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
	move_vector = Vector2.ZERO
	move_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	aim_vector = Vector2.ZERO
	aim_vector.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	aim_vector.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	if aim_vector == Vector2.ZERO:
		aim_vector = get_global_mouse_position() - global_position
	rotation = aim_vector.angle()
	set_velocity(move_vector.normalized() * speed)
	move_and_slide()
	for i in slot_list.size():
		if slot_list[i].input != "shoot_secondary" and Input.is_action_pressed(slot_list[i].input):
			if slot_list[i].slot.cooldown > 1.0 and !slot_list[i].slot.on_cooldown:
				emit_signal("equip_used", i)
			slot_list[i].slot.shoot()
	if Input.is_action_just_pressed("shoot_secondary"):
		#Find aim direction
		var zip_vector = aim_vector.normalized() * 128
		#Raycast with full length
		
		#Destination at endpoint or collision point
		#Move location to destination
		translate(zip_vector)
		#slot2.shoot()


func load_equipment():
	var data_path = ""
	for i in slot_list.size():
		data_path = GameData.get_data("db_equip", loadout.equip[i].index).script
		slot_list[i].slot.load_data(data_path)


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

