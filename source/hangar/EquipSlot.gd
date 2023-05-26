extends PanelContainer

export var title = ""

onready var slot_name = $Content/SlotName
onready var item_icon = $Content/Body/ItemIcon
onready var item_name = $Content/Body/ItemName
onready var item_mods = $Content/Body/Mods
onready var highlight = $Highlight

var current_slot = null

signal tile_clicked(slot)


func _ready():
	slot_name.text = title


func load_data(database, slot):
	current_slot = slot
	# Load item data from database
	var item_data = GameData.get_data(database, current_slot.index)
	# Load item's inventory data from inventory
	var inv_data
	if database == "db_equip":
		inv_data = Game.inventory_equip[current_slot.index]
	else:
		inv_data = Game.inventory_ship[current_slot.index]
	item_icon.texture = load(item_data.icon)
	item_name.text = item_data.name
	# Set available mods from inventory data
	for i in inv_data.mods.size():
		if inv_data.mods[i]:
			item_mods.get_node("Mod%d" % (i+1)).value = 1
	# Item's state from player ship data
	for i in current_slot.mods.size():
		if current_slot.mods[i]:
			item_mods.get_node("Mod%d" % (i+1)).modulate = Color(0,1,0)
		else:
			item_mods.get_node("Mod%d" % (i+1)).modulate = Color(1,1,1)


func _on_EquipSlot_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			emit_signal("tile_clicked", self)


func _on_EquipSlot_mouse_entered():
	highlight.show()


func _on_EquipSlot_mouse_exited():
	highlight.hide()

