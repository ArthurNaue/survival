extends StaticBody2D
class_name ConstructionObject

@onready var interactText = $interactText

func _on_hitbox_area_entered(_area: Area2D) -> void:
	if _area.owner.is_in_group("player"):
		interactText.visible = true

func _on_hitbox_area_exited(_area: Area2D) -> void:
	if _area.owner.is_in_group("player"):
		interactText.visible = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("E") and interactText.visible == true:
		$anim.play("use")
