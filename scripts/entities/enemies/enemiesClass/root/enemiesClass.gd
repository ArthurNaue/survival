extends CharacterBody2D
class_name EnemiesClass

@export var navAgent: NavAgentComponent

func _physics_process(_delta: float) -> void:
	velocity = to_local(navAgent.get_next_path_position()).normalized() * 100
	
	move_and_slide()
