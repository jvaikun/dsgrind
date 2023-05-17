extends Control

const target_obj = preload("res://enemies/EnemyTarget.tscn")
const WEAPON_LIST = [
	{"name":"None", "object": preload("res://weapons/Weapon0.gd")},
	{"name":"Blaster", "object": preload("res://weapons/Weapon1.gd")},
	{"name":"Missile", "object": preload("res://weapons/Weapon2.gd")},
	{"name":"Wave", "object": preload("res://weapons/Weapon3.gd")},
	{"name":"Twister", "object": preload("res://weapons/Weapon4.gd")},
	{"name":"Drunk Missile", "object": preload("res://weapons/Weapon5.gd")},
	{"name":"Mines", "object": preload("res://weapons/Weapon6.gd")},
	{"name":"Plasma Caster", "object": preload("res://weapons/Weapon7.gd")},
]
const DEVICE_LIST = []

onready var hp_base = $Settings/Targets/BaseHP
onready var hp_var = $Settings/Targets/VarHP
onready var density = $Settings/Targets/Density

var spawn_point = Vector2.ZERO
var aim_dir = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_point = get_viewport_rect().size / 2.0
	spawn_point.y = 0
	$SpawnTimer.start(randf())
	for weapon in WEAPON_LIST:
		$Settings/Weapons/WeaponList1.add_item(weapon.name)
		$Settings/Weapons/WeaponList2.add_item(weapon.name)
	$Weapon1.rotation_degrees = -90
	$Weapon2.rotation_degrees = -90
	set_weapon(1, 0)
	set_weapon(2, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	aim_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	aim_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	aim_dir = aim_dir.normalized()
	if aim_dir != Vector2.ZERO:
		$Weapon1.rotation_degrees = rad2deg(aim_dir.angle())
		$Weapon2.rotation_degrees = rad2deg(aim_dir.angle())


func set_weapon(slot, index):
	match slot:
		1:
			$Weapon1.set_script(WEAPON_LIST[index].object)
			$Weapon1.init_weapon()
		2:
			$Weapon2.set_script(WEAPON_LIST[index].object)
			$Weapon2.init_weapon()


func _on_WeaponList1_item_selected(index):
	set_weapon(1, index)
	pass # Replace with function body.


func _on_WeaponList2_item_selected(index):
	set_weapon(2, index)
	pass # Replace with function body.


func _on_DeviceList1_item_selected(index):
	pass # Replace with function body.


func _on_DeviceList2_item_selected(index):
	pass # Replace with function body.


func _on_DeviceList3_item_selected(index):
	pass # Replace with function body.


func _on_DeviceList4_item_selected(index):
	pass # Replace with function body.


func _on_SpawnTimer_timeout():
	var target_inst = target_obj.instance()
	add_child(target_inst)
	target_inst.hp = hp_base.value + (randi() % int(hp_var.value)*2) - hp_var.value
	target_inst.position = spawn_point + Vector2(((randi() % 4) - 2) * 16, 0)
	target_inst.direction = Vector2.DOWN
	$SpawnTimer.start(randf())
