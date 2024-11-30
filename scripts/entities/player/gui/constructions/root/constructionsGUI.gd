extends Node2D
class_name ConstructionsGUI

@export var sprite: Sprite2D
@export var buildButton: Button

var construction: ConstructionObjectsStats

func _ready() -> void:
	sprite.texture = construction.sprite

func _on_build_button_pressed() -> void:
	ConstructionManager.object = construction
	ConstructionManager.turn_build_mode_on()
