extends Node2D
class_name ConstructionsGUI

@export var constructionRequirementsScene: PackedScene

@export_group("nodes")
@export var sprite: Sprite2D
@export var buildButton: Button
@export_group("")

var construction: ConstructionObjectsStats
var constructionRequirements: ConstructionRequirementsGUI
var buttonEnabled := false

func _ready() -> void:
	sprite.texture = construction.sprite

func _on_build_button_pressed() -> void:
	ConstructionManager.object = construction
	ConstructionManager.turn_build_mode_on()

func _on_build_button_mouse_entered() -> void:
	buttonEnabled = true
	if !constructionRequirements:
		constructionRequirements = ConstructionRequirementsGUI.new()
		constructionRequirements.construction = construction

func _on_build_button_mouse_exited() -> void:
	buttonEnabled = false
	if constructionRequirements:
		constructionRequirements.queue_free()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("M2"):
		if buttonEnabled:
			if get_node_or_null("constructionRequirements"):
				get_node("constructionRequirements").queue_free()
			else:
				if constructionRequirements:
					var constructionRequirementGUI = constructionRequirementsScene.instantiate() as Node2D
					constructionRequirementGUI.construction = constructionRequirements.construction
					add_child(constructionRequirementGUI)
