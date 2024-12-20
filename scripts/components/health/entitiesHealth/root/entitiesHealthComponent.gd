extends Node2D
class_name EntitiesHealthComponent

const deathParticle := preload("res://assets/particles/deathParticle/root/deathParticle.tscn")
const damageParticle := preload("res://assets/particles/damageParticle/scene/root/damageParticle.tscn")


@export var parent: CharacterBody2D
@export var damageSound: AudioStream
@export var animation: AnimationPlayer
@export var healthBarComponent: HealthBarComponent

@onready var maxHealth = parent.stats.health
@onready var health = maxHealth

var healthBarTimer := Timer.new()

func _ready() -> void:
	if healthBarComponent:
		healthBarComponent.max_value = maxHealth
		healthBarComponent.value = healthBarComponent.max_value
	
	healthBarTimer.wait_time = 0.5
	healthBarTimer.one_shot = true
	healthBarTimer.timeout.connect(_on_healthBarTimer_timeout)
	add_child(healthBarTimer)

func damage(amount: int) -> void:
	health -= amount
	if animation:
		animation.play("damage")
	if damageSound:
		GameManager.play_sound(damageSound, global_position)
	if healthBarComponent:
		healthBarComponent.UpdateBar.emit(health)
		healthBarComponent.visible = true
		healthBarTimer.start()
	if health <= 0:
		GameManager.spawn_particle(deathParticle, global_position)
		owner.queue_free()
	else:
		GameManager.spawn_particle(damageParticle, global_position)

func _on_healthBarTimer_timeout() -> void:
	healthBarComponent.visible = false
