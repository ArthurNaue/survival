extends StaticBody2D
class_name ResourceObjects

@export var stats: ResourceObjectsStats

@export_group("nodes")
@export var sprite: Sprite2D

func _ready() -> void:
	sprite.texture = stats.sprite

func _on_tree_exited() -> void:
	WorldManager.spawnedResourceObjects += 1
	WorldManager.spawn_item_drop(stats.drop, 1, global_position)
