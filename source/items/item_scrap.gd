extends Item

var amount = 1


func _ready():
	amount = (randi() % 100) + 1

