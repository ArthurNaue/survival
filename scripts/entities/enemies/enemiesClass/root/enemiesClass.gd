extends CharacterBody2D
class_name EnemiesClass

@export var stats: EnemiesStats

@export_group("nodes")
@export var healthComponent: EntitiesHealthComponent
@export var healthBar: HealthBarComponent
@export var navAgent: NavAgentComponent
@export var damageButton: Button
@export var animation: AnimationPlayer
@export_group("")

func _ready() -> void:
	damageButton.pressed.connect(healthComponent.damage.bind(1))
	
	if healthBar:
		healthBar.visible = false

func _physics_process(_delta: float) -> void:
	if global_position.distance_to(WorldManager.get_world().get_node("navRegion").get_node("campfire").global_position) > 35:
		velocity = to_local(navAgent.get_next_path_position()).normalized() * stats.moveSpeed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
