extends AnimatedSprite2D

func _ready():
	autoplay = "default"

func _on_Impact_animation_finished():
	queue_free()
