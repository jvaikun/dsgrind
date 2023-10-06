extends Node2D

const BUILDING_SIZE = 32
const TILE_SIZE = 16
const OBJECT_LIST = {
		"factory": preload("res://world/spawner.tscn"),
		"depot": preload("res://enemies/enemy_target.tscn"),
	}
const portal_obj = preload("res://world/exit_portal.tscn")

@onready var skill_list = $UI/Skills/SkillList.get_children()

var mission_data = Mission.new()
var target_list = {}

var noise
var map_size = Vector2(3840, 2160)
var grass_cap = 0.5
var road_caps = Vector2(0.3, 0.05)
var enviroment_caps = Vector3(0.4, 0.3, 0.04)


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# Generate map
#	noise = FastNoiseLite.new()
#	noise.seed = randi()
#	noise.fractal_octaves = 1.0
#	noise.frequency = 12
#	#noise.persistence = 0.7
#	make_grass_map()
#	make_road_map()
#	make_enviroment_map()
#	make_background()
	# Set up player and connect to HUD
	$Player.load_equipment()
	$Player.connect("entered_portal", Callable(self, "exit_world"))
	$Player.connect("status_changed", Callable(self, "update_hud"))
	$Player.connect("equip_used", Callable(self, "equip_cooldown"))
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


func make_grass_map():
	var size_scaled = map_size / TILE_SIZE
	for x in size_scaled.x:
		for y in size_scaled.y:
			var a = noise.get_noise_2d(x,y)
			if a < grass_cap:
				$Grass.set_cell(x,y,0)
	$Grass.update_bitmask_region(Vector2(0.0, 0.0), Vector2(size_scaled.x, size_scaled.y))


func make_road_map():
	var size_scaled = map_size / TILE_SIZE
	for x in size_scaled.x:
		for y in size_scaled.y:
			var a = noise.get_noise_2d(x,y)
			if a < road_caps.x and a > road_caps.y:
				$Roads.set_cell(x,y,0)
	$Roads.update_bitmask_region(Vector2(0.0, 0.0), Vector2(size_scaled.x, size_scaled.y))


func make_enviroment_map():
	var size_scaled = map_size / TILE_SIZE
	for x in size_scaled.x:
		for y in size_scaled.y:
			var a = noise.get_noise_2d(x,y)
			if a < enviroment_caps.x and a > enviroment_caps.y or a < enviroment_caps.z:
				var chance = randi() % 100
				if chance < 2:
					var num = randi() % 4
					$Enviroment.set_cell(x,y, num)


func make_background():
	var size_scaled = map_size / TILE_SIZE
	for x in size_scaled.x:
		for y in size_scaled.y:
			if $Grass.get_cell(x,y) == -1:
				if $Grass.get_cell(x,y-1) == 0:
					$Background.set_cell(x,y,0)
	$Background.update_bitmask_region(Vector2(0.0, 0.0), Vector2(size_scaled.x, size_scaled.y))


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
		spawn_inst.connect(obj.signal, Callable(self, "update_objectives"))


func random_tile(data, biome):
	var current_biome = data[biome]
	var rand_num = randf_range(0,1)
	var running_total = 0
	for tile in current_biome:
			running_total = running_total+current_biome[tile]
			if rand_num <= running_total:
				return tile


func exit_world():
	var err = get_tree().change_scene_to_file("res://starmap/star_map.tscn")
	if err:
		print("Error changing scene!")


func equip_cooldown(slot_index):
	if slot_index < skill_list.size():
		skill_list[slot_index].use_skill()


func update_hud(player):
	$UI/ShipStatus/Bars/Armor/ArmorBar.max_value = player.armor_max
	$UI/ShipStatus/Bars/Shield/ShieldBar.max_value = player.shield_max
	$UI/ShipStatus/Bars/Armor/ArmorBar.value = player.armor
	$UI/ShipStatus/Bars/Shield/ShieldBar.value = player.shield


func update_objectives(object):
	if object in target_list:
		target_list[object].update_objective()
		target_list.erase(object)
		print("Total remaining targets: " + str(target_list.size()))
	if target_list.is_empty():
		var portal_inst = portal_obj.instantiate()
		portal_inst.position = Vector2(512, 128)
		call_deferred("add_child", portal_inst)

