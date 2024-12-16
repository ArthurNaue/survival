extends Node2D
class_name EntitiesHealthComponent

@export var healthBarComponent: HealthBarComponent

@export_range(1, 100) var maxHealth: int
@onready var health = maxHealth

func _ready() -> void:
	if healthBarComponent:
		healthBarComponent.max_value = maxHealth
		healthBarComponent.value = healthBarComponent.max_value

func damage(amount: int) -> void:
	health -= amount
	if healthBarComponent:
		healthBarComponent.UpdateBar.emit(health)
	if health <= 0:
		owner.queue_free()
