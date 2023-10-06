extends PanelContainer

@onready var status = $Content/ModStatus
@onready var mod_name = $Content/ModName

var mod_index = 0
var mod_info = "": set = set_info
var mod_desc = ""
var unlocked = false: set = set_unlock
var active = false: set = set_active

signal mod_clicked(mod)


func _on_ModPanel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			emit_signal("mod_clicked", self)


func set_info(val : Dictionary):
	mod_info = val.duplicate()
	mod_name.text = mod_info.name
	mod_desc = "%s\nCost: %d" % [mod_info.desc, mod_info.cost]


func set_unlock(val : bool):
	unlocked = val
	if unlocked:
		status.value = 1
	else:
		status.value = 0


func set_active(val : bool):
	if unlocked:
		active = val
		if active:
			status.modulate = Color(0,1,0)
		else:
			status.modulate = Color(1,1,1)

