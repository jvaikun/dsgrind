extends Area2D

#const scn_explosion = preload("res://scenes/explosion.tscn")
#const scn_flash     = preload("res://scenes/flash.tscn")

# Accessor vars
onready var shield_timer = $ShieldTimer
onready var line = $Line2D
onready var weapon1 = $Weapon1
onready var weapon2 = $Weapon2

# Ship stats
var armor_max = 0
var shield_max = 0
var armor = armor_max setget set_armor
var shield = shield_max setget set_shield
var line_anchor = Vector2.ZERO
var loot = []
var loadout = {}

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
	#if new_value < shield:
		#audio_player.play("hit_ship")
		#get_tree().add_child(scn_flash.instance())


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
	shield_timer.one_shot = false
	shield_timer.wait_time = 1.0 / 2.0 #GameData.shield.rate
	shield_timer.start()


func _process(delta):
	if line.visible:
		line.set_point_position(1, line_anchor - self.global_position)
	else:
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		input_vector = input_vector.normalized()
		translate(input_vector * 200 * delta)
		if input_vector != Vector2.ZERO:
			rotation = input_vector.angle()
		if Input.is_action_pressed("shoot_primary"):
			weapon1.shoot()
		if Input.is_action_pressed("shoot_secondary"):
			weapon2.shoot()


func load_equipment():
	var data_path = ""
	var weapon_list = [weapon1, weapon2]
	for i in weapon_list.size():
		data_path = GameData.get_data("db_equip", loadout.weapons[i].index).script
		weapon_list[i].load_data(data_path)


#func create_explosion():
#	var explosion = scn_explosion.instance()
#	explosion.position = self.position
#	utils.main_node.add_child(explosion)
#	pass


func outro_mode():
	line.visible = true
	line_anchor = self.global_position


func _on_ShieldTimer_timeout():
	self.shield += 1


func _on_Pickup_area_entered(area):
	if area.is_in_group("items"):
		area.move_to_player(self)


func _on_Player_area_entered(area):
	if area.is_in_group("enemy") or area.is_in_group("bullet_enemy"):
		area.queue_free()
		self.shield -= 1
	if area.is_in_group("items"):
		area.queue_free()
	if area.is_in_group("exit_portal"):
		emit_signal("entered_portal")
