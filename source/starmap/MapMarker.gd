extends Node2D

enum MarkType {MISSION, SECTOR}

onready var highlight = $Highlight

var type = MarkType.MISSION setget set_type
var is_focus = false setget set_focus


func set_type(value):
	if value in MarkType:
		type = value
	match type:
		MarkType.MISSION:
			pass
		MarkType.SECTOR:
			pass


func set_focus(value : bool):
	is_focus = value
	$Highlight.visible = is_focus

