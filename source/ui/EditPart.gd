extends PanelContainer

onready var part_list = $Content/Body/PartList
onready var top_header = $Content/Header

var selected_slot = null
var selected_part = ""


func _ready():
	pass # Replace with function body.


func load_inventory(database, inv_data):
	var this_item
	var item_data
	for index in inv_data:
		this_item = inv_data[index]
		if this_item.unlocked:
			item_data = GameData.get_data(database, index)
			part_list.add_item({
				"title": item_data.name,
				"icon": item_data.icon,
				"desc": "Equipment Description",
				"data": {
					"index": index,
					"bought": this_item.bought,
					"mods": this_item.mods
					},
				"object": null,
			})


func open_window(slot):
	selected_slot = slot
	selected_part = slot.item_index
	top_header.text = "EDIT PART: " + slot.title
	for item in part_list.item_list:
		if item.data.index == selected_part:
			item.highlight = true
	show()


func _on_BtnConfirm_pressed():
	selected_slot.load_data("db_equip", selected_part) 
	hide()


func _on_BtnCancel_pressed():
	hide()


func _on_PartList_item_selected(item):
	selected_part = item.data.index

