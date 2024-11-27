extends Node2D

@export var resourceObjects: Node2D
@export var constructionObjects: Node2D

func _on_spawn_resource_object_timer_timeout() -> void:
	WorldManager.spawn_resource_object()
