extends Node

const HUB_AREAS = [
	{"title":"HANGAR", "scene":"res://hangar/hangar.tscn"},
	{"title":"STARMAP", "scene":"res://starmap/star_map.tscn"},
	{"title":"MARKET", "scene":"res://market/market.tscn"},
]
const scene_list = {
	"title":"res://ui/menu_title.tscn",
	"hangar":"res://hangar/hangar.tscn",
	"mission":"res://world/mission.tscn",
	"map":"res://starmap/star_map.tscn",
	"market":"res://market/market.tscn",
}

var current_hub_area : int
var prev_scene = null : get = get_prev_scene
var factions = []
var sectors = []
var intel = []
var inventory_equip = {
	"001":{"unlocked":true, "bought":true, "mods":[false, false, false, false, false, false, false, false, ]},
	"002":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"003":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"004":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"005":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"006":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"007":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"008":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"009":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"010":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"011":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"012":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"013":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
}
var inventory_ship = {
	"001":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"002":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
	"003":{"unlocked":true, "bought":true, "mods":[true, false, false, true, true, false, false, true,]},
}
var player_ship = {
	"ship": {
		"index": "001",
		"mods": [false, false, false, false, false, false, false, false, ],
	},
	"equip": [
		{"index":"002", "mods": [true, false, false, false, false, false, false, false, ]},
		{"index":"004", "mods": [true, false, false, false, false, false, false, false, ]},
		{"index":"003", "mods": [false, false, false, false, false, false, false, false, ]},
		{"index":"006", "mods": [false, false, false, false, false, false, false, false, ]},
		{"index":"007", "mods": [false, false, false, false, false, false, false, false, ]},
		{"index":"008", "mods": [false, false, false, false, false, false, false, false, ]},
	],
}


func get_hub_area_name():
	return HUB_AREAS[current_hub_area].title


func next_hub_area():
	current_hub_area += 1
	if current_hub_area >= HUB_AREAS.size():
		current_hub_area = 0
	return HUB_AREAS[current_hub_area].scene


func prev_hub_area():
	current_hub_area -= 1
	if current_hub_area < 0:
		current_hub_area = HUB_AREAS.size() - 1
	return HUB_AREAS[current_hub_area].scene


func get_prev_scene():
	return scene_list[prev_scene]


func get_ship_data():
	return player_ship

