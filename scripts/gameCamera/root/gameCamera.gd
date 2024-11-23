extends Camera2D
class_name GameCamera

func _ready() -> void:
	make_current()
	zoom = Vector2(4, 4)
