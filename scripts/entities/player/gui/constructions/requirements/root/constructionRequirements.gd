extends Node2D
class_name ConstructionRequirementsGUI

var construction: ConstructionObjectsStats

@export_group("nodes")
@export var colorRect1: ColorRect
@export var colorRect2: ColorRect
@export_group("")

func _ready() -> void:
	create_requirements()

func create_requirements() -> void:
	var requirements = construction.requirementNumber
	var yRequirement = 30
	for requirement in requirements:
		colorRect1.size.y += 60
		colorRect2.size.y += 60
		var text := RichTextLabel.new()
		var sprite := Sprite2D.new()
		text.size = Vector2(100, 100)
		text.bbcode_enabled = true
		if PlayerManager.check_resources(requirement):
			text.text = "[center]V"
		else:
			text.text = "[center]X"
		text.position.x = -20
		text.position.y = yRequirement - 10
		sprite.texture = requirement.sprite
		sprite.scale = Vector2(2, 2)
		sprite.position.x = 60
		sprite.position.y = yRequirement
		yRequirement += 60
		add_child(text)
		add_child(sprite)
