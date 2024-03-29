extends PanelContainer

var icon = load("res://ui/icons/icon_arm0.png") setget set_icon
var title = "Item Name" setget set_title
var desc = "Item Info" setget set_desc
var data = {}
var object = null
var highlight = false setget set_highlight

signal tile_clicked(tile)


func _ready():
	$Body/Icon.texture = icon
	$Body/Text/Title.text = title
	$Body/Text/Info.text = desc


func set_icon(value):
	if value != "":
		icon = value
		$Body/Icon.texture = load(icon)


func set_title(value):
	title = value
	$Body/Text/Title.text = title


func set_highlight(value):
	highlight = value
	$Highlight.visible = highlight


func set_desc(value):
	desc = value
	$Body/Text/Info.text = desc


func _on_ListTile_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			emit_signal("tile_clicked", self)

