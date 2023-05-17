class_name Mission
extends Resource

const outline_text = "Primary Objectives:\n%s\nSecondary Objectives:\n%s\n"
const objective_text = "%s %s x %d = %d CR\n"
const desc_text = "Rating: %d\nPayout: %d - %d CR"

var codename = "Mission Codename"
var rating = 0
var revive_cost = 1000
var revive_count = 3
var map_type = 0
var factions = []
var objectives = {
	"primary":[
		{
			"type":"destroy", 
			"target":"factory",
			"signal":"enemy_dead",
			"amount":5,
			"amount_type":"count",
			"pay":1000,
		},
	],
	"secondary":[
		{
			"type":"destroy", 
			"target":"depot",
			"signal":"enemy_dead",
			"amount":5,
			"amount_type":"count",
			"pay":500,
		},
	],
}


func get_description():
	var min_pay = 0
	for obj in objectives.primary:
		min_pay += obj.pay
	var max_pay = min_pay
	for obj in objectives.secondary:
		max_pay += obj.pay
	return desc_text % [rating, min_pay, max_pay]


func get_objectives():
	var primary_list = ""
	var secondary_list = ""
	for obj in objectives.primary:
		primary_list += objective_text % [obj.type.capitalize(), obj.target, obj.amount, obj.pay]
	if objectives.secondary.empty():
		secondary_list = "None"
	else:
		for obj in objectives.secondary:
			secondary_list +=  objective_text % [obj.type.capitalize(), obj.target, obj.amount, obj.pay]
	return outline_text % [primary_list, secondary_list]
