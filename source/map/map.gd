extends Node2D

const BUILDING_SIZE = 32
const TILE_SIZE = 16
const OBJECT_LIST = {
		"factory": preload("res://map/spawner.tscn"),
		"depot": preload("res://enemies/enemy_target.tscn"),
	}
const portal_obj = preload("res://map/exit_portal.tscn")

@onready var skill_list = $UI/Skills/SkillList.get_children()

var mission_data = Mission.new()
var target_list = {}
var map_size = Vector2(3840, 2160)
var world_exited = false


func _ready():
	randomize()
	# Set up player and connect to HUD
	$Player.load_equipment()
	$Player.connect("entered_portal", exit_world)
	$Player.connect("status_changed", update_hud)
	$Player.connect("equip_used", equip_cooldown)
	var equip_cooldown = 0.0
	var equip_icon = ""
	for i in skill_list.size():
		equip_cooldown = $Player.slot_list[i].slot.cooldown
		equip_icon = GameData.get_data("db_equip", $Player.loadout.equip[i].index).icon
		skill_list[i].load_skill(equip_icon, equip_cooldown)
	# Load objectives
	var tile_obj = load("res://ui/ui_objective.tscn")
	var tile_inst
	for obj in mission_data.objectives.primary:
		tile_inst = tile_obj.instantiate()
		$UI/UIObjectiveList/Body/PrimaryList.add_child(tile_inst)
		tile_inst.set_objective(obj)
		spawn_objective(obj, tile_inst)
	for obj in mission_data.objectives.secondary:
		tile_inst = tile_obj.instantiate()
		$UI/UIObjectiveList/Body/SecondaryList.add_child(tile_inst)
		tile_inst.set_objective(obj)
		spawn_objective(obj, tile_inst)


func _process(_delta):
	if world_exited:
		var err = get_tree().change_scene_to_file("res://starmap/star_map.tscn")
		if err:
			print("Error changing scene!")


func spawn_objective(obj, tile):
	var spawn_obj = OBJECT_LIST[obj.target]
	var spawn_inst
	var scaled_size = (map_size / BUILDING_SIZE)
	for i in obj.amount:
		spawn_inst = spawn_obj.instantiate()
		get_parent().add_child(spawn_inst)
		spawn_inst.position = Vector2(
			randi() % int(scaled_size.x - 10) + 10,
			randi() % int(scaled_size.y - 10) + 10
		) * BUILDING_SIZE
		if obj.target == "factory":
			spawn_inst.enemy_index = randi() % spawn_inst.ENEMIES.size()
		target_list[spawn_inst] = tile
		spawn_inst.connect(obj.signal, update_objectives)


func exit_world():
	world_exited = true


func equip_cooldown(slot_index):
	if slot_index < skill_list.size():
		skill_list[slot_index].use_skill()


func update_hud(player):
	$UI/ShipStatus/Content/ArmorBar.max_value = player.armor_max
	$UI/ShipStatus/Content/ShieldBar.max_value = player.shield_max
	$UI/ShipStatus/Content/ArmorBar.value = player.armor
	$UI/ShipStatus/Content/ShieldBar.value = player.shield


func update_objectives(object):
	if object in target_list:
		target_list[object].update_objective()
		target_list.erase(object)
		print("Total remaining targets: " + str(target_list.size()))
	if target_list.is_empty():
		var portal_inst = portal_obj.instantiate()
		portal_inst.position = Vector2(512, 128)
		call_deferred("add_child", portal_inst)

