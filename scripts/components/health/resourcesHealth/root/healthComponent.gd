extends Node2D
class_name HealthComponent

@export var healthBarComponent: HealthBarComponent
@export var anim: AnimationPlayer

@onready var maxHealth = owner.stats.health
@onready var health = maxHealth

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
		GameManager.play_sound(load("res://assets/audio/resourceObjects/destructionAudio/root/resourceObjectDestruction.wav"), owner.global_position,)
		CameraManager.apply_shake(2)
		owner.queue_free()
