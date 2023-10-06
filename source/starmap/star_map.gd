extends Control

const marker_obj = preload("res://starmap/map_marker.tscn")

const mission_info_text = "%s\n%s\n---\n%s"
const intel_info_text = "INTEL DETAILS\n%s"
const faction_info_text = "FACTION STATUS\n%s\nBases:%s\nFleets:%s"

const SCROLL_SPEED = 800.0 #pixels per second
const INTEL_COUNT = 4
const FACTION_COUNT = 4
const MISSION_COUNT = 6

onready var map_node = $Map
onready var mission_node = $Missions
onready var sector_list = $Sectors.get_children()

var mission_list = []
var faction_list = []
var intel_list = []
var focus_index = 0 setget set_focus


func set_focus(value):
	focus_index = clamp(value, 0, sector_list.size()-1)
	$CamTween.interpolate_property($MapCam, "position", 
		$MapCam.position, sector_list[focus_index].position,
		1.0)
	$CamTween.start()


# Called when the node enters the scene tree for the first time.
func _ready():
	gen_map()
	gen_missions()


func _process(delta):
	if Input.is_action_just_pressed("ui_focus_next"):
		self.focus_index += 1


# Run a 'turn' on the map
func run_turn(success : bool):
	if success:
		print("Mission complete!")
	else:
		print("Mission failed!")


# Generate new starmap
func gen_map():
	for i in FACTION_COUNT:
		var new_faction = GameData.generate_faction()
		faction_list.append(new_faction)
		$Menu/SideBar/Body/Tabs/Factions.add_item({
			"title": new_faction.name,
			"icon": "res://ui/icons/icon_arm0.png",
			"desc": new_faction.desc,
			"object": new_faction,
			"data": {},
		})
	for j in INTEL_COUNT:
		var new_intel = Intel.new()
		intel_list.append(new_intel)
		$Menu/SideBar/Body/Tabs/Intel.add_item({
			"title": "%s: %s" % [new_intel.name, new_intel.type],
			"icon": "res://ui/icons/icon_arm0.png",
			"desc": "%s %d" % [new_intel.type, new_intel.goal],
			"object": new_intel,
			"data": {},
		})


# Save the starmap data to file
func save_map():
	pass


# Load the starmap data from file
func load_map():
	pass


# Generate missions
func gen_missions():
	var mission_inst
	var marker_inst
	for i in MISSION_COUNT:
		mission_inst = GameData.generate_mission()
		mission_list.append(mission_inst)
		marker_inst = marker_obj.instance()
		mission_node.add_child(marker_inst)
		marker_inst.position = sector_list[randi() % sector_list.size()].position + Vector2(randf() * 32, randf() * 32)
		$Menu/SideBar/Body/Tabs/Missions.add_item({
			"title": mission_inst.codename,
			"icon": "res://ui/icons/icon_arm0.png",
			"desc": mission_inst.get_description(),
			"object": marker_inst,
			"data": mission_inst,
		})


func add_intel():
	pass


func _on_BtnHangar_pressed():
	Game.prev_scene = "map"
	var err = get_tree().change_scene("res://hangar/hangar.tscn")
	if err:
		print("Error changing scene!")


func _on_BtnBack_pressed():
	var err = get_tree().change_scene("res://ui/menu_title.tscn")
	if err:
		print("Error changing scene!")


func _on_BtnRun_pressed():
	var err = get_tree().change_scene("res://world/world.tscn")
	if err:
		print("Error changing scene!")


func _on_Missions_item_selected(item):
	$Menu/SideBar/Body/Details/Text.text = mission_info_text % [item.title, item.desc, item.data.get_objectives()]
	var marker_list = mission_node.get_children()
	for marker in marker_list:
		marker.set_focus(marker == item.object)
	var distance = (item.object.position - Vector2(256, 0) - $MapCam.position).length()
	$CamTween.interpolate_property($MapCam, "position", 
		$MapCam.position, item.object.position - Vector2(256, 0),
		distance / SCROLL_SPEED)
	$CamTween.start()


func _on_Intel_item_selected(item):
	$Menu/SideBar/Body/Details/Text.text = intel_info_text % item.object.name


func _on_Factions_item_selected(item):
	$Menu/SideBar/Body/Details/Text.text = faction_info_text % [
		item.object.name,
		item.object.bases.size(),
		item.object.fleets.size()
	]

