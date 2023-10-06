extends MarginContainer

var icon_path = "res://ui/icons/icon_arm0.png"
var cooldown = 5.0


# Called when the node enters the scene tree for the first time.
func _ready():
	load_skill(icon_path, cooldown)


func _process(_delta):
	$Counter.text = "%3.1f" % $Timer.time_left
	$Icon.value = int(($Timer.time_left / cooldown) * 100)


func load_skill(icon_path, cool_time):
	cooldown = cool_time
	$Counter.hide()
	$Icon.texture_under = load(icon_path)
	$Icon.texture_progress = $Icon.texture_under
	$Icon.value = 0
	set_process(false)


func use_skill():
	set_process(true)
	$Timer.start(cooldown)
	$Counter.show()


func _on_Timer_timeout():
	$Icon.value = 0
	$Counter.hide()
	set_process(false)

