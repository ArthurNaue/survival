extends Node2D
class_name ResourcesGUI

@export var sprite: Sprite2D
@export var text: RichTextLabel

var value: PlayerManager.materialType

func _ready() -> void:
	update_values()

func update_values() -> void:
	sprite.texture = PlayerManager.resourcesSprites[value]
	text.text = "[center]" + str(PlayerManager.resources[value])
