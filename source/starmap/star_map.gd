extends Control

const SCROLL_SPEED = 800.0 #pixels per second
const MISSION_COUNT = 6
const marker_obj = preload("res://starmap/map_marker.tscn")

const mission_head_text = "Mission: %s"
const mission_params_text = "Mission Parameters\n%s\n---\n%s"
const mission_outcomes_text = "Mission Outcomes\n%s"
const faction_effect_text = "%s\n--Influence: %d, Hostility: %d\n"

const faction_info_head = "Faction: %s"
const faction_info_text = "Hostility: %d%%"

@onready var map_cam = $Menu/Main/Right/Map/MapView/MapCam
@onready var mission_node = $Menu/Main/Right/Map/MapView/Missions
@onready var sector_list = $Menu/Main/Right/Map/MapView/Sectors.get_children()
@onready var ui_info_header = $Menu/Main/Right/Info/Content/Mission/Header
@onready var ui_info_params = $Menu/Main/Right/Info/Content/Mission/Body/Params
@onready var ui_info_outcomes = $Menu/Main/Right/Info/Content/Mission/Body/Outcomes
@onready var ui_intel_list = $Menu/Main/Right/Info/Content/Intel/IntelList
@onready var ui_mission_list = $Menu/Main/Left/Missions/Content/MissionList
@onready var ui_faction_list = $Menu/Main/Left/Factions/Content/FactionList

var mission_list = []
var faction_list = []
var intel_list = []
var focus_index = 0: set = set_focus


func set_focus(value):
	focus_index = clamp(value, 0, sector_list.size()-1)
	var tween_cam = create_tween()
	tween_cam.tween_property(map_cam, "position", sector_list[focus_index].position, 1.0)
	tween_cam.play()


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
	faction_list = Game.factions
	for faction in faction_list:
		ui_faction_list.add_item(faction.name, load("res://ui/icons/icon_arm0.png"))
		ui_faction_list.set_item_metadata(-1, faction)
	intel_list = Game.intel
	for intel in intel_list:
		ui_intel_list.add_item(intel.title, load("res://ui/icons/icon_cube_mono.png"))
		ui_intel_list.set_item_metadata(-1, intel)


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
	var label_text = ""
	for i in MISSION_COUNT:
		mission_inst = GameData.generate_mission()
		mission_list.append(mission_inst)
		marker_inst = marker_obj.instantiate()
		mission_node.add_child(marker_inst)
		marker_inst.position = sector_list[randi() % sector_list.size()].position + Vector2(randf() * 32, randf() * 32)
		label_text = "%s\n%s" % [mission_inst.codename, mission_inst.get_short_desc()]
		ui_mission_list.add_item(label_text)
		ui_mission_list.set_item_metadata(i, {
			"marker": marker_inst,
			"data": mission_inst,
		})


func add_intel():
	pass


func _on_BtnHangar_pressed():
	Game.prev_scene = "map"
	var err = get_tree().change_scene_to_file("res://hangar/hangar.tscn")
	if err:
		print("Error changing scene!")


func _on_BtnBack_pressed():
	var err = get_tree().change_scene_to_file("res://ui/menu_title.tscn")
	if err:
		print("Error changing scene!")


func _on_BtnRun_pressed():
	var err = get_tree().change_scene_to_file("res://map/map.tscn")
	if err:
		print("Error changing scene!")


func _on_mission_list_item_selected(index):
	var mission_data = ui_mission_list.get_item_metadata(index).data
	var mission_marker = ui_mission_list.get_item_metadata(index).marker
	var faction_info = ""
	if mission_data.factions.is_empty():
		faction_info = "None"
	else:
		for mission_faction in mission_data.factions:
			for faction in faction_list:
				if faction.id == mission_faction.id:
					faction_info += faction_effect_text % [faction.name, mission_faction.influence, mission_faction.hostility]
	ui_info_header.text = mission_head_text % mission_data.codename
	ui_info_params.text = mission_params_text % [
		mission_data.get_full_desc(),
		mission_data.get_objectives(),
	]
	ui_info_outcomes.text = mission_outcomes_text % [
		faction_info,
	]
	var marker_list = mission_node.get_children()
	for marker in marker_list:
		marker.set_focus(marker == mission_marker)
	var distance = (mission_marker.position - map_cam.position).length()
	var tween_cam = create_tween()
	tween_cam.tween_property(map_cam, "position", mission_marker.position, distance / SCROLL_SPEED)
	tween_cam.play()


func _on_faction_list_item_selected(index):
	var metadata = ui_faction_list.get_item_metadata(index)
	pass # Replace with function body.


func _on_intel_list_item_selected(index):
	#$Menu/Misson/Content/Intel/Details.text = intel_info_text % item.object.name
	pass # Replace with function body.

