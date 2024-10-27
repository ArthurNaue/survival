extends Button
class_name damageButtonComponent

@export var healthComponent: HealthComponent

func _on_pressed() -> void:
	if healthComponent:
		healthComponent.damage(1)
