extends CharacterBody2D
class_name EnemiesClass

@export var healthComponent: EntitiesHealthComponent
@export var healthBar: HealthBarComponent
@export var navAgent: NavAgentComponent
@export var damageButton: Button

func _ready() -> void:
	damageButton.pressed.connect(healthComponent.damage.bind(1))
	
	if healthBar:
		healthBar.visible = false

func _physics_process(_delta: float) -> void:
	velocity = to_local(navAgent.get_next_path_position()).normalized() * 100
	
	move_and_slide()
