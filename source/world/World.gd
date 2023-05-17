extends Node2D

const OBJECT_LIST = {
		"factory": preload("res://world/Spawner.tscn"),
		"depot": preload("res://enemies/EnemyTarget.tscn"),
	}
const portal_obj = preload("res://world/ExitPortal.tscn")
const spawners = [
	Vector2(240, 200),
	Vector2(650, 210),
	Vector2(1150, 250),
	Vector2(300, 590),
	Vector2(890, 580),
]
const depots = [
	Vector2(200, 640),
	Vector2(400, 640),
	Vector2(600, 640),
	Vector2(800, 640),
	Vector2(1000, 640),
]
const tiles = {"grass": 0, "jungle_grass": 1, "sand": 2, "water": 3, "snow": 4, "stone": 5}
const biome_data = {
	"plains": {"grass": 1},
	"beach": {"sand": 0.99, "stone": 0.01}, 
	"jungle": {"jungle_grass": 1},
	"desert": {"sand": 0.98, "stone": 0.02}, 
	"lake": {"water": 1},
	"mountain": {"stone": 0.98, "grass":0.02},
	"snow": {"snow": 0.97, "stone": 0.02, "grass": 0.02},
	"ocean":{"water": 1}
}

onready var tilemap = $TileMap

var mission_data = Mission.new()
var target_list = {}
var map_width = 160
var map_height = 90
var temperature = {}
var moisture = {}
var altitude = {}
var biome = {}
var map_noise = OpenSimplexNoise.new()


func generate_map(per, oct):
	map_noise.seed = randi()
	map_noise.period = per
	map_noise.octaves = oct
	var gridName = {}
	for x in map_width:
		for y in map_height:
			var rand := 2*(abs(map_noise.get_noise_2d(x,y)))
			gridName[Vector2(x,y)] = rand
	return gridName


func set_tile(width, height):
	for x in width:
		for y in height:
			var pos = Vector2(x, y)
			var alt = altitude[pos]
			var temp = temperature[pos]
			var moist = moisture[pos]
			
			#Ocean
			if alt < 0.2:
				biome[pos] = "ocean"
				tilemap.set_cellv(pos, tiles[random_tile(biome_data,"ocean")])
			
			#Beach
			elif between(alt, 0.2, 0.25):
				biome[pos] = "beach"
				tilemap.set_cellv(pos, tiles[random_tile(biome_data,"beach")])
			#Other Biomes
			elif between(alt, 0.25, 0.8):
				#plains
				if between(moist, 0, 0.9) and between(temp, 0, 0.6):
					biome[pos] = "plains"
					tilemap.set_cellv(pos, tiles[random_tile(biome_data,"plains")])
				#jungle
				elif between(moist, 0.4, 0.9) and temp > 0.6:
					biome[pos] = "jungle"
					tilemap.set_cellv(pos, tiles[random_tile(biome_data,"jungle")])
				#desert
				elif temp > 0.6 and moist < 0.4:
					biome[pos] = "desert"
					tilemap.set_cellv(pos, tiles[random_tile(biome_data,"desert")])
				#lakes
				elif moist >= 0.9:
					biome[pos] = "lake"
					tilemap.set_cellv(pos, tiles[random_tile(biome_data,"lake")])
			#Mountains
			elif between(alt, 0.8, 0.95):
				biome[pos] = "mountain"
				tilemap.set_cellv(pos, tiles[random_tile(biome_data,"mountain")])
			#Snow
			else:
				biome[pos] = "snow"
				tilemap.set_cellv(pos, tiles[random_tile(biome_data,"snow")])


func between(val, start, end):
	if start <= val and val < end:
		return true


# Called when the node enters the scene tree for the first time.
func _ready():
	temperature = generate_map(300, 5)
	moisture = generate_map(300, 5)
	altitude = generate_map(150, 5)
	set_tile(map_width, map_height)
	$Player.connect("entered_portal", self, "exit_world")
	$Player.connect("status_changed", self, "update_hud")
	var tile_obj = load("res://ui/UIObjective.tscn")
	var tile_inst
	for obj in mission_data.objectives.primary:
		tile_inst = tile_obj.instance()
		$UI/UIObjectiveList/Body/PrimaryList.add_child(tile_inst)
		tile_inst.set_objective(obj)
		spawn_primary(obj, tile_inst)
	for obj in mission_data.objectives.secondary:
		tile_inst = tile_obj.instance()
		$UI/UIObjectiveList/Body/SecondaryList.add_child(tile_inst)
		tile_inst.set_objective(obj)
		spawn_secondary(obj, tile_inst)


func spawn_primary(obj, tile):
	var spawn_obj = OBJECT_LIST[obj.target]
	var spawn_inst
	for i in obj.amount:
		spawn_inst = spawn_obj.instance()
		get_parent().add_child(spawn_inst)
		spawn_inst.position = spawners[i]
		target_list[spawn_inst] = tile
		spawn_inst.connect(obj.signal, self, "update_objectives")


func spawn_secondary(obj, tile):
	var spawn_obj = OBJECT_LIST[obj.target]
	var spawn_inst
	for i in obj.amount:
		spawn_inst = spawn_obj.instance()
		get_parent().add_child(spawn_inst)
		spawn_inst.position = depots[i]
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
	var err = get_tree().change_scene(Game.prev_scene)
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

