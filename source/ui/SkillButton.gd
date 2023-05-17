extends TextureButton

var cooldown = 5.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = cooldown
	$Counter/Label.hide()
	$CoolDown.texture_progress = texture_normal
	$CoolDown.value = 0
	set_process(false)


func _process(_delta):
	$Counter/Label.text = "%3.1f" % $Timer.time_left
	$CoolDown.value = int(($Timer.time_left / cooldown) * 100)


func use_skill():
	if !disabled:
		disabled = true
		set_process(true)
		$Timer.start(cooldown)
		$Counter/Label.show()


func _on_Timer_timeout():
	$CoolDown.value = 0
	disabled = false
	$Counter/Label.hide()
	set_process(false)
