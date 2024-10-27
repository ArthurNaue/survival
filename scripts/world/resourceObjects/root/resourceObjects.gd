extends StaticBody2D
class_name ResourceObjects

@export var stats: ResourceObjectsStats

func _on_tree_exited() -> void:
	WorldManager.spawn_item_drop(stats.drop, global_position)
