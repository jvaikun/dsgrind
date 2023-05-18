extends PanelContainer

onready var part_list = $Content/Body/PartList
onready var top_header = $Content/Header
onready var mod_list = $Content/Body/Tuning/Content/ModList
onready var mod_desc = $Content/Body/Tuning/Content/Body
onready var btn_unlock = $Content/Body/Tuning/Content/BtnUnlockMod
onready var btn_toggle = $Content/Body/Tuning/Content/BtnToggleMod

var db_name = ""
var inventory_data = null
var selected_slot = null
var selected_part = ""
var selected_mod = null


func load_inventory(database, inv_data):
	var this_item
	var item_data
	db_name = database
	inventory_data = inv_data
	for index in inventory_data:
		this_item = inventory_data[index]
		if this_item.unlocked:
			item_data = GameData.get_data(db_name, index)
			part_list.add_item({
				"title": item_data.name,
				"icon": item_data.icon,
				"desc": "Equipment Description",
				"data": index,
				"object": null,
			})


func open_window(slot):
	selected_slot = slot
	selected_part = slot.current_slot.index
	top_header.text = "EDIT PART: " + slot.title
	for item in part_list.item_list:
		item.highlight = false
		if item.data == selected_part:
			item.highlight = true
			_on_PartList_item_selected(item)
	show()


func _on_BtnUnlockMod_pressed():
	pass # Replace with function body.


func _on_BtnToggleMod_pressed():
	pass # Replace with function body.


func _on_BtnConfirm_pressed():
	var mod_flags = []
	for item in part_list.item_list:
		if item.data == selected_part:
			mod_flags = inventory_data[item.data].mods
	selected_slot.load_data(db_name, selected_slot.current_slot) 
	hide()


func _on_BtnCancel_pressed():
	hide()


func _on_PartList_item_selected(item):
	selected_part = item.data
	# Load locked/unlocked mod states from inventory data
	var this_mod
	for i in inventory_data[item.data].mods.size():
		this_mod = mod_list.get_node("Mod%d" % (i+1))
		this_mod.mod_info = GameData.get_data(db_name, item.data).mods[i]
		this_mod.unlocked = inventory_data[item.data].mods[i]
		if selected_slot.current_slot.index == selected_part:
			this_mod.active = selected_slot.current_slot.mods[i]
		else:
			this_mod.active = false


func _on_mod_clicked(mod):
	selected_mod = mod
	mod_desc.text = mod.mod_desc
	btn_unlock.visible = !mod.unlocked
	btn_toggle.visible = mod.unlocked

