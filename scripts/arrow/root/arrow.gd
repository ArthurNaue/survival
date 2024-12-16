extends Node2D

@onready var campfire := WorldManager.get_world().get_node("navRegion").get_node("campfire")

func _process(_delta: float) -> void:
	if PlayerManager.get_player().get_node("gui").visible:
		visible = true
	else:
		visible = false
	look_at(campfire.global_position)
