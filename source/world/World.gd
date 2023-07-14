extends Node2D

const BUILDING_SIZE = 32
const TILE_SIZE = 16
const OBJECT_LIST = {
		"factory": preload("res://world/Spawner.tscn"),
		"depot": preload("res://enemies/EnemyTarget.tscn"),
	}
const portal_obj = preload("res://world/ExitPortal.tscn")

var mission_data = Mission.new()
var target_list = {}

var noise
var map_size = Vector2(2560, 1440)
var grass_cap = 0.5
var road_caps = Vector2(0.3, 0.05)
var enviroment_caps = Vector3(0.4, 0.3, 0.04)


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 1.0
	noise.period = 12
#	noise.persistence = 0.7
	make_grass_map()
	make_road_map()
	make_enviroment_map()
	make_background()
	$Player.load_equipment()
	$Player.connect("entered_portal", self, "exit_world")
	$Player.connect("status_changed", self, "update_hud")
	var tile_obj = load("res://ui/UIObjective.tscn")
	var tile_inst
	for obj in mission_data.objectives.primary:
		tile_inst = tile_obj.instance()
		$UI/UIObjectiveList/Body/PrimaryList.add_child(tile_inst)
		tile_inst.set_objective(obj)
		spawn_objective(obj, tile_inst)
	for obj in mission_data.objectives.secondary:
		tile_inst = tile_obj.instance()
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
		spawn_inst = spawn_obj.instance()
		get_parent().add_child(spawn_inst)
		spawn_inst.position = Vector2(
			randi() % int(scaled_size.x - 4) + 4,
			randi() % int(scaled_size.y - 4) + 4
		) * BUILDING_SIZE
		if obj.target == "factory":
			spawn_inst.enemy_index = randi() % spawn_inst.ENEMIES.size()
		target_list[spawn_inst] = tile
		spawn_inst.connect(obj.signal, self, "update_objectives")


func random_tile(data, biome):
	var current_biome = data[biome]
	var rand_num = rand_range(0,1)
	var running_total = 0
	for tile in current_biome:
			running_total = running_total+current_biome[tile]
			if rand_num <= running_total:
				return tile


func exit_world():
	var err = get_tree().change_scene("res://starmap/StarMap.tscn")
	if err:
		print("Error changing scene!")


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
	if target_list.empty():
		var portal_inst = portal_obj.instance()
		portal_inst.position = Vector2(512, 128)
		call_deferred("add_child", portal_inst)

