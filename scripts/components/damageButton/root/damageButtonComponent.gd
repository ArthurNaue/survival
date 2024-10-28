extends Button
class_name damageButtonComponent

@export var healthComponent: HealthComponent

func _on_pressed() -> void:
	if healthComponent and ConstructionManager.buildMode == false:
		healthComponent.damage(1)
