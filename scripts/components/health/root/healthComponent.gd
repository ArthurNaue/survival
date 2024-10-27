extends Node2D
class_name HealthComponent

@export var healthBarComponent: HealthBarComponent
@export var anim: AnimationPlayer

var maxHealth := 3
@onready var health := maxHealth

func _ready() -> void:
	if healthBarComponent:
		healthBarComponent.max_value = maxHealth

func damage(amount: int) -> void:
	health -= amount
	if healthBarComponent:
		healthBarComponent.UpdateBar.emit(health)
	if anim:
		anim.play("hit")
	if health <= 0:
		owner.queue_free()
