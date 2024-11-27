extends AudioStreamPlayer2D
class_name GameSound

func _ready():
	finished.connect(_on_finished)

func _on_finished():
	queue_free()
