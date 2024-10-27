extends StaticBody2D
class_name ResourceObjects

@export var drop: ItemStats

func _on_tree_exited() -> void:
	WorldManager.spawn_item_drop(drop, global_position)
