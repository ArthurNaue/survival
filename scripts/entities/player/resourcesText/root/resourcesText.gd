extends RichTextLabel
class_name ResourcesText

var value: PlayerManager.materialType

func _ready() -> void:
	size = Vector2(50, 50)

func update_value() -> void:
	text = str(PlayerManager.resources[value])
