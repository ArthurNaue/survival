extends Node2D

@onready var campfire := WorldManager.get_world().get_node("campfire")

func _process(_delta: float) -> void:
	var distance = global_position.distance_to(campfire.global_position)
	if distance <= 150:
		visible = false
	else:
		visible = true
	look_at(campfire.global_position)
