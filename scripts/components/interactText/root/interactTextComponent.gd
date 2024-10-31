extends RichTextLabel
class_name InteractTextComponent

signal switch_visibility()

func _ready() -> void:
	switch_visibility.connect(_on_switch_visibility)
	visible = false
	size = Vector2(14, 24)
	position = Vector2(-5, -40)
	text = "E"

func _on_switch_visibility():
	visible = not visible
