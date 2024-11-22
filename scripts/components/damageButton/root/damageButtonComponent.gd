extends Button
class_name damageButtonComponent

const breakParticleScene = preload("res://assets/particles/breakParticle/scene/root/breakParticle.tscn")

@export var healthComponent: HealthComponent

func _on_pressed() -> void:
	if healthComponent and ConstructionManager.buildMode == false:
		WorldManager.spawn_particle(breakParticleScene, get_global_mouse_position())
		healthComponent.damage(1)
